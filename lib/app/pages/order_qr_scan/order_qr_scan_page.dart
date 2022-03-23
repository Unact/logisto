import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/data/database.dart';
import '/app/constants/strings.dart';
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
  final TextEditingController _textController = TextEditingController();
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderQRScanViewModel, OrderQRScanState>(
      builder: (context, state) {
        OrderQRScanViewModel vm = context.read<OrderQRScanViewModel>();

        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.black),
          extendBodyBehindAppBar: false,
          body: Stack(
            children: [
              Center(
                child: TextField(
                  autofocus: true,
                  showCursor: false,
                  controller: _textController,
                  onChanged: vm.readQRCode,
                  decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only()),
                )
              ),
              Container(
                color: Colors.black54,
                padding: const EdgeInsets.only(top: 128),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Заказ ${state.order.trackingNumber}',
                        style: const TextStyle(color: Colors.white, fontSize: 20)
                      )
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Мест ${state.orderPackageScanned.where((el) => el).length}/${state.order.packages}',
                        style: const TextStyle(color: Colors.white, fontSize: 20)
                      )
                    )
                  ])
                )
              )
            ]
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case OrderQRScanStateStatus.scanReadFinished:
            _textController.text = '';
            break;
          case OrderQRScanStateStatus.failure:
            showMessage(state.message);
            _textController.text = '';
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
