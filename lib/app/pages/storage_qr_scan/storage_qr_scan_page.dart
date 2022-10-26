import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';

part 'storage_qr_scan_state.dart';
part 'storage_qr_scan_view_model.dart';

class StorageQrScanPage extends StatelessWidget {
  final List<Storage> storages;

  StorageQrScanPage({
    Key? key,
    required this.storages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StorageQrScanViewModel>(
      create: (context) => StorageQrScanViewModel(context, storages: storages),
      child: _StorageQrScanView(),
    );
  }
}

class _StorageQrScanView extends StatefulWidget {
  @override
  _StorageQrScanViewState createState() => _StorageQrScanViewState();
}

class _StorageQrScanViewState extends State<_StorageQrScanView> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorageQrScanViewModel, StorageQrScanState>(
      builder: (context, state) {
        StorageQrScanViewModel vm = context.read<StorageQrScanViewModel>();

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
          case StorageQrScanStateStatus.scanReadFinished:
            break;
          case StorageQrScanStateStatus.failure:
            showMessage(state.message);
            break;
          case StorageQrScanStateStatus.finished:
            Navigator.of(context).pop(state.storage);
            break;
          default:
        }
      }
    );
  }
}
