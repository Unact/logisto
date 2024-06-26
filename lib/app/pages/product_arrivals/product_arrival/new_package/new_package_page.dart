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

part 'new_package_state.dart';
part 'new_package_view_model.dart';

class NewPackagePage extends StatelessWidget {
  final ProductArrivalEx productArrivalEx;

  NewPackagePage({
    required this.productArrivalEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewPackageViewModel>(
      create: (context) => NewPackageViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<ProductArrivalsRepository>(context),
        productArrivalEx: productArrivalEx
      ),
      child: ScaffoldMessenger(child: _NewPackageView()),
    );
  }
}

class _NewPackageView extends StatefulWidget {
  @override
  NewPackageViewState createState() => NewPackageViewState();
}

class NewPackageViewState extends State<_NewPackageView> {
  final TextEditingController _amountController = TextEditingController();
  FocusNode amountFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPackageViewModel, NewPackageState>(
      builder: (context, state) {
        NewPackageViewModel vm = context.read<NewPackageViewModel>();

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SimpleAlertDialog(
            title: const Text('Новое место приемки'),
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
                onPressed: vm.addProductArrivalPackage,
                child: const Text(Strings.ok),
              ),
              TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop())
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case NewPackageStateStatus.packagesAdded:
            Navigator.of(context).pop();
            break;
          case NewPackageStateStatus.setType:
            amountFocus.requestFocus();
            break;
          case NewPackageStateStatus.failure:
            Misc.showMessage(context, state.message);
            break;
          default:
            break;
        }
      },);
  }
}
