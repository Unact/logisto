import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/iterables.dart';

import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/services/printer.dart';
import '/app/utils/format.dart';
import '/app/utils/permissions.dart';
import '/app/widgets/widgets.dart';
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
      create: (context) => PackageViewModel(context, packageEx: packageEx),
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

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showNewLineDialog() async {
    PackageViewModel vm = context.read<PackageViewModel>();

    await showDialog(
      context: context,
      builder: (BuildContext context) => NewLinePage(packageEx: vm.state.packageEx)
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
            FloatingActionButton(child: const Icon(Icons.add), onPressed: showNewLineDialog),
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
            showMessage(state.message);
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
          icon: const Icon(Icons.print_sharp),
          onPressed: () => vm.printProductSticker(newLineEx),
          tooltip: 'Распечатать места',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(left: 8)
        ),
        title: Text(newLineEx.product.name, style: Style.listTileText),
        trailing: Text(newLineEx.line.amount.toString(), style: Style.listTileText)
      )
    );
  }
}
