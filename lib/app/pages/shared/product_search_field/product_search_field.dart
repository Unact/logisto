import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/products_repository.dart';

part 'product_search_state.dart';
part 'product_search_view_model.dart';

class ProductSearchField extends StatelessWidget {
  final FocusNode? focusNode;
  final Product? product;
  final Function(Product) onProductSelect;

  ProductSearchField({
    this.focusNode,
    this.product,
    required this.onProductSelect,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductSearchViewModel>(
      create: (context) => ProductSearchViewModel(
        RepositoryProvider.of<ProductsRepository>(context)
      ),
      child: ScaffoldMessenger(child: _ProductSearchView(
        focusNode: focusNode,
        product: product,
        onProductSelect: onProductSelect
      )),
    );
  }
}

class _ProductSearchView extends StatefulWidget {
  final FocusNode? focusNode;
  final Product? product;
  final Function(Product) onProductSelect;

  _ProductSearchView({
    this.focusNode,
    this.product,
    required this.onProductSelect,
    Key? key
  }) : super(key: key);

  @override
  ProductSearchViewState createState() => ProductSearchViewState();
}

class ProductSearchViewState extends State<_ProductSearchView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);
  late ThemeData theme = Theme.of(context);
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() { _nameController.text = widget.product?.name ?? ''; });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductSearchViewModel, ProductSearchState>(
      builder: (context, state) {
        ProductSearchViewModel vm = context.read<ProductSearchViewModel>();

        return TypeAheadField<Product>(
          hideOnError: true,
          controller: _nameController,
          focusNode: widget.focusNode,
          builder: (context, controller, focusNode) => TextField(
            style: Style.listTileText,
            focusNode: focusNode,
            autofocus: true,
            controller: controller,
            autocorrect: false,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Товар',
              suffixIcon: IconButton(icon: const Icon(CupertinoIcons.barcode), onPressed: _onScan)
            )
          ),
          emptyBuilder: (BuildContext ctx) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Ничего не найдено', style: TextStyle(color: theme.disabledColor)),
            );
          },
          suggestionsCallback: (String pattern) {
            if (pattern.length < 5) return <Product>[];

            return vm.findProductsByName(pattern);
          },
          itemBuilder: (BuildContext ctx, Product suggestion) {
            return ListTile(
              isThreeLine: false,
              title: Text(suggestion.name, style: Theme.of(context).textTheme.bodySmall)
            );
          },
          onSelected: (product) async {
            setState(() { _nameController.text = product.name; });

            vm.setProduct(product);
          }
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ProductSearchStateStatus.setProduct:
            widget.onProductSelect(state.foundProduct!);
            _progressDialog.close();
            break;
          case ProductSearchStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ProductSearchStateStatus.success:
          case ProductSearchStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          default:
            break;
        }
      }
    );
  }

  Future<void> _onScan() async {
    ProductSearchViewModel vm = context.read<ProductSearchViewModel>();

    Misc.unfocus(context);

    await Navigator.push<String>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => ScanView(
          showScanner: true,
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
            vm.findAndSetProductByCode(code);
          }
        )
      )
    );
  }
}
