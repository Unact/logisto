import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/orders_repository.dart';

part 'orders_qr_scan_state.dart';
part 'orders_qr_scan_view_model.dart';

class OrdersQRScanPagePage extends StatelessWidget {
  OrdersQRScanPagePage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersQRScanPageViewModel>(
      create: (context) => OrdersQRScanPageViewModel(
        RepositoryProvider.of<OrdersRepository>(context),
      ),
      child: _OrdersQRScanPageView(),
    );
  }
}

class _OrdersQRScanPageView extends StatefulWidget {
  @override
  _OrdersQRScanPageViewState createState() => _OrdersQRScanPageViewState();
}

class _OrdersQRScanPageViewState extends State<_OrdersQRScanPageView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersQRScanPageViewModel, OrdersQRScanPageState>(
      builder: (context, state) {
        OrdersQRScanPageViewModel vm = context.read<OrdersQRScanPageViewModel>();

        return ScanView(
          showScanner: true,
          onRead: vm.readQRCode,
          child: vm.state.orderScanned.isEmpty ? Container() : DraggableScrollableSheet(
            initialChildSize: 0.33,
            builder: (BuildContext context, scrollController) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    ListTile(
                      trailing: TextButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: vm.confirmOrders,
                          child: Text(
                            'Завершить',
                            style: Style.listTileTitleText.merge(const TextStyle(color: Colors.black))
                          )
                        )
                      )
                    ),
                    ...vm.state.orderScanned.entries.map((e) => _scannedOrderTile(context, e))
                  ]
                )
              );
            }
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case OrdersQRScanPageStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case OrdersQRScanPageStateStatus.scanReadFailure:
            Misc.showMessage(context, state.message);
            break;
          case OrdersQRScanPageStateStatus.scanReadFinished:
            break;
          case OrdersQRScanPageStateStatus.failure:
          case OrdersQRScanPageStateStatus.success:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
        }
      }
    );
  }

  Widget _scannedOrderTile(BuildContext context, MapEntry<OrderEx, List<bool>> entry) {
    OrdersQRScanPageViewModel vm = context.read<OrdersQRScanPageViewModel>();

    return Dismissible(
      key: Key(entry.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.removeScannedOrder(entry.key),
      child: ListTile(
        title: Text('Заказ ${entry.key.order.trackingNumber}'),
        trailing: Text('Мест ${entry.value.where((k) => k).length}/${entry.key.order.packages}'),
      )
    );
  }
}
