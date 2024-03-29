import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/product/product_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/product_arrivals_repository.dart';
import 'new_line/new_line_page.dart';

part 'package_state.dart';
part 'package_view_model.dart';

class PackagePage extends StatelessWidget {
  final ProductArrivalPackageEx packageEx;

  PackagePage({
    required this.packageEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageViewModel>(
      create: (context) => PackageViewModel(
        RepositoryProvider.of<ProductArrivalsRepository>(context),
        packageEx: packageEx
      ),
      child: _PackageView(),
    );
  }
}

class _PackageView extends StatefulWidget {
  @override
  _PackageViewState createState() => _PackageViewState();
}

class _PackageViewState extends State<_PackageView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  Future<void> showNewLineDialog() async {
    PackageViewModel vm = context.read<PackageViewModel>();

    await showDialog(
      context: context,
      builder: (BuildContext context) => NewLinePage(packageEx: vm.state.packageEx)
    );
  }

  Future<void> showProductPage(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProductPage(product: product),
        fullscreenDialog: true
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageViewModel, PackageState>(
      builder: (context, state) {
        PackageViewModel vm = context.read<PackageViewModel>();
        ProductArrivalPackage package = state.packageEx.package;

        return Scaffold(
          appBar: AppBar(
            title: Text('${package.typeName} ${package.number}. Приемка'),
            actions: !state.inProgress || state.newLineExList.isEmpty ?
              [] :
              <Widget>[IconButton(icon: const Icon(Icons.check), onPressed: vm.endAccept)]
          ),
          floatingActionButton: !state.inProgress ?
            null :
            FloatingActionButton(onPressed: showNewLineDialog, child: const Icon(Icons.add)),
          body: _lineList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case PackageStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case PackageStateStatus.success:
          case PackageStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _lineList(BuildContext context) {
    PackageViewModel vm = context.read<PackageViewModel>();
    List<Widget> lineWidgets = vm.state.packageEx.packageLines.map(
      (packageEx) => _productArrivalPackageLineTile(context, packageEx)
    ).toList();
    List<Widget> newLineWidgets = vm.state.newLineExList.map(
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

  Widget _productArrivalPackageLineTile(BuildContext context, ProductArrivalPackageLineEx lineEx) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.info),
        onPressed: () => showProductPage(lineEx.product),
        tooltip: 'Информация о товаре',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      ),
      title: Text(lineEx.product.name, style: Style.listTileText),
      trailing: Text(lineEx.line.amount.toString(), style: Style.listTileText)
    );
  }

  Widget _productArrivalPackageNewLineTile(BuildContext context, ProductArrivalPackageNewLineEx newLineEx) {
    PackageViewModel vm = context.read<PackageViewModel>();

    return Dismissible(
      key: Key(newLineEx.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteProductArrivalPackageNewLine(newLineEx),
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () => showProductPage(newLineEx.product),
          tooltip: 'Информация о товаре',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(left: 8)
        ),
        title: Text(newLineEx.product.name, style: Style.listTileText),
        trailing: Text(newLineEx.line.amount.toString(), style: Style.listTileText)
      )
    );
  }
}
