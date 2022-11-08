import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';

part 'storage_qr_scan_state.dart';
part 'storage_qr_scan_view_model.dart';

class StorageQRScanPage extends StatelessWidget {
  final List<Storage> storages;

  StorageQRScanPage({
    Key? key,
    required this.storages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StorageQRScanViewModel>(
      create: (context) => StorageQRScanViewModel(context, storages: storages),
      child: _StorageQRScanView(),
    );
  }
}

class _StorageQRScanView extends StatefulWidget {
  @override
  _StorageQRScanViewState createState() => _StorageQRScanViewState();
}

class _StorageQRScanViewState extends State<_StorageQRScanView> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorageQRScanViewModel, StorageQRScanState>(
      builder: (context, state) {
        StorageQRScanViewModel vm = context.read<StorageQRScanViewModel>();

        return ScanView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Text('Отсканируйте склад', style: TextStyle(color: Colors.white, fontSize: 20))
              )
            ]
          ),
          onRead: vm.readQRCode
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case StorageQRScanStateStatus.scanReadFinished:
            break;
          case StorageQRScanStateStatus.failure:
            showMessage(state.message);
            break;
          case StorageQRScanStateStatus.finished:
            Navigator.of(context).pop(state.storage);
            break;
          default:
        }
      }
    );
  }
}
