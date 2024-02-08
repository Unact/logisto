import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/qr_types.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/orders_repository.dart';
import '/app/repositories/users_repository.dart';
import '/app/widgets/widgets.dart';
import 'order/order_page.dart';

part 'orders_state.dart';
part 'orders_view_model.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersViewModel>(
      create: (context) => OrdersViewModel(
        RepositoryProvider.of<OrdersRepository>(context),
        RepositoryProvider.of<UsersRepository>(context)
      ),
      child: _OrdersView(),
    );
  }
}

class _OrdersView extends StatefulWidget {
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<_OrdersView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  Future<void> showManualInput() async {
    OrdersViewModel vm = context.read<OrdersViewModel>();
    TextEditingController trackingNumberController = TextEditingController();

    bool result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return SimpleAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                enableInteractiveSelection: false,
                controller: trackingNumberController,
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
    ) ?? false;

    if (!result) return;

    await vm.findOrder(trackingNumberController.text);
  }

  Future<void> showQRScan() async {
    OrdersViewModel vm = context.read<OrdersViewModel>();

    await SimpleQRScanDialog(
      context: context,
      qrType: QRType.order,
      onScan: (qrCodeData) => vm.findOrder(qrCodeData[4])
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersViewModel, OrdersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Заказы'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: showQRScan,
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
      listener: (context, state) async {
        switch (state.status) {
          case OrdersStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case OrdersStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          case OrdersStateStatus.success:
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => OrderPage(orderEx: state.foundOrderEx!)
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
    List<Widget> storageWidgets = vm.state.storages.map(((storage) {
      List<OrderEx> toOrders = vm.state.orderExList
        .where((e) => e.storageTo == storage).toList();
      List<OrderEx> fromOrders = vm.state.orderExList
        .where((e) => e.storageFrom == storage && e.order.storageAccepted == null).toList();

      return ExpansionTile(
        title: Text(storage.name, style: const TextStyle(fontSize: 14)),
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        children: (toOrders + fromOrders).map((e) => _orderTile(context, e, storage)).toList()
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

  Widget _orderTile(BuildContext context, OrderEx orderEx, Storage? storage) {
    Icon? fromIcon = orderEx.storageFrom == storage && orderEx.order.storageAccepted == null ?
      const Icon(Icons.arrow_circle_right_outlined, color: Colors.greenAccent) :
      null;
    Icon? toIcon = orderEx.storageTo == storage && orderEx.order.storageAccepted == null ?
      const Icon(Icons.arrow_circle_left_outlined, color: Colors.redAccent) :
      null;
    Icon defaultIcon = const Icon(Icons.check_circle_outlined, color: Colors.transparent);

    return ListTile(
      dense: true,
      leading: storage != null ? fromIcon ?? toIcon ?? defaultIcon : defaultIcon,
      title: Text('Заказ ${orderEx.order.trackingNumber}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => OrderPage(orderEx: orderEx))
        );
      },
    );
  }
}
