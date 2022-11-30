import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/utils/format.dart';
import '/app/widgets/widgets.dart';
import 'new_package/new_package_page.dart';
import 'new_unload_package/new_unload_package_page.dart';
import 'package_qr_scan/package_qr_scan_page.dart';
import 'product_arrival_package/product_arrival_package_page.dart';

part 'product_arrival_state.dart';
part 'product_arrival_view_model.dart';

class ProductArrivalPage extends StatelessWidget {
  final ProductArrivalEx productArrivalEx;

  ProductArrivalPage({
    required this.productArrivalEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductArrivalViewModel>(
      create: (context) => ProductArrivalViewModel(context, productArrivalEx: productArrivalEx),
      child: _ProductArrivalView(),
    );
  }
}

class _ProductArrivalView extends StatefulWidget {
  @override
  _ProductArrivalViewState createState() => _ProductArrivalViewState();
}

class _ProductArrivalViewState extends State<_ProductArrivalView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  Future<void> navigateToPackage(ProductArrivalPackageEx packageEx) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProductArrivalPackagePage(packageEx: packageEx)
      )
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showPackageQRScan() async {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    ProductArrivalPackageEx? packageEx = await Navigator.push<ProductArrivalPackageEx>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PackageQRScanPage(packages: vm.state.productArrivalEx.packages),
        fullscreenDialog: true
      )
    );

    await vm.startAccept(packageEx);
  }

  Future<void> showNewPackageDialog() async {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    await showDialog(
      context: context,
      builder: (BuildContext context) => NewPackagePage(productArrivalEx: vm.state.productArrivalEx)
    );
  }

  Future<void> showNewUnloadPackageDialog() async {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    await showDialog(
      context: context,
      builder: (BuildContext context) => NewUnloadPackagePage(productArrivalEx: vm.state.productArrivalEx)
    );
  }

  Future<void> showQRScan() async {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => ScanView(
          child: Container(),
          onRead: (String code) {
            List<String> qrCodeData = code.split(' ');
            String version = qrCodeData[0];

            if (version == Strings.oldQRCodeVersion) return Navigator.of(context).pop(qrCodeData[1]);
            if (version == Strings.newQRCodeVersion && qrCodeData[3] == QRTypes.productArrival.typeName) {
              return Navigator.of(context).pop(qrCodeData[4]);
            }
          }
        )
      )
    );

    if (result == null) return;

    vm.markScanned(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductArrivalViewModel, ProductArrivalState>(
      builder: (context, state) {
        ProductArrival productArrival = state.productArrivalEx.productArrival;

        return Scaffold(
          appBar: AppBar(title: Text('Разгрузка ${productArrival.number}')),
          body: _dataList(context),
          floatingActionButton: state.allPackagesAcceptStarted ? null : FloatingActionButton(
            child: const Icon(Icons.qr_code_scanner),
            onPressed: showPackageQRScan,
            tooltip: 'Сканировать QR код',

          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ProductArrivalStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ProductArrivalStateStatus.scanFailed:
            showMessage(state.message);
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

  Widget _dataList(BuildContext context) {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: [
        InfoRow(
          title: const Text('Статус'),
          trailing: Text(vm.state.productArrival.statusName)
        ),
        InfoRow(
          title: const Text('Дата'),
          trailing: Text(Format.dateStr(vm.state.productArrival.arrivalDate))
        ),
        InfoRow(
          title: const Text('ИМ'),
          trailing: Text(vm.state.productArrival.sellerName)
        ),
        InfoRow(
          title: const Text('Склад ИМ'),
          trailing: Text(vm.state.productArrival.storeName)
        ),
        InfoRow(
          title: const Text('Начало'),
          trailing: !vm.state.unloadStarted ?
            _unloadStartButton(context) :
            Text(Format.dateTimeStr(vm.state.productArrival.unloadStart))
        ),
        InfoRow(
          title: const Text('Конец'),
          trailing: vm.state.unloadInProgress ?
            _unloadWorkButtons(context) :
            Text(Format.dateTimeStr(vm.state.productArrival.unloadEnd))
        ),
        ExpansionTile(
          initiallyExpanded: vm.state.unloadInProgress,
          title: const Text('Места разгрузки', style: Style.listTileTitleText),
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            ...vm.state.newUnloadPackages.map((e) => _productArrivalNewUnloadPackageTile(context, e)),
            ...vm.state.productArrivalEx.unloadPackages.map((e) => _productArrivalUnloadPackageTile(context, e)),
          ]
        ),
        ExpansionTile(
          initiallyExpanded: vm.state.unloadStarted,
          title: const Text('Места приемки', style: Style.listTileTitleText),
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            ...vm.state.newPackages.map((e) => _productArrivalNewPackageTile(context, e)),
            ...vm.state.productArrivalEx.packages.map((e) => _productArrivalPackageTile(context, e))
          ]
        ),
      ]
    );
  }

  Widget _unloadStartButton(BuildContext context) {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    if (!vm.state.scanned) {
      return IconButton(
        icon: const Icon(Icons.qr_code),
        onPressed: showQRScan,
        constraints: const BoxConstraints(),
        tooltip: 'Начать разгрузку',
        padding: EdgeInsets.zero
      );
    }

    return IconButton(
      icon: const Icon(Icons.start),
      onPressed: vm.startUnload,
      constraints: const BoxConstraints(),
      tooltip: 'Начать разгрузку',
      padding: EdgeInsets.zero
    );
  }

  Widget _unloadWorkButtons(BuildContext context) {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.fact_check),
          onPressed: showNewUnloadPackageDialog,
          tooltip: 'Добавить место разгрузки',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(right: 8)
        ),
        IconButton(
          icon: const Icon(Icons.add_box),
          onPressed: showNewPackageDialog,
          tooltip: 'Добавить место приемки',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(right: 8)
        ),
        IconButton(
          icon: const Icon(Icons.copy_all),
          onPressed: vm.copyUnloadPackages,
          tooltip: 'Скопировать из разгрузки',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(right: 8)
        ),
        IconButton(
          icon: const Icon(Icons.task),
          onPressed: vm.endUnload,
          tooltip: 'Закончить разгрузку',
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(left: 8)
        )
      ]
    );
  }

  Widget _productArrivalPackageTile(BuildContext context, ProductArrivalPackageEx packageEx) {
    ProductArrivalPackage package = packageEx.package;

    Widget leading = package.acceptStart == null ?
        const Icon(Icons.close_rounded, color: Colors.red)
      : (
        package.acceptEnd != null ?
          const Icon(Icons.check, color: Colors.green) :
          const Icon(Icons.hourglass_empty, color: Colors.yellow)
      );

    return ListTile(
      leading: leading,
      title: Text('${package.typeName} ${package.number}', style: Style.listTileText),
      onTap: package.acceptStart == null ? null : () => navigateToPackage(packageEx)
    );
  }

  Widget _productArrivalNewPackageTile(BuildContext context, ProductArrivalNewPackage newPackage) {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    return Dismissible(
      key: Key(newPackage.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteProductArrivalNewPackage(newPackage),
      child: ListTile(
        leading: const Icon(Icons.close_rounded, color: Colors.red),
        title: Text("${newPackage.typeName} ${newPackage.number}", style: Style.listTileText)
      )
    );
  }

  Widget _productArrivalUnloadPackageTile(BuildContext context, ProductArrivalUnloadPackage unloadPackage) {
    return ListTile(
      title: Text(unloadPackage.typeName, style: Style.listTileText),
      trailing: Text(unloadPackage.amount.toString(), style: Style.listTileText),
    );
  }

  Widget _productArrivalNewUnloadPackageTile(BuildContext context, ProductArrivalNewUnloadPackage newUnloadPackage) {
    ProductArrivalViewModel vm = context.read<ProductArrivalViewModel>();

    return Dismissible(
      key: Key(newUnloadPackage.hashCode.toString()),
      background: Container(color: Colors.red[500]),
      onDismissed: (direction) => vm.deleteProductArrivalNewUnloadPackage(newUnloadPackage),
      child: ListTile(
        title: Text(newUnloadPackage.typeName, style: Style.listTileText),
        trailing: Text(newUnloadPackage.amount.toString(), style: Style.listTileText),
      )
    );
  }
}
