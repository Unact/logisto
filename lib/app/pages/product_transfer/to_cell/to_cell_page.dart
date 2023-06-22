import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'to_cell_state.dart';
part 'to_cell_view_model.dart';

class ToCellPage extends StatelessWidget {
  final ProductTransferEx productTransferEx;
  final StorageCell storageCell;

  ToCellPage({
    required this.productTransferEx,
    required this.storageCell,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToCellViewModel>(
      create: (context) => ToCellViewModel(context, productTransferEx: productTransferEx, storageCell: storageCell),
      child: ScaffoldMessenger(child: _ToCellView()),
    );
  }
}

class _ToCellView extends StatefulWidget {
  @override
  ToCellViewState createState() => ToCellViewState();
}

class ToCellViewState extends State<_ToCellView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);
  late ThemeData theme = Theme.of(context);
  final TextEditingController _amountController = TextEditingController();
  FocusNode productFocus = FocusNode();
  FocusNode amountFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToCellViewModel, ToCellState>(
      builder: (context, state) {
        ToCellViewModel vm = context.read<ToCellViewModel>();
        String amount = vm.state.amount?.toString() ?? '';

        _amountController.text = amount;
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
                    items: vm.state.fromCellsProducts.map((e) => DropdownMenuItem<Product>(
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
                onPressed: vm.addProductTransferToCell,
                child: const Text('Добавить'),
              ),
              TextButton(child: const Text('Закрыть'), onPressed: () => Navigator.of(context).pop())
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ToCellStateStatus.dataLoaded:
            if (state.fromCellsProducts.isEmpty) Navigator.of(context).pop();
            break;
          case ToCellStateStatus.cellAdded:
            productFocus.requestFocus();
            break;
          case ToCellStateStatus.setProduct:
            _progressDialog.close();
            amountFocus.requestFocus();
            break;
          case ToCellStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ToCellStateStatus.success:
          case ToCellStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      }
    );
  }

  Future<void> _onScan() async {
    ToCellViewModel vm = context.read<ToCellViewModel>();

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
