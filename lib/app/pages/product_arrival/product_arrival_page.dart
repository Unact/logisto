import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/product_arrival_qr_scan/product_arrival_qr_scan_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/widgets/widgets.dart';

part 'product_arrival_state.dart';
part 'product_arrival_view_model.dart';

class ProductArrivalPage extends StatelessWidget {
  final ProductArrivalEx productArrivalEx;

  ProductArrivalPage({
    required this.productArrivalEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductArrivalViewModel>(
      create: (context) => ProductArrivalViewModel(context, productArrivalEx: productArrivalEx),
      child: _ProductArrivalView(),
    );
  }
}

class _ProductArrivalView extends StatefulWidget {
  @override
  _ProductArrivalViewState createState() => _ProductArrivalViewState();
}

class _ProductArrivalViewState extends State<_ProductArrivalView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);
  final listTileStyle = const TextStyle(fontSize: 12);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showPackageQRScan() async {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    ProductArrivalPackageEx? packageEx = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProductArrivalQRScanPage(packages: vm.state.productArrivalEx.packages),
        fullscreenDialog: true
      )
    );

    vm.startAccept(packageEx);
  }

  Future<void> showPackageLineQRScan() async {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    await showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return ScanView(
          barcodeMode: true,
          child: Container(),
          onRead: (String code) {
            Navigator.of(context).pop();
            vm.addProduct(code);
          }
        );
      }
    );
  }

  Future<void> showPackageLineManualInput() async {
    //OrdersViewModel vm = context.read<OrdersViewModel>();
    TextEditingController trackingNumberController = TextEditingController();

    bool result = await showDialog<bool>(
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
    ) ?? false;

    if (!result) return;

    //await vm.findOrder(trackingNumberController.text);
  }

  Future<List<dynamic>?> showProductAddDialog() async {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    return await showDialog<List<dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        TextEditingController _nameController = TextEditingController(text: vm.state.lastFoundProduct!.name);
        TextEditingController _amountController = TextEditingController();
        int? amount;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Укажите количество'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      maxLines: null,
                      style: listTileStyle,
                      enabled: false,
                    ),
                    TextFormField(
                      maxLines: 1,
                      autofocus: true,
                      autocorrect: false,
                      onChanged: (value) => setState(() => amount = int.tryParse(_amountController.text)),
                      controller: _amountController,
                      style: listTileStyle,
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
                    await vm.addProductArrivalPackageLine(amount!);
                    Navigator.of(context).pop(null);
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
    return BlocConsumer<ProductArrivalViewModel, ProductArrivalState>(
      builder: (context, state) {
        ProductArrival productArrival = state.productArrivalEx.productArrival;

        return Scaffold(
          appBar: AppBar(
            title: Text('Приемка ${productArrival.number}'),
            actions: state.allPackagesUnloded ? [] : <Widget>[
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: showPackageQRScan,
                tooltip: 'Сканировать QR код'
              )
            ],
          ),
          body: _orderList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ProductArrivalStateStatus.productFound:
            _progressDialog.close();
            showProductAddDialog();
            break;
          case ProductArrivalStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ProductArrivalStateStatus.success:
          case ProductArrivalStateStatus.failure:
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
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();
    List<Widget> storageWidgets = vm.state.productArrivalEx.packages.map(((packageEx) {
      List<Widget> actionButtons = [];
      List<Widget> children = [];

      if (vm.state.packageInProgress == packageEx) {
        actionButtons.addAll([
          IconButton(icon: const Icon(Icons.check), onPressed: vm.endAccept),
          IconButton(icon: const Icon(Icons.text_fields), onPressed: showPackageLineManualInput),
          IconButton(icon: const Icon(CupertinoIcons.barcode), onPressed: showPackageLineQRScan)
        ]);
        children.addAll(vm.state.newLines.map((e) => _productArrivalPackageNewLineTile(context, e)));
      } else {
        children.addAll(packageEx.packageLines.map((e) => _productArrivalPackageLineTile(context, e)));
      }

      return ExpansionTile(
        title: Text("Место ${packageEx.package.number}", style: const TextStyle(fontSize: 14)),
        trailing: packageEx.package.acceptStart != null && packageEx.package.acceptEnd == null ?
          Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, children: actionButtons) :
          null,
        controlAffinity: ListTileControlAffinity.leading,
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        children: children
      );
    })).toList();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: storageWidgets
    );
  }

  Widget _productArrivalPackageLineTile(BuildContext context, ProductArrivalPackageLine line) {
    return ListTile(
      title: Text(line.productName, style: listTileStyle),
      trailing: Text(line.amount.toString(), style: listTileStyle)
    );
  }

  Widget _productArrivalPackageNewLineTile(BuildContext context, ProductArrivalPackageNewLine newLine) {
    return ListTile(
      title: Text(newLine.productName, style: listTileStyle),
      trailing: Text(newLine.amount.toString(), style: listTileStyle)
    );
  }
}
