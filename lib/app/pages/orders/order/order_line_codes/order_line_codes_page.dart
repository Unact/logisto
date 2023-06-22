import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/product/product_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';
import '/app/utils/misc.dart';
import 'scan/code_scan_page.dart';

part 'order_line_codes_state.dart';
part 'order_line_codes_view_model.dart';

class OrderLineCodesPage extends StatelessWidget {
  final OrderEx orderEx;

  OrderLineCodesPage({
    required this.orderEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderLineCodesViewModel>(
      create: (context) => OrderLineCodesViewModel(context, orderEx: orderEx),
      child: _OrderLineCodesView(),
    );
  }
}

class _OrderLineCodesView extends StatefulWidget {
  @override
  OrderLineCodesViewState createState() => OrderLineCodesViewState();
}

class OrderLineCodesViewState extends State<_OrderLineCodesView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  Future<void> showNewCodeDialog(OrderLineEx orderLineEx) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CodeScanPage(orderLineEx: orderLineEx),
        fullscreenDialog: true
      )
    );
  }

  Future<void> showProductPage(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProductPage(product: product),
        fullscreenDialog: true
      )
    );
  }

  Future<void> showConfirmationDialog(String message, Function callback) async {
    bool result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: const Text('Предупреждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
          actions: <Widget>[
            TextButton(child: const Text(Strings.ok), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false))
          ],
        );
      }
    ) ?? false;

    await callback(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderLineCodesViewModel, OrderLineCodesState>(
      builder: (context, state) {
        OrderLineCodesViewModel vm = context.read<OrderLineCodesViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Маркировка'),
            actions: state.newCodes.isEmpty ?
              [] :
              <Widget>[IconButton(icon: const Icon(Icons.check), onPressed: vm.trySaveOrderLineCodes)]
          ),
          body: _lineList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case OrderLineCodesStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case OrderLineCodesStateStatus.success:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            break;
          case OrderLineCodesStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          case OrderLineCodesStateStatus.needUserConfirmation:
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showConfirmationDialog(state.message, state.confirmationCallback);
            });
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _lineList(BuildContext context) {
    OrderLineCodesViewModel vm = context.read<OrderLineCodesViewModel>();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: vm.state.productOrderLinesEx.map(((orderLineEx) => _orderLineTile(context, orderLineEx))).toList()
    );
  }

  Widget _orderLineTile(BuildContext context, OrderLineEx orderLineEx) {
    OrderLineCodesViewModel vm = context.read<OrderLineCodesViewModel>();
    List<OrderLineNewCodeEx> newCodes = vm.state.newCodes.where((e) => e.line.line == orderLineEx.line).toList();
    int total = orderLineEx.line.factAmount ?? orderLineEx.line.amount;

    Widget leadingWidget = Row(mainAxisSize: MainAxisSize.min, children: [
      IconButton(
        icon: const Icon(Icons.info),
        onPressed: () => showProductPage(orderLineEx.product!),
        tooltip: 'Информация о товаре',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      ),
      IconButton(
        icon: const Icon(Icons.qr_code),
        onPressed: () => showNewCodeDialog(orderLineEx),
        tooltip: 'Отсканировать код',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      )
    ]);

    return Dismissible(
      key: Key(newCodes.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteOrderLineNewCodes(orderLineEx),
      child: ListTile(
        leading: leadingWidget,
        trailing: Text('${newCodes.length} из $total'),
        title: Text(orderLineEx.product!.name, style: const TextStyle(fontSize: 14))
      )
    );
  }
}
