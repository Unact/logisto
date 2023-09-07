import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as blue;
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as blue_serial;
import 'package:u_app_utils/u_app_utils.dart';

class Printer {
  static const int kPaperWidth = 560;
  static final BluetoothManager _bluetoothManager = BluetoothManager.instance;
  static const String _printerNamePostfix = 'XP-P323B';
  final Duration _connectTimeout = const Duration(seconds: 3);
  final Duration _scanTimeout = const Duration(seconds: 2);
  final Duration _writeTimeout = const Duration(seconds: 3);

  Printer();

  Future<BluetoothDevice?> _findBTDeviceAndroid() async {
    blue_serial.FlutterBluetoothSerial bluetooth = blue_serial.FlutterBluetoothSerial.instance;

    List<blue_serial.BluetoothDiscoveryResult> results = [];
    StreamSubscription<blue_serial.BluetoothDiscoveryResult> subscription = bluetooth.startDiscovery().
      listen((r) => results.add(r));
    await Future.delayed(_scanTimeout);
    await subscription.cancel();

    List<blue_serial.BluetoothDevice> devices = results.map((result) => result.device).toList();
    bool search(blue_serial.BluetoothDevice device) => (device.name ?? '').contains(_printerNamePostfix);

    blue_serial.BluetoothDevice? device = devices.firstWhereOrNull(search);

    if (device == null) return null;

    return BluetoothDevice.fromJson({'address': device.address, 'name': device.name});
  }

  Future<BluetoothDevice?> _findBTDeviceIos() async {
    List<BluetoothDevice> devices = await _bluetoothManager.startScan(timeout: _scanTimeout);
    return devices.firstWhereOrNull((e) => e.name?.contains(_printerNamePostfix) ?? false);
  }

  Future<void> printLabel(String labelCommand, { required Function onError }) async {
    if (await blue.FlutterBluePlus.adapterState.first != blue.BluetoothAdapterState.on) {
      onError.call('Не включен Bluetooth');

      return;
    }

    if (!await Permissions.hasBluetoothPermission()) {
      onError.call('Не разрешено соединение по Bluetooth');

      return;
    }

    List<int> data = utf8.encode(labelCommand).toList();

    if (Platform.isIOS) {
      BluetoothDevice? device = await _findBTDeviceIos();

      if (device == null) {
        onError.call('Не найден принтер');

        return;
      }

      if (await _bluetoothManager.connect(device) != null) {
        onError.call('Не удалось установить соединение');

        return;
      }

      await Future.delayed(_connectTimeout);

      await _bluetoothManager.writeData(data);
      await Future.delayed(_writeTimeout);
      await _bluetoothManager.disconnect();
      await _bluetoothManager.destroy();
    } else {
      BluetoothDevice? device = await _findBTDeviceAndroid();

      if (device == null) {
        onError.call('Не найден принтер');

        return;
      }

      if (await _bluetoothManager.connect(device) != true) {
        onError.call('Не удалось установить соединение');

        return;
      }

      await Future.delayed(_connectTimeout);

      if (!await _bluetoothManager.isConnected) {
        onError.call('Потеряно соединение');

        return;
      }

      await _bluetoothManager.writeData(data);
      await Future.delayed(_writeTimeout);
      await _bluetoothManager.disconnect();
      await _bluetoothManager.destroy();
    }
  }
}
