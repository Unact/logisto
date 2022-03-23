import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/order/order_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';

part 'orders_state.dart';
part 'orders_view_model.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersViewModel>(
      create: (context) => OrdersViewModel(context),
      child: _OrdersView(),
    );
  }
}

class _OrdersView extends StatefulWidget {
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<_OrdersView> {
  Completer<void> _dialogCompleter = Completer();

  Future<void> openDialog() async {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false
    );
    await _dialogCompleter.future;
    Navigator.of(context, rootNavigator: true).pop();
  }

  void closeDialog() {
    _dialogCompleter.complete();
    _dialogCompleter = Completer();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showManualInput() async {
    OrdersViewModel vm = context.read<OrdersViewModel>();
    TextEditingController trackingNumberController = TextEditingController();

    bool result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                enableInteractiveSelection: false,
                controller: trackingNumberController,
                onChanged: (String value) {
                  List<String> qrCodeData = value.split(' ');

                  if (qrCodeData.length < 3 || qrCodeData[0] != Strings.qrCodeVersion) return;

                  final tracking = qrCodeData[1];
                  final selection = TextSelection.fromPosition(TextPosition(offset: tracking.length));

                  trackingNumberController.text = tracking;
                  trackingNumberController.selection = selection;
                },
                decoration: const InputDecoration(labelText: 'Трекинг'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text('Подтвердить')
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Отменить')
            )
          ]
        );
      }
    );

    if (!result) return;

    await vm.findOrder(trackingNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersViewModel, OrdersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Заказы')),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.search),
            onPressed: showManualInput
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
            children: state.ordersWithLines.map((e) => _orderTile(context, e)).toList()
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case OrdersStateStatus.inProgress:
            openDialog();
            break;
          case OrdersStateStatus.failure:
            showMessage(state.message);
            closeDialog();
            break;
          case OrdersStateStatus.success:
            closeDialog();
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => OrderPage(orderWithLines: state.foundOrderWithLine!)
                )
              );
            });
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _orderTile(BuildContext context, OrderWithLines orderWithLines) {
    return ListTile(
      dense: true,
      leading: Text('Заказ ${orderWithLines.order.trackingNumber}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => OrderPage(orderWithLines: orderWithLines))
        );
      },
    );
  }
}
