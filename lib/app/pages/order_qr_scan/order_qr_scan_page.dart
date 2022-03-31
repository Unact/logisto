import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '/app/data/database.dart';
import '/app/constants/strings.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'order_qr_scan_state.dart';
part 'order_qr_scan_view_model.dart';

class OrderQRScanPage extends StatelessWidget {
  final Order order;

  OrderQRScanPage({
    required this.order,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderQRScanViewModel>(
      create: (context) => OrderQRScanViewModel(context, order: order),
      child: _OrderQRScanView(),
    );
  }
}

class _OrderQRScanView extends StatefulWidget {
  @override
  _OrderQRScanViewState createState() => _OrderQRScanViewState();
}

class _OrderQRScanViewState extends State<_OrderQRScanView> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderQRScanViewModel, OrderQRScanState>(
      builder: (context, state) {
        OrderQRScanViewModel vm = context.read<OrderQRScanViewModel>();

        return vm.state.mode == ScanMode.camera ? _CameraView() : _ScannerView();
      },
      listener: (context, state) {
        switch (state.status) {
          case OrderQRScanStateStatus.scanReadFinished:
            break;
          case OrderQRScanStateStatus.failure:
            showMessage(state.message);
            break;
          case OrderQRScanStateStatus.finished:
            Navigator.of(context).pop(true);
            break;
          default:
        }
      }
    );
  }
}

class _ScannerView extends StatefulWidget {
  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<_ScannerView> {
  @override
  Widget build(BuildContext context) {
    OrderQRScanViewModel vm = context.read<OrderQRScanViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget?>[
          !vm.state.cameraEnabled ? null : IconButton(
            color: Colors.white,
            icon: const Icon(Icons.camera),
            onPressed: () {
              vm.toggleMode(ScanMode.camera);
            }
          )
        ].whereType<Widget>().toList(),
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Center(
            child: BarcodeScannerField(onChanged: vm.readQRCode),
          ),
          Container(
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            padding: const EdgeInsets.only(top: 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Заказ ${vm.state.order.trackingNumber}',
                    style: const TextStyle(color: Colors.white, fontSize: 20)
                  )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Мест ${vm.state.orderPackageScanned.where((el) => el).length}/${vm.state.order.packages}',
                    style: const TextStyle(color: Colors.white, fontSize: 20)
                  )
                )
              ])
            )
          )
        ]
      )
    );
  }
}

class _CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<_CameraView> {
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
    OrderQRScanViewModel vm = context.read<OrderQRScanViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget?>[
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
          !vm.state.scannerEnabled ? null : IconButton(
            color: Colors.white,
            icon: const Icon(Icons.keyboard),
            onPressed: () {
              vm.toggleMode(ScanMode.scanner);
            }
          )
        ].whereType<Widget>().toList(),
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Center(
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
                    await vm.readQRCode(scanData.code);
                  }
                });
              },
              onQRViewCreated: (QRViewController controller) {
                _controller = controller;
              },
            )
          ),
          Container(
            padding: const EdgeInsets.only(top: 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Заказ ${vm.state.order.trackingNumber}',
                    style: const TextStyle(color: Colors.white, fontSize: 20)
                  )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Мест ${vm.state.orderPackageScanned.where((el) => el).length}/${vm.state.order.packages}',
                    style: const TextStyle(color: Colors.white, fontSize: 20)
                  )
                )
              ])
            )
          )
        ]
      )
    );
  }
}
