import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:stack_trace/stack_trace.dart';

class Misc {
  static final List<String> _kScannerBrands = ['Zebra'];

  static Map<String, String> stackFrame(int frame) {
    String? member = Trace.current().frames[frame + 1].member;

    if (member != null) {
      List<String> frameData = member.split('.');

      return {
        'className': frameData[0],
        'methodName': frameData[1],
      };
    }

    return {
      'className': '',
      'methodName': '',
    };
  }

  static Future<bool> hasScanner() async {
    if (Platform.isAndroid) return _kScannerBrands.contains((await DeviceInfoPlugin().androidInfo).brand);

    return false;
  }
}
