import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/product_arrival/product_arrival_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/utils/format.dart';
import '/app/widgets/widgets.dart';

part 'product_arrivals_state.dart';
part 'product_arrivals_view_model.dart';

class ProductArrivalsPage extends StatelessWidget {
  ProductArrivalsPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductArrivalsViewModel>(
      create: (context) => ProductArrivalsViewModel(context),
      child: _ProductArrivalsView(),
    );
  }
}

class _ProductArrivalsView extends StatefulWidget {
  @override
  _ProductArrivalsViewState createState() => _ProductArrivalsViewState();
}

class _ProductArrivalsViewState extends State<_ProductArrivalsView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<List<dynamic>?> showEndDialog(ProductArrivalEx productArrivalEx) async {
    ProductArrivalsViewModel vm = context.read<ProductArrivalsViewModel>();

    return await showDialog<List<dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        TextEditingController _amountController = TextEditingController();
        int? amount;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Укажите количество мест'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      maxLines: 1,
                      autofocus: true,
                      autocorrect: false,
                      onChanged: (value) => setState(() => amount = int.tryParse(_amountController.text)),
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Кол-во')
                    )
                  ]
                )
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(Strings.ok),
                  onPressed: amount == null ? null : () async {
                    Navigator.of(context).pop(null);
                    await vm.endUnload(productArrivalEx, amount!);
                  }
                ),
                TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(null))
              ],
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductArrivalsViewModel, ProductArrivalsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Разгрузка')),
          body: _orderList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ProductArrivalsStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ProductArrivalsStateStatus.success:
          case ProductArrivalsStateStatus.failure:
            showMessage(state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _orderList(BuildContext context) {
    ProductArrivalsViewModel vm = context.read<ProductArrivalsViewModel>();
    List<Widget> storageWidgets = vm.state.storages.map(((storage) {
      List<ProductArrivalEx> productArrivals = vm.state.productArrivalExList
        .where((e) => e.storage == storage).toList();

      return ExpansionTile(
        title: Text(storage.name, style: const TextStyle(fontSize: 14)),
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        children: productArrivals.map((e) => _productArrivalTile(context, e)).toList()
      );
    })).toList();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: storageWidgets
    );
  }

  Widget _productArrivalTile(BuildContext context, ProductArrivalEx productArrivalEx) {
    ProductArrivalsViewModel vm = context.read<ProductArrivalsViewModel>();
    ProductArrival productArrival = productArrivalEx.productArrival;
    List<Widget> actionButtons = [];

    if (productArrival.unloadStart == null) {
      actionButtons.add(IconButton(
        icon: const Icon(Icons.start),
        onPressed: () => vm.startUnload(productArrivalEx)
      ));
    }

    if (actionButtons.isEmpty && productArrival.unloadEnd == null) {
      actionButtons.add(IconButton(
        icon: const Icon(Icons.task),
        onPressed: () => showEndDialog(productArrivalEx)
      ));
    }

    if (actionButtons.isEmpty) {
      actionButtons.add(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ProductArrivalPage(productArrivalEx: productArrivalEx)
            )
          );
        }
      ));
    }

    return ListTile(
      title: Text('${productArrival.number} от ${Format.dateStr(productArrival.arrivalDate)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: actionButtons
      ),
      onTap: null
    );
  }
}
