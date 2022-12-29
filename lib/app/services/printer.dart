import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as blue;
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';

class Printer {
  static final BluetoothManager _bluetoothManager = BluetoothManager.instance;
  static const String _printerNamePostfix = 'XP-P323B';
  final Duration _scanTimeout = const Duration(seconds: 2);
  final Duration _writeTimeout = const Duration(seconds: 3);
  int? _currentState = BluetoothManager.DISCONNECTED;

  Printer();

  Future<void> printLabel(String labelCommand, { required Function onError }) async {
    if (!await blue.FlutterBluePlus.instance.isOn) {
      onError.call('Не включен Bluetooth');

      return;
    }

    List<int> data = utf8.encode(labelCommand).toList();
    List<BluetoothDevice> devices = await _bluetoothManager.startScan(timeout: _scanTimeout);
    BluetoothDevice? device = devices.firstWhereOrNull((e) => e.name?.contains(_printerNamePostfix) ?? false);

    if (device == null) {
      onError.call('Не найден принтер');

      return;
    }

    await _bluetoothManager.connect(device);
    _bluetoothManager.state.listen((state) async {
      if (_currentState == state) return;

      _currentState = state;

      if (state != BluetoothManager.CONNECTED) return;

      await _bluetoothManager.writeData(data);
      await Future.delayed(_writeTimeout);
      await _bluetoothManager.disconnect();
    });
  }
}
