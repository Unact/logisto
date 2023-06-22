import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/product/product_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';
import '/app/utils/misc.dart';
import 'new_package_cell/new_package_cell_page.dart';

part 'package_cells_state.dart';
part 'package_cells_view_model.dart';

class PackageCellsPage extends StatelessWidget {
  final ProductArrivalPackageEx packageEx;

  PackageCellsPage({
    required this.packageEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageCellsViewModel>(
      create: (context) => PackageCellsViewModel(context, packageEx: packageEx),
      child: _PackageCellsView(),
    );
  }
}

class _PackageCellsView extends StatefulWidget {
  @override
  PackageCellsViewState createState() => PackageCellsViewState();
}

class PackageCellsViewState extends State<_PackageCellsView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  Future<void> showNewCellDialog() async {
    PackageCellsViewModel vm = context.read<PackageCellsViewModel>();

    await SimpleQRScanDialog(
      context: context,
      qrType: QRType.storageCell,
      onScan: (qrCodeData) => vm.setCell(qrCodeData[1], qrCodeData[4])
    ).show();
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
    return BlocConsumer<PackageCellsViewModel, PackageCellsState>(
      builder: (context, state) {
        PackageCellsViewModel vm = context.read<PackageCellsViewModel>();
        ProductArrivalPackage package = state.packageEx.package;

        return Scaffold(
          appBar: AppBar(
            title: Text('${package.typeName} ${package.number}. Размещение'),
            actions: state.newCells.isEmpty ?
              [] :
              <Widget>[IconButton(icon: const Icon(Icons.check), onPressed: vm.placeProducts)]
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: showNewCellDialog,
            child: const Icon(Icons.qr_code_scanner)
          ),
          body: _lineList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case PackageCellsStateStatus.setCell:
            WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => NewPackageCellPage(
                    packageEx: state.packageEx,
                    storageCell: state.storageCell!
                  )
                );
              });
              break;
          case PackageCellsStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case PackageCellsStateStatus.success:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            break;
          case PackageCellsStateStatus.failure:
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
    PackageCellsViewModel vm = context.read<PackageCellsViewModel>();
    List<Widget> storageCellWidgets = vm.state.storageCellNames.map(((storageCellName) {
      List<ProductArrivalPackageNewCellEx> newCells = vm.state.newCells
        .where((e) => e.storageCell.name == storageCellName).toList();

      return ExpansionTile(
        title: Text(storageCellName, style: const TextStyle(fontSize: 14)),
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
        children: newCells.map((packageEx) => _productArrivalPackageNewCellTile(context, packageEx)).toList()
      );
    })).toList();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: storageCellWidgets
    );
  }

  Widget _productArrivalPackageNewCellTile(BuildContext context, ProductArrivalPackageNewCellEx newCellEx) {
    PackageCellsViewModel vm = context.read<PackageCellsViewModel>();

    return Dismissible(
      key: Key(newCellEx.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteProductArrivalPackageNewCell(newCellEx),
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () => showProductPage(newCellEx.product),
          tooltip: 'Информация о товаре',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(left: 8)
        ),
        title: Text(newCellEx.product.name, style: Style.listTileText),
        trailing: Text(newCellEx.newCell.amount.toString(), style: Style.listTileText)
      )
    );
  }
}
