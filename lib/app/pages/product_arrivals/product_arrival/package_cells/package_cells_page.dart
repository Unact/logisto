import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/widgets/widgets.dart';
import 'new_package_cell/new_package_cell_page.dart';

part 'package_cells_state.dart';
part 'package_view_cells_model.dart';

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

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showNewCellDialog() async {
    PackageCellsViewModel vm = context.read<PackageCellsViewModel>();

    await SimpleQRScanDialog(
      context: context,
      qrType: QRType.storageCell,
      onScan: (qrCodeData) => vm.setCell(qrCodeData[1], qrCodeData[4])
    ).show();
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
            child: const Icon(Icons.qr_code_scanner),
            onPressed: showNewCellDialog
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
            showMessage(state.message);
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            break;
          case PackageCellsStateStatus.failure:
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
    PackageCellsViewModel vm = context.read<PackageCellsViewModel>();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: vm.state.newCells.map((packageEx) => _productArrivalPackageNewCellTile(context, packageEx)).toList()
    );
  }

  Widget _productArrivalPackageNewCellTile(BuildContext context, ProductArrivalPackageNewCell newCell) {
    PackageCellsViewModel vm = context.read<PackageCellsViewModel>();

    return Dismissible(
      key: Key(newCell.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteProductArrivalPackageNewCell(newCell),
      child: ListTile(
        title: Text(newCell.productName, style: Style.listTileText),
        subtitle: Text(newCell.storageCellName, style: Style.listTileText),
        trailing: Text(newCell.amount.toString(), style: Style.listTileText)
      )
    );
  }
}
