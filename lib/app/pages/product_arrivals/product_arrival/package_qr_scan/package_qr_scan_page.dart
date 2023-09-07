import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';

part 'package_qr_scan_state.dart';
part 'package_qr_scan_view_model.dart';

class PackageQRScanPage extends StatelessWidget {
  final List<ProductArrivalPackageEx> packages;

  PackageQRScanPage({
    Key? key,
    required this.packages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageQRScanViewModel>(
      create: (context) => PackageQRScanViewModel(context, packages: packages),
      child: _PackageQRScanView(),
    );
  }
}

class _PackageQRScanView extends StatefulWidget {
  @override
  _PackageQRScanViewState createState() => _PackageQRScanViewState();
}

class _PackageQRScanViewState extends State<_PackageQRScanView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageQRScanViewModel, PackageQRScanState>(
      builder: (context, state) {
        PackageQRScanViewModel vm = context.read<PackageQRScanViewModel>();

        return ScanView(
          showScanner: true,
          onRead: vm.readQRCode,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Text('Отсканируйте место приемки', style: Style.qrScanTitleText)
              )
            ]
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case PackageQRScanStateStatus.failure:
            Misc.showMessage(context, state.message);
            break;
          case PackageQRScanStateStatus.finished:
            Navigator.of(context).pop(state.packageEx);
            break;
          default:
        }
      }
    );
  }
}
