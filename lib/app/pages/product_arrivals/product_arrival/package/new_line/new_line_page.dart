import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/repositories/product_arrivals_repository.dart';
import '/app/pages/shared/product_search_field/product_search_field.dart';
import '/app/pages/shared/page_view_model.dart';

part 'new_line_state.dart';
part 'new_line_view_model.dart';

class NewLinePage extends StatelessWidget {
  final ProductArrivalPackageEx packageEx;

  NewLinePage({
    required this.packageEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewLineViewModel>(
      create: (context) => NewLineViewModel(
        RepositoryProvider.of<ProductArrivalsRepository>(context),
        packageEx: packageEx
      ),
      child: ScaffoldMessenger(child: _NewLineView()),
    );
  }
}

class _NewLineView extends StatefulWidget {
  @override
  NewLineViewState createState() => NewLineViewState();
}

class NewLineViewState extends State<_NewLineView> {
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
    return BlocConsumer<NewLineViewModel, NewLineState>(
      builder: (context, state) {
        NewLineViewModel vm = context.read<NewLineViewModel>();
        String amount = vm.state.amount?.toString() ?? '';

        _amountController.text = vm.state.amount?.toString() ?? '';
        _amountController.selection = TextSelection.fromPosition(TextPosition(offset: amount.length));

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            alignment: Alignment.topCenter,
            title: const Text('Новая позиция'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ProductSearchField(focusNode: productFocus, product: state.product, onProductSelect: vm.setProduct),
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
                onPressed: vm.addProductArrivalPackageNewLine,
                child: const Text(Strings.ok),
              ),
              TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop())
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case NewLineStateStatus.lineAdded:
            productFocus.requestFocus();
            break;
          case NewLineStateStatus.setProduct:
            _progressDialog.close();
            amountFocus.requestFocus();
            break;
          case NewLineStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case NewLineStateStatus.success:
          case NewLineStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      },);
  }
}
