import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/widgets/widgets.dart';
import 'new_line/new_line_page.dart';

part 'product_arrival_package_state.dart';
part 'product_arrival_package_view_model.dart';

class ProductArrivalPackagePage extends StatelessWidget {
  final ProductArrivalPackageEx packageEx;

  ProductArrivalPackagePage({
    required this.packageEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductArrivalPackageViewModel>(
      create: (context) => ProductArrivalPackageViewModel(context, packageEx: packageEx),
      child: _ProductArrivalPackageView(),
    );
  }
}

class _ProductArrivalPackageView extends StatefulWidget {
  @override
  _ProductArrivalPackageViewState createState() => _ProductArrivalPackageViewState();
}

class _ProductArrivalPackageViewState extends State<_ProductArrivalPackageView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);
  final listTileStyle = const TextStyle(fontSize: 12);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showNewLineDialog() async {
    ProductArrivalPackageViewModel vm = context.read<ProductArrivalPackageViewModel>();

    await showDialog(
      context: context,
      builder: (BuildContext context) => NewLinePage(packageEx: vm.state.packageEx)
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductArrivalPackageViewModel, ProductArrivalPackageState>(
      builder: (context, state) {
        ProductArrivalPackageViewModel vm = context.read<ProductArrivalPackageViewModel>();
        ProductArrivalPackage package = state.packageEx.package;

        return Scaffold(
          appBar: AppBar(
            title: Text('${package.typeName} ${package.number}'),
            actions: !state.inProgress ?
              [] :
              <Widget>[IconButton(icon: const Icon(Icons.check), onPressed: vm.endAccept)]
          ),
          floatingActionButton: !state.inProgress ?
            null :
            FloatingActionButton(child: const Icon(Icons.add), onPressed: showNewLineDialog),
          body: _orderList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
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
    ProductArrivalPackageViewModel vm = context.read<ProductArrivalPackageViewModel>();
    List<Widget> lineWidgets = vm.state.packageEx.packageLines.map(
      (packageEx) => _productArrivalPackageLineTile(context, packageEx)
    ).toList();
    List<Widget> newLineWidgets = vm.state.newLines.map(
      (packageEx) => _productArrivalPackageNewLineTile(context, packageEx)
    ).toList();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: [
        ...newLineWidgets,
        ...lineWidgets
      ]
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
