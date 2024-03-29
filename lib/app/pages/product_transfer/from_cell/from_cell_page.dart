import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/pages/shared/product_search_field/product_search_field.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/product_transfers_repository.dart';
import '/app/repositories/products_repository.dart';
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
      create: (context) => FromCellViewModel(
        RepositoryProvider.of<ProductTransfersRepository>(context),
        RepositoryProvider.of<ProductsRepository>(context),
        productTransferEx: productTransferEx,
        storageCell: storageCell
      ),
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
  final TextEditingController _amountController = TextEditingController();
  FocusNode productFocus = FocusNode();
  FocusNode amountFocus = FocusNode();

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FromCellViewModel, FromCellState>(
      builder: (context, state) {
        FromCellViewModel vm = context.read<FromCellViewModel>();
        String amount = vm.state.amount?.toString() ?? '';

        _amountController.text = amount;
        _amountController.selection = TextSelection.fromPosition(TextPosition(offset: amount.length));

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SimpleAlertDialog(
            title: const Text('Новая позиция'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ProductSearchField(focusNode: productFocus, product: state.product, onProductSelect: vm.setProduct),
                  TextFormField(
                    focusNode: amountFocus,
                    autofocus: true,
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
                onPressed: vm.addProductTransferFromCell,
                child: const Text('Добавить'),
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
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      }
    );
  }
}
