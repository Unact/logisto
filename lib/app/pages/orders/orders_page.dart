import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logisto/app/utils/audio.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quiver/core.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/order/order_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/utils/misc.dart';

part 'orders_state.dart';
part 'orders_view_model.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersViewModel>(
      create: (context) => OrdersViewModel(context),
      child: _OrdersView(),
    );
  }
}

class _OrdersView extends StatefulWidget {
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<_OrdersView> {
  Completer<void> _dialogCompleter = Completer();

  Future<void> openDialog() async {
    showDialog<void>(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false
    );
    await _dialogCompleter.future;
    Navigator.of(context, rootNavigator: true).pop();
  }

  void closeDialog() {
    _dialogCompleter.complete();
    _dialogCompleter = Completer();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showManualInput() async {
    OrdersViewModel vm = context.read<OrdersViewModel>();
    TextEditingController trackingNumberController = TextEditingController();

    bool result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                enableInteractiveSelection: false,
                controller: trackingNumberController,
                onChanged: (String value) {
                  List<String> qrCodeData = value.split(' ');

                  if (qrCodeData.length < 3 || qrCodeData[0] != Strings.qrCodeVersion) return;

                  final tracking = qrCodeData[1];
                  final selection = TextSelection.fromPosition(TextPosition(offset: tracking.length));

                  trackingNumberController.text = tracking;
                  trackingNumberController.selection = selection;
                },
                decoration: const InputDecoration(labelText: 'Трекинг'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text('Подтвердить')
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Отменить')
            )
          ]
        );
      }
    );

    if (!result) return;

    await vm.findOrder(trackingNumberController.text);
  }

  Future<void> showQrScan() async {
    OrdersViewModel vm = context.read<OrdersViewModel>();

    String? result = await showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return _OrderQRFindDialog();
      }
    );

    if (result == null) return;

    await vm.findOrder(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersViewModel, OrdersState>(
      builder: (context, state) {
        OrdersViewModel vm = context.read<OrdersViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Заказы'),
            actions: <Widget>[
              vm.state.hasScanner == true ? Container() : IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: showQrScan,
                tooltip: 'Сканировать QR код'
              ),
              IconButton(
                icon: const Icon(Icons.text_fields),
                onPressed: showManualInput,
                tooltip: 'Указать вручную',
              ),
            ],
          ),
          body: _orderList(context)
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case OrdersStateStatus.inProgress:
            openDialog();
            break;
          case OrdersStateStatus.failure:
            showMessage(state.message);
            closeDialog();
            break;
          case OrdersStateStatus.success:
            closeDialog();
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => OrderPage(orderExtended: state.foundOrderExtended!)
                )
              );
            });
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _orderList(BuildContext context) {
    OrdersViewModel vm = context.read<OrdersViewModel>();
    List<Widget> storageWidgets = vm.state.orderStorages.map(((orderStorage) {
      List<OrderExtended> toOrders = vm.state.orderExtendedList
        .where((e) => e.storageTo == orderStorage).toList();
      List<OrderExtended> fromOrders = vm.state.orderExtendedList
        .where((e) => e.storageFrom == orderStorage && e.order.storageAccepted == null).toList();

      return ExpansionTile(
        title: Text(orderStorage.name, style: const TextStyle(fontSize: 14)),
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        children: (toOrders + fromOrders).map((e) => _orderTile(context, e, orderStorage)).toList()
      );
    })).toList();

    if (vm.state.ordersWithoutStorage.isNotEmpty) {
      storageWidgets.add(
        ExpansionTile(
          title: const Text('Не на складе', style: TextStyle(fontSize: 14)),
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          children: vm.state.ordersWithoutStorage.map((e) => _orderTile(context, e, null)).toList()
        )
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: storageWidgets
    );
  }

  Widget _orderTile(BuildContext context, OrderExtended orderExtended, OrderStorage? orderStorage) {
    Icon? fromIcon = orderExtended.storageFrom == orderStorage && orderExtended.order.storageAccepted == null ?
      const Icon(Icons.arrow_circle_right_outlined, color: Colors.greenAccent) :
      null;
    Icon? toIcon = orderExtended.storageTo == orderStorage && orderExtended.order.storageAccepted == null ?
      const Icon(Icons.arrow_circle_left_outlined, color: Colors.redAccent) :
      null;
    Icon defaultIcon = const Icon(Icons.check_circle_outlined, color: Colors.transparent);

    return ListTile(
      dense: true,
      leading: orderStorage != null ? fromIcon ?? toIcon ?? defaultIcon : defaultIcon,
      title: Text('Заказ ${orderExtended.order.trackingNumber}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => OrderPage(orderExtended: orderExtended))
        );
      },
    );
  }
}

class _OrderQRFindDialog extends StatefulWidget {
  @override
  _OrderQRFindDialogState createState() => _OrderQRFindDialogState();
}

class _OrderQRFindDialogState extends State<_OrderQRFindDialog> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  StreamSubscription? _subscription;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    } else if (Platform.isIOS) {
      _controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.flash_on),
            onPressed: () async {
              _controller!.toggleFlash();
            }
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.switch_camera),
            onPressed: () async {
              _controller!.flipCamera();
            }
          ),
        ],
      ),
      extendBodyBehindAppBar: false,
      body: Center(
        child: QRView(
          key: _qrKey,
          formatsAllowed: const [
            BarcodeFormat.qrcode
          ],
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: 200
          ),
          onPermissionSet: (QRViewController controller, bool permission) {
            DateTime? lastScan;

            _subscription = _controller!.scannedDataStream.listen((scanData) async {
              final currentScan = DateTime.now();

              if (lastScan == null || currentScan.difference(lastScan!) > const Duration(seconds: 2)) {
                lastScan = currentScan;
                await Audio.beep();

                List<String> qrCodeData = scanData.code.split(' ');

                if (qrCodeData.length < 3 || qrCodeData[0] != Strings.qrCodeVersion) return;

                Navigator.of(context).pop(qrCodeData[1]);
              }
            });
          },
          onQRViewCreated: (QRViewController controller) {
            _controller = controller;
          },
        )
      )
    );
  }
}
