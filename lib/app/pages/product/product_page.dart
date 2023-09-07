import 'dart:async';

import 'package:cross_file/cross_file.dart';
import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/labels/product_label.dart';
import '/app/pages/shared/page_view_model.dart';

part 'product_state.dart';
part 'product_view_model.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage({
    required this.product,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductViewModel>(
      create: (context) => ProductViewModel(context, product: product),
      child: _ProductView(),
    );
  }
}

class _ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<_ProductView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  Future<void> showProductLabelPrintDialog(ApiProductBarcode productBarcode) async {
    ProductViewModel vm = context.read<ProductViewModel>();
    int? amount;

    bool result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              alignment: Alignment.topCenter,
              title: const Text('Укажите кол-во этикеток'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: (newAmount) => setState(() => amount = int.tryParse(newAmount)),
                    decoration: const InputDecoration(labelText: 'Кол-во'),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: amount != null && amount! > 0 ? () => Navigator.of(context).pop(true) : null,
                  child: const Text('Подтвердить')
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Отменить')
                )
              ]
            );
          }
        );
      }
    ) ?? false;

    if (!result) return;

    await vm.printProductLabel(productBarcode, amount!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductViewModel, ProductState>(
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Товар'),
          ),
          body: _buildBody(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ProductStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ProductStateStatus.failure:
            _progressDialog.close();
            Misc.showMessage(context, state.message);
            break;
          case ProductStateStatus.success:
            _progressDialog.close();
            break;
          default:
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    ProductViewModel vm = context.read<ProductViewModel>();
    ProductState state = vm.state;
    Product product = state.product;

    return ListView(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      children: [
        InfoRow(title: const Text('Группа'), trailing: Text(product.groupName)),
        InfoRow(title: const Text('Название'), trailing: Text(product.name)),
        InfoRow(title: const Text('Артикул'), trailing: Text(product.article ?? '')),
        InfoRow(
          title: const Text('Вес, кг'),
          trailing: Text(product.weight != null ? (product.weight!~/1000).toString() : '')
        ),
        InfoRow(
          title: const Text('Длина, см'),
          trailing: Text(product.length != null ? (product.length!~/10).toString() : '')
        ),
        InfoRow(
          title: const Text('Высота, см'),
          trailing: Text(product.height != null ? (product.height!~/10).toString() : '')
        ),
        InfoRow(
          title: const Text('Ширина, см'),
          trailing: Text(product.width != null ? (product.width!~/10).toString() : '')
        ),
        InfoRow(title: const Text('Архив'), trailing: Text(product.archived ? 'Да' : 'Нет')),
        ExpansionTile(
          initiallyExpanded: true,
          title: const Text('Штрихкоды', style: Style.listTileTitleText),
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            ...vm.state.productBarcodes.map((e) => _productBarcodeTile(context, e)),
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8),
              child: Align(
                alignment: Alignment.centerRight,
                heightFactor: 0.75,
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.green),
                  onPressed: _onScan,
                  child: const Text('Добавить')
                )
              )
            )
          ]
        ),
        ExpansionTile(
          initiallyExpanded: true,
          title: const Text('Изображения', style: Style.listTileTitleText),
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            ...vm.state.productImages.map((e) => _productImageTile(context, e)),
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8),
              child: Align(
                alignment: Alignment.centerRight,
                heightFactor: 0.75,
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.green),
                  onPressed: _onTakePicture,
                  child: const Text('Добавить')
                )
              )
            )
          ]
        ),
      ]
    );
  }

  Widget _productBarcodeTile(BuildContext context, ApiProductBarcode productBarcode) {
    return ListTile(
      title: Text(productBarcode.code, style: Style.listTileText),
      leading: IconButton(
        icon: const Icon(Icons.print_sharp),
        onPressed: () => showProductLabelPrintDialog(productBarcode),
        tooltip: 'Информация о товаре',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      )
    );
  }

  Widget _productImageTile(BuildContext context, ApiProductImage productImage) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: RetryableImage(imageUrl: productImage.url)
      )
    );
  }

  Future<void> _onTakePicture() async {
    ProductViewModel vm = context.read<ProductViewModel>();

    await Navigator.push<String>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => CameraView(
          onError: (String message) => WidgetsBinding.instance.addPostFrameCallback(
            (_) => Misc.showMessage(context, message)
          ),
          onTakePicture: (XFile file) => vm.addProductImage(file)
        )
      )
    );
  }

  Future<void> _onScan() async {
    ProductViewModel vm = context.read<ProductViewModel>();

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
                child: const Text('Отсканируйте штрихкод', style: Style.qrScanTitleText)
              )
            ]
          ),
          onRead: (String code) {
            Navigator.of(context).pop();
            vm.addProductBarcode(code);
          }
        )
      )
    );
  }
}
