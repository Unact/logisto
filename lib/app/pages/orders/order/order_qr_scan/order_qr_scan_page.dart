import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';

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
      create: (context) => OrderQRScanViewModel(order: order),
      child: _OrderQRScanView(),
    );
  }
}

class _OrderQRScanView extends StatefulWidget {
  @override
  _OrderQRScanViewState createState() => _OrderQRScanViewState();
}

class _OrderQRScanViewState extends State<_OrderQRScanView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderQRScanViewModel, OrderQRScanState>(
      builder: (context, state) {
        OrderQRScanViewModel vm = context.read<OrderQRScanViewModel>();

        return ScanView(
          showScanner: true,
          onRead: vm.readQRCode,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Заказ ${vm.state.order.trackingNumber}',
                  style: Style.qrScanTitleText
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Мест ${vm.state.orderPackageScanned.where((el) => el).length}/${vm.state.order.packages}',
                  style: Style.qrScanTitleText
                )
              )
            ]
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case OrderQRScanStateStatus.scanReadFinished:
            break;
          case OrderQRScanStateStatus.failure:
            Misc.showMessage(context, state.message);
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
