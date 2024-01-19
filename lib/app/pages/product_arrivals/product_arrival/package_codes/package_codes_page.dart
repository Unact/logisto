import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/product/product_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/product_arrivals_repository.dart';
import 'scan/code_scan_page.dart';

part 'package_codes_state.dart';
part 'package_codes_view_model.dart';

class PackageCodesPage extends StatelessWidget {
  final ProductArrivalPackageEx packageEx;

  PackageCodesPage({
    required this.packageEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageCodesViewModel>(
      create: (context) => PackageCodesViewModel(
        RepositoryProvider.of<ProductArrivalsRepository>(context),
        packageEx: packageEx
      ),
      child: _PackageCodesView(),
    );
  }
}

class _PackageCodesView extends StatefulWidget {
  @override
  PackageCodesViewState createState() => PackageCodesViewState();
}

class PackageCodesViewState extends State<_PackageCodesView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  Future<void> showNewCodeDialog(Product product) async {
    PackageCodesViewModel vm = context.read<PackageCodesViewModel>();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CodeScanPage(packageEx: vm.state.packageEx, product: product),
        fullscreenDialog: true
      )
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

  Future<void> showConfirmationDialog(String message, Function callback) async {
    bool result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: const Text('Предупреждение'),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text(message)])),
          actions: <Widget>[
            TextButton(child: const Text(Strings.ok), onPressed: () => Navigator.of(context).pop(true)),
            TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(false))
          ],
        );
      }
    ) ?? false;

    await callback(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageCodesViewModel, PackageCodesState>(
      builder: (context, state) {
        PackageCodesViewModel vm = context.read<PackageCodesViewModel>();
        ProductArrivalPackage package = state.packageEx.package;

        return Scaffold(
          appBar: AppBar(
            title: Text('${package.typeName} ${package.number}. Маркировка'),
            actions: state.newCodes.isEmpty ?
              [] :
              <Widget>[IconButton(icon: const Icon(Icons.check), onPressed: vm.trySavePackageCodes)]
          ),
          body: _lineList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case PackageCodesStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case PackageCodesStateStatus.success:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            break;
          case PackageCodesStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          case PackageCodesStateStatus.needUserConfirmation:
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showConfirmationDialog(state.message, state.confirmationCallback);
            });
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _lineList(BuildContext context) {
    PackageCodesViewModel vm = context.read<PackageCodesViewModel>();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: vm.state.products.map(((product) => _productTile(context, product))).toList()
    );
  }

  Widget _productTile(BuildContext context, Product product) {
    PackageCodesViewModel vm = context.read<PackageCodesViewModel>();
    List<ProductArrivalPackageNewCodeEx> newCodes = vm.state.newCodes
      .where((e) => e.product == product).toList();
    int total = vm.state.packageEx.packageLines
      .where((e) => e.product == product).fold(0, (acc, el) => acc + el.line.amount);
    Widget leadingWidget = Row(mainAxisSize: MainAxisSize.min, children: [
      IconButton(
        icon: const Icon(Icons.info),
        onPressed: () => showProductPage(product),
        tooltip: 'Информация о товаре',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      ),
      IconButton(
        icon: const Icon(Icons.qr_code),
        onPressed: () => showNewCodeDialog(product),
        tooltip: 'Отсканировать код',
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(left: 8)
      )
    ]);

    return Dismissible(
      key: Key(newCodes.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteProductArrivalPackageNewCodes(product),
      child: ListTile(
        leading: leadingWidget,
        trailing: Text('${newCodes.length} из $total'),
        title: Text(product.name, style: const TextStyle(fontSize: 14))
      )
    );
  }
}
