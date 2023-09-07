import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/product/product_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/widgets/widgets.dart';
import 'from_cell/from_cell_page.dart';
import 'to_cell/to_cell_page.dart';

part 'product_transfer_state.dart';
part 'product_transfer_view_model.dart';

class ProductTransferPage extends StatelessWidget {
  final ProductTransferEx productTransferEx;

  ProductTransferPage({
    required this.productTransferEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductTransferViewModel>(
      create: (context) => ProductTransferViewModel(context, productTransferEx: productTransferEx),
      child: _ProductTransferView(),
    );
  }
}

class _ProductTransferView extends StatefulWidget {
  @override
  _ProductTransferViewState createState() => _ProductTransferViewState();
}

class _ProductTransferViewState extends State<_ProductTransferView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  Future<void> showProductPage(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProductPage(product: product),
        fullscreenDialog: true
      )
    );
  }

  Future<void> showStorageCellQRScan() async {
    ProductTransferViewModel vm = context.read<ProductTransferViewModel>();

    await SimpleQRScanDialog(
      child: const Text('Отсканируйте ячейку', style: Style.qrScanTitleText),
      context: context,
      qrType: QRType.storageCell,
      onScan: (qrCodeData) => vm.scanCell(qrCodeData[1], qrCodeData[4])
    ).show();
  }

  Future<void> showGatherCancelDialog() async {
    ProductTransferViewModel vm = context.read<ProductTransferViewModel>();

    bool result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: const Text('Отменить перемещение?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Подтвердить')
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отменить')
            )
          ]
        );
      }
    ) ?? false;

    if (result) await vm.cancelGather();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductTransferViewModel, ProductTransferState>(
      builder: (context, state) {
        ProductTransferViewModel vm = context.read<ProductTransferViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Перемещение'),
            actions: [
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.check),
                onPressed: vm.state.gatherFinished ? vm.finishTransfer : vm.finishGather
              ),
              !vm.state.gatherFinished ? null : IconButton(
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: showGatherCancelDialog
              )
            ].whereType<Widget>().toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: showStorageCellQRScan,
            tooltip: 'Начать приемку',
            child: const Icon(Icons.qr_code_scanner),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
               DropdownButtonFormField(
                isExpanded: true,
                menuMaxHeight: 200,
                decoration: const InputDecoration(labelText: 'Склад отправитель'),
                value: vm.state.productTransferEx.storeFrom?.id,
                items: vm.state.productStores.map((e) => DropdownMenuItem<String>(
                  value: e.id,
                  child: Text(e.name)
                )).toList(),
                onChanged: vm.state.gatherFinished ?
                  null :
                  (String? newVal) => newVal != null ? vm.setProductStoreFrom(newVal) : null
              ),
              DropdownButtonFormField(
                isExpanded: true,
                menuMaxHeight: 200,
                decoration: const InputDecoration(labelText: 'Склад получатель'),
                value: vm.state.productTransferEx.storeTo?.id,
                items: vm.state.productStores.map((e) => DropdownMenuItem<String>(
                  value: e.id,
                  child: Text(e.name)
                )).toList(),
                onChanged: vm.state.gatherFinished ?
                  null :
                  (String? newVal) => newVal != null ? vm.setProductStoreTo(newVal) : null
              ),
              TextFormField(
                initialValue: vm.state.productTransferEx.productTransfer.comment,
                decoration: const InputDecoration(labelText: 'Комментарий'),
                style: TextStyle(color: vm.state.gatherFinished ? Theme.of(context).disabledColor : null),
                enabled: !vm.state.gatherFinished,
                onChanged: (String? newVal) => newVal != null ? vm.setComment(newVal) : null
              ),
              _fromCellsList(context),
              _toCellsList(context)
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ProductTransferStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ProductTransferStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          case ProductTransferStateStatus.success:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            break;
          case ProductTransferStateStatus.gatherFinished:
          case ProductTransferStateStatus.gatherFinishCanceled:
            Misc.showMessage(context, state.message);
            break;
          case ProductTransferStateStatus.addToCell:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) => ToCellPage(
                  productTransferEx: state.productTransferEx,
                  storageCell: state.scannedStorageCell!
                )
              );
            });
            break;
          case ProductTransferStateStatus.addFromCell:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) => FromCellPage(
                  productTransferEx: state.productTransferEx,
                  storageCell: state.scannedStorageCell!
                )
              );
            });
            break;
          default:
            break;
        }
      }
    );
  }

  Widget _fromCellsList(BuildContext context) {
    ProductTransferViewModel vm = context.read<ProductTransferViewModel>();

    List<Widget> storageCellWidgets = vm.state.fromCellStorageCellNames.map(((storageCellName) {
      List<ProductTransferFromCellEx> fromCellsEx = vm.state.productTransferEx.fromCells
        .where((e) => e.storageCell.name == storageCellName).toList();

      return ExpansionTile(
        title: Text(storageCellName, style: const TextStyle(fontSize: 14)),
        trailing: null,
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.only(left: 12),
        children: fromCellsEx.map((fromCellEx) => _productTransferFromCellTile(context, fromCellEx)).toList()
      );
    })).toList();

    return ExpansionTile(
      title: const Text('Изъятые позиции', style: Style.listTileTitleText),
      initiallyExpanded: true,
      tilePadding: const EdgeInsets.only(left: 4),
      children: storageCellWidgets
    );
  }

  Widget _productTransferFromCellTile(BuildContext context, ProductTransferFromCellEx fromCellEx) {
    ProductTransferViewModel vm = context.read<ProductTransferViewModel>();
    ListTile tile = ListTile(
      leading: IconButton(
        icon: const Icon(Icons.info),
        onPressed: () => showProductPage(fromCellEx.product),
        tooltip: 'Информация о товаре',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      ),
      title: Text(fromCellEx.product.name, style: Style.listTileText),
      trailing: Text(fromCellEx.fromCell.amount.toString(), style: Style.listTileText)
    );

    if (vm.state.gatherFinished) return tile;

    return Dismissible(
      key: Key(fromCellEx.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteFromCell(fromCellEx),
      child: tile
    );
  }

  Widget _toCellsList(BuildContext context) {
    ProductTransferViewModel vm = context.read<ProductTransferViewModel>();

    List<Widget> storageCellWidgets = vm.state.toCellStorageCellNames.map(((storageCellName) {
      List<ProductTransferToCellEx> toCellsEx = vm.state.productTransferEx.toCells
        .where((e) => e.storageCell.name == storageCellName).toList();

      return ExpansionTile(
        title: Text(storageCellName, style: const TextStyle(fontSize: 14)),
        trailing: null,
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.only(left: 12),
        children: toCellsEx.map((toCellEx) => _productTransferToCellTile(context, toCellEx)).toList()
      );
    })).toList();

    return ExpansionTile(
      title: const Text('Размещенные позиции', style: Style.listTileTitleText),
      initiallyExpanded: true,
      tilePadding: const EdgeInsets.only(left: 4),
      children: storageCellWidgets
    );
  }

  Widget _productTransferToCellTile(BuildContext context, ProductTransferToCellEx toCellEx) {
    ProductTransferViewModel vm = context.read<ProductTransferViewModel>();
    ListTile tile = ListTile(
      leading: IconButton(
        icon: const Icon(Icons.info),
        onPressed: () => showProductPage(toCellEx.product),
        tooltip: 'Информация о товаре',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      ),
      title: Text(toCellEx.product.name, style: Style.listTileText),
      trailing: Text(toCellEx.toCell.amount.toString(), style: Style.listTileText)
    );

    return Dismissible(
      key: Key(toCellEx.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteToCell(toCellEx),
      child: tile
    );
  }
}
