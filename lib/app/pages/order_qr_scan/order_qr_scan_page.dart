import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/data/database.dart';
import '/app/constants/strings.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';

part 'order_qr_scan_state.dart';
part 'order_qr_scan_view_model.dart';

class OrderQRScanPage extends StatelessWidget {
  final Order order;

  OrderQRScanPage({
    required this.order,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderQRScanViewModel>(
      create: (context) => OrderQRScanViewModel(context, order: order),
      child: _OrderQRScanView(),
    );
  }
}

class _OrderQRScanView extends StatefulWidget {
  @override
  _OrderQRScanViewState createState() => _OrderQRScanViewState();
}

class _OrderQRScanViewState extends State<_OrderQRScanView> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderQRScanViewModel, OrderQRScanState>(
      builder: (context, state) {
        OrderQRScanViewModel vm = context.read<OrderQRScanViewModel>();

        return ScanView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Заказ ${vm.state.order.trackingNumber}',
                  style: const TextStyle(color: Colors.white, fontSize: 20)
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Мест ${vm.state.orderPackageScanned.where((el) => el).length}/${vm.state.order.packages}',
                  style: const TextStyle(color: Colors.white, fontSize: 20)
                )
              )
            ]
          ),
          onRead: vm.readQRCode
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case OrderQRScanStateStatus.scanReadFinished:
            break;
          case OrderQRScanStateStatus.failure:
            showMessage(state.message);
            break;
          case OrderQRScanStateStatus.finished:
            Navigator.of(context).pop(true);
            break;
          default:
        }
      }
    );
  }
}
