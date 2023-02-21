import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:quiver/core.dart';

import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';

part 'from_cell_state.dart';
part 'from_cell_view_model.dart';

class FromCellPage extends StatelessWidget {
  final ProductTransferEx productTransferEx;
  final StorageCell storageCell;

  FromCellPage({
    required this.productTransferEx,
    required this.storageCell,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FromCellViewModel>(
      create: (context) => FromCellViewModel(context, productTransferEx: productTransferEx, storageCell: storageCell),
      child: ScaffoldMessenger(child: _FromCellView()),
    );
  }
}

class _FromCellView extends StatefulWidget {
  @override
  FromCellViewState createState() => FromCellViewState();
}

class FromCellViewState extends State<_FromCellView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);
  late ThemeData theme = Theme.of(context);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  FocusNode productFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  ApiProduct? product;
  int? amount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FromCellViewModel, FromCellState>(
      builder: (context, state) {
        FromCellViewModel vm = context.read<FromCellViewModel>();
        String amount = vm.state.amount?.toString() ?? '';
        String name = state.product?.name ?? '';

        _amountController.text = amount;
        _amountController.selection = TextSelection.fromPosition(TextPosition(offset: amount.length));

        _nameController.text = name;
        _nameController.selection = TextSelection.fromPosition(TextPosition(offset: name.length));

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            alignment: Alignment.topCenter,
            title: const Text('Новая позиция'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TypeAheadField(
                    hideOnError: true,
                    minCharsForSuggestions: 5,
                    textFieldConfiguration: TextFieldConfiguration(
                      style: Style.listTileText,
                      autofocus: true,
                      focusNode: productFocus,
                      controller: _nameController,
                      autocorrect: false,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        labelText: 'Товар',
                        suffixIcon: IconButton(icon: const Icon(CupertinoIcons.barcode), onPressed: _onScan)
                      )
                    ),
                    noItemsFoundBuilder: (BuildContext ctx) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('Ничего не найдено', style: TextStyle(color: theme.disabledColor)),
                      );
                    },
                    suggestionsCallback: (String pattern) => vm.findProductsByName(pattern),
                    itemBuilder: (BuildContext ctx, Product suggestion) {
                      return ListTile(
                        isThreeLine: false,
                        title: Text(suggestion.name, style: Theme.of(context).textTheme.caption)
                      );
                    },
                    onSuggestionSelected: vm.setProduct
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
                child: const Text('Добавить'),
                onPressed: vm.addProductTransferFromCell,
              ),
              TextButton(child: const Text('Закрыть'), onPressed: () => Navigator.of(context).pop())
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case FromCellStateStatus.cellAdded:
            productFocus.requestFocus();
            break;
          case FromCellStateStatus.setProduct:
            _progressDialog.close();
            amountFocus.requestFocus();
            break;
          case FromCellStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case FromCellStateStatus.success:
          case FromCellStateStatus.failure:
            showMessage(state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      }
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onScan() async {
    FromCellViewModel vm = context.read<FromCellViewModel>();

    FocusScope.of(context).unfocus();

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
