import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';

part 'order_storage_qr_scan_state.dart';
part 'order_storage_qr_scan_view_model.dart';

class OrderStorageQrScanPage extends StatelessWidget {
  final List<OrderStorage> orderStorages;

  OrderStorageQrScanPage({
    Key? key,
    required this.orderStorages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderStorageQrScanViewModel>(
      create: (context) => OrderStorageQrScanViewModel(context, orderStorages: orderStorages),
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

        return QRScanView(
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
