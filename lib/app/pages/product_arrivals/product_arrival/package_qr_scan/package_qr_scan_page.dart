import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';

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
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageQRScanViewModel, PackageQRScanState>(
      builder: (context, state) {
        PackageQRScanViewModel vm = context.read<PackageQRScanViewModel>();

        return ScanView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Text('Отсканируйте место приемки', style: TextStyle(color: Colors.white, fontSize: 20))
              )
            ]
          ),
          onRead: vm.readQRCode
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case PackageQRScanStateStatus.failure:
            showMessage(state.message);
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
