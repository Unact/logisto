import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';

part 'new_package_cell_state.dart';
part 'new_package_cell_view_model.dart';

class NewPackageCellPage extends StatelessWidget {
  final ProductArrivalPackageEx packageEx;
  final StorageCell storageCell;

  NewPackageCellPage({
    required this.packageEx,
    required this.storageCell,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewPackageCellViewModel>(
      create: (context) => NewPackageCellViewModel(context, packageEx: packageEx, storageCell: storageCell),
      child: ScaffoldMessenger(child: _NewPackageCellView()),
    );
  }
}

class _NewPackageCellView extends StatefulWidget {
  @override
  NewPackageCellViewState createState() => NewPackageCellViewState();
}

class NewPackageCellViewState extends State<_NewPackageCellView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);
  late ThemeData theme = Theme.of(context);
  final TextEditingController _amountController = TextEditingController();
  FocusNode productFocus = FocusNode();
  FocusNode amountFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPackageCellViewModel, NewPackageCellState>(
      builder: (context, state) {
        NewPackageCellViewModel vm = context.read<NewPackageCellViewModel>();
        String amount = vm.state.amount?.toString() ?? '';

        _amountController.text = vm.state.amount?.toString() ?? '';
        _amountController.selection = TextSelection.fromPosition(TextPosition(offset: amount.length));

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            alignment: Alignment.topCenter,
            title: Text('Ячейка ${state.storageCell.name}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  DropdownButtonFormField(
                    focusNode: productFocus,
                    isExpanded: true,
                    menuMaxHeight: 200,
                    style: Style.listTileText,
                    decoration: InputDecoration(
                      labelText: 'Товар',
                      labelStyle: Style.listTileText,
                      suffixIcon: IconButton(icon: const Icon(CupertinoIcons.barcode), onPressed: _onScan)
                    ),
                    value: vm.state.product,
                    items: vm.state.packageLineProducts.map((e) => DropdownMenuItem<Product>(
                      value: e,
                      child: Text(e.name, style: Style.listTileText.merge(theme.textTheme.labelMedium))
                    )).toList(),
                    onChanged: (Product? newVal) => newVal != null ? vm.setProduct(newVal) : null
                  ),
                  TextFormField(
                    focusNode: amountFocus,
                    autocorrect: false,
                    onChanged: (value) => int.tryParse(value) != null ? vm.setAmount(int.parse(value)) : null,
                    controller: _amountController,
                    style: Style.listTileText,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Кол-во')
                  )
                ]
              )
            ),
            actions: <Widget>[
              TextButton(
                onPressed: vm.addProductArrivalPackageNewPackageCell,
                child: const Text('Добавить'),
              ),
              TextButton(child: const Text('Закрыть'), onPressed: () => Navigator.of(context).pop())
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case NewPackageCellStateStatus.dataLoaded:
            if (state.packageLineProducts.isEmpty) Navigator.of(context).pop();
            break;
          case NewPackageCellStateStatus.lineAdded:
            productFocus.requestFocus();
            break;
          case NewPackageCellStateStatus.setProduct:
            _progressDialog.close();
            amountFocus.requestFocus();
            break;
          case NewPackageCellStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case NewPackageCellStateStatus.success:
          case NewPackageCellStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      },);
  }

  Future<void> _onScan() async {
    NewPackageCellViewModel vm = context.read<NewPackageCellViewModel>();

    Misc.unfocus(context);

    await Navigator.push<String>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => ScanView(
          barcodeMode: true,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Text('Отсканируйте позицию', style: Style.qrScanTitleText)
              )
            ]
          ),
          onRead: (String code) {
            Navigator.of(context).pop();
            vm.findAndSetProductByCode(code);
          }
        )
      )
    );
  }
}
