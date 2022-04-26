import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/utils/audio.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'order_storage_qr_scan_state.dart';
part 'order_storage_qr_scan_view_model.dart';

class OrderStorageQrScanPage extends StatelessWidget {
  OrderStorageQrScanPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderStorageQrScanViewModel>(
      create: (context) => OrderStorageQrScanViewModel(context),
      child: _OrderStorageQrScanView(),
    );
  }
}

class _OrderStorageQrScanView extends StatefulWidget {
  @override
  _OrderStorageQrScanViewState createState() => _OrderStorageQrScanViewState();
}

class _OrderStorageQrScanViewState extends State<_OrderStorageQrScanView> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderStorageQrScanViewModel, StorageQrScanState>(
      builder: (context, state) {
        OrderStorageQrScanViewModel vm = context.read<OrderStorageQrScanViewModel>();

        if (vm.state.hasScanner == null) return Container();

        return  vm.state.hasScanner! ? _ScannerView() : _CameraView();
      },
      listener: (context, state) {
        switch (state.status) {
          case OrderStorageQrScanStateStatus.scanReadFinished:
            break;
          case OrderStorageQrScanStateStatus.failure:
            showMessage(state.message);
            break;
          case OrderStorageQrScanStateStatus.finished:
            Navigator.of(context).pop(state.orderStorage);
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
    OrderStorageQrScanViewModel vm = context.read<OrderStorageQrScanViewModel>();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Center(
            child: BarcodeScannerField(onChanged: vm.readQr),
          ),
          Container(
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            padding: const EdgeInsets.only(top: 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Text('Отсканируйте склад', style: TextStyle(color: Colors.white, fontSize: 20))
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
    OrderStorageQrScanViewModel vm = context.read<OrderStorageQrScanViewModel>();

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
          )
        ]
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

                    await Audio.beep();
                    await vm.readQr(scanData.code);
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
                  child: const Text('Отсканируйте склад', style: TextStyle(color: Colors.white, fontSize: 20))
                )
              ])
            )
          )
        ]
      )
    );
  }
}