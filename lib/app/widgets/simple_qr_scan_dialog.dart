import 'package:flutter/material.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/widgets/scan_view.dart';

class SimpleQRScanDialog {
  final QRType qrType;
  final BuildContext context;
  final Function(List<String>) onScan;

  const SimpleQRScanDialog({
    required this.context,
    required this.qrType,
    required this.onScan
  });

  Future<void> show() async {
    List<String>? result = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => ScanView(
          child: Container(),
          onRead: (String code) {
            List<String> qrCodeData = code.split(' ');
            String version = qrCodeData[0];

            if (version != Strings.qrCodeVersion || qrCodeData[3] != qrType.typeName) return;

            return Navigator.of(context).pop(qrCodeData);
          }
        )
      )
    );

    if (result == null) return;

    await onScan(result);
  }
}
