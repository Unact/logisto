import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/product_arrivals_repository.dart';
import '/app/widgets/widgets.dart';

part 'new_unload_package_state.dart';
part 'new_unload_package_view_model.dart';

class NewUnloadPackagePage extends StatelessWidget {
  final ProductArrivalEx productArrivalEx;

  NewUnloadPackagePage({
    required this.productArrivalEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewUnloadPackageViewModel>(
      create: (context) => NewUnloadPackageViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<ProductArrivalsRepository>(context),
        productArrivalEx: productArrivalEx
      ),
      child: ScaffoldMessenger(child: _NewUnloadPackageView()),
    );
  }
}

class _NewUnloadPackageView extends StatefulWidget {
  @override
  NewUnloadPackageViewState createState() => NewUnloadPackageViewState();
}

class NewUnloadPackageViewState extends State<_NewUnloadPackageView> {
  final TextEditingController _amountController = TextEditingController();
  FocusNode amountFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewUnloadPackageViewModel, NewUnloadPackageState>(
      builder: (context, state) {
        NewUnloadPackageViewModel vm = context.read<NewUnloadPackageViewModel>();

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SimpleAlertDialog(
            title: const Text('Новое место разгрузки'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  DropdownButtonFormField(
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Тип', labelStyle: Style.listTileText),
                    items: vm.state.types.map((e) {
                      return DropdownMenuItem<PackageType>(
                        value: e,
                        child: Text(e.name, style: Style.listTileText)
                      );
                    }).toList(),
                    onChanged: (PackageType? value) => value != null ? vm.setType(value) : null
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
                onPressed: vm.addProductArrivalUnloadPackage,
                child: const Text(Strings.ok),
              ),
              TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop())
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case NewUnloadPackageStateStatus.unloadPackageAdded:
            Navigator.of(context).pop();
            break;
          case NewUnloadPackageStateStatus.setType:
            amountFocus.requestFocus();
            break;
          case NewUnloadPackageStateStatus.failure:
            Misc.showMessage(context, state.message);
            break;
          default:
            break;
        }
      },);
  }
}
