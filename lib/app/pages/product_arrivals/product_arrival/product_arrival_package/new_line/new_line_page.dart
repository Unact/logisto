import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:quiver/core.dart';

import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/widgets/widgets.dart';

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
      create: (context) => NewLineViewModel(context, packageEx: packageEx),
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  FocusNode productFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  ApiProduct? product;
  int? amount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewLineViewModel, NewLineState>(
      builder: (context, state) {
        NewLineViewModel vm = context.read<NewLineViewModel>();

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
                    itemBuilder: (BuildContext ctx, ApiProduct suggestion) {
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
                child: const Text(Strings.ok),
                onPressed: vm.addProductArrivalPackageNewLine,
              ),
              TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop())
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case NewLineStateStatus.lineAdded:
            Navigator.of(context).pop();
            break;
          case NewLineStateStatus.setProduct:
            _nameController.text = state.product!.name;
            _progressDialog.close();
            amountFocus.requestFocus();
            break;
          case NewLineStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case NewLineStateStatus.success:
          case NewLineStateStatus.failure:
            showMessage(state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      },);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onScan() async {
    NewLineViewModel vm = context.read<NewLineViewModel>();

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
                child: const Text('Отсканируйте место приемки', style: TextStyle(color: Colors.white, fontSize: 20))
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
