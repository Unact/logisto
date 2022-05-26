import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soundpool/soundpool.dart';

enum _ScanMode {
  none,
  scanner,
  camera
}

class QRScanView extends StatefulWidget {
  final Widget child;
  final Function(String)? onRead;

  QRScanView({
    required this.child,
    this.onRead,
    Key? key
  }) : super(key: key);

  @override
  _QRScanViewState createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  StreamSubscription? _subscription;
  bool _hasCamera = false;
  _ScanMode _scanMode = _ScanMode.none;
  bool _paused = false;

  static final Soundpool _kPool = Soundpool.fromOptions(options: const SoundpoolOptions());
  static final Future<int> _kBeepId = rootBundle.load('assets/beep.mp3').then((soundData) => _kPool.load(soundData));

  static Future<void> _beep() async {
    await _kPool.play(await _kBeepId);
  }

  @override
  void initState() {
    super.initState();

    _initScanMode();
  }

  Future<void> _initScanMode() async {
    _hasCamera = (await availableCameras()).isNotEmpty;
    _scanMode = _hasCamera ? _ScanMode.camera : _ScanMode.scanner;

    setState(() {});
  }

  @override
  void reassemble() {
    super.reassemble();

    if (_controller == null) return;

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
    if (_scanMode == _ScanMode.none) return Container();

    return _scanMode == _ScanMode.camera ? _buildCameraView(context) : _buildScannerView(context);
  }

  Widget _buildScannerView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget?>[
          !_hasCamera ? null : IconButton(
            color: Colors.white,
            icon: const Icon(Icons.camera),
            onPressed: () {
              setState(() => _scanMode = _ScanMode.camera);
            }
          )
        ].whereType<Widget>().toList(),
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Center(child: _BarcodeScannerField(onChanged: widget.onRead)),
          Container(
            padding: const EdgeInsets.only(top: 32),
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            child: Align(
              alignment: Alignment.topCenter,
              child: widget.child
            )
          )
        ]
      )
    );
  }

  Widget _buildCameraView(BuildContext context) {
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
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.keyboard),
            onPressed: () {
              setState(() => _scanMode = _ScanMode.scanner);
            }
          )
        ].whereType<Widget>().toList()
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

                  if (_paused) return;

                  if (lastScan == null || currentScan.difference(lastScan!) > const Duration(seconds: 2)) {
                    lastScan = currentScan;

                    setState(() => _paused = true);
                    await _beep();
                    if (widget.onRead != null) await widget.onRead!(scanData.code);
                    setState(() => _paused = false);
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
              child: widget.child
            )
          )
        ]
      )
    );
  }
}

class _BarcodeScannerField extends EditableText {
  _BarcodeScannerField({
    Key? key,
    void Function(String)? onChanged
  }) : super(
    key: key,
    autofocus: true,
    showCursor: false,
    controller: TextEditingController(),
    focusNode: _BarcodeScannerFieldFocusNode(),
    style: const TextStyle(),
    onChanged: onChanged,
    cursorColor: Colors.transparent,
    backgroundCursorColor: Colors.transparent
  );

  @override
  _BarcodeScannerFieldState createState() => _BarcodeScannerFieldState();
}

class _BarcodeScannerFieldState extends EditableTextState {
  @override
  void initState() {
    widget.focusNode.addListener(funcionListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(funcionListener);
    super.dispose();
  }

  @override
  void requestKeyboard() {
    super.requestKeyboard();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void funcionListener() {
    if (widget.focusNode.hasFocus) requestKeyboard();
  }
}

class _BarcodeScannerFieldFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
