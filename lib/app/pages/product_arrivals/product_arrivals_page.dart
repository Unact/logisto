import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/qr_types.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/product_arrivals_repository.dart';
import '/app/widgets/widgets.dart';
import 'product_arrival/product_arrival_page.dart';

part 'product_arrivals_state.dart';
part 'product_arrivals_view_model.dart';

class ProductArrivalsPage extends StatelessWidget {
  ProductArrivalsPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductArrivalsViewModel>(
      create: (context) => ProductArrivalsViewModel(
        RepositoryProvider.of<ProductArrivalsRepository>(context),
      ),
      child: _ProductArrivalsView(),
    );
  }
}

class _ProductArrivalsView extends StatefulWidget {
  @override
  _ProductArrivalsViewState createState() => _ProductArrivalsViewState();
}

class _ProductArrivalsViewState extends State<_ProductArrivalsView> {
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  Future<void> showManualInput() async {
    ProductArrivalsViewModel vm = context.read<ProductArrivalsViewModel>();
    TextEditingController trackingNumberController = TextEditingController();

    bool result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                enableInteractiveSelection: false,
                controller: trackingNumberController,
                decoration: const InputDecoration(labelText: 'Номер'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text('Подтвердить')
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Отменить')
            )
          ]
        );
      }
    ) ?? false;

    if (!result) return;

    await vm.findProductArrival(trackingNumberController.text);
  }

  Future<void> showQRScan() async {
    ProductArrivalsViewModel vm = context.read<ProductArrivalsViewModel>();

    await SimpleQRScanDialog(
      context: context,
      qrType: QRType.productArrival,
      onScan: (qrCodeData) => vm.findProductArrival(qrCodeData[4])
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductArrivalsViewModel, ProductArrivalsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Разгрузки'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: showQRScan,
                tooltip: 'Сканировать QR код'
              ),
              IconButton(
                icon: const Icon(Icons.text_fields),
                onPressed: showManualInput,
                tooltip: 'Указать вручную',
              ),
            ]
          ),
          body: _arrivalsList(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case ProductArrivalsStateStatus.inProgress:
            await _progressDialog.open();
            break;
          case ProductArrivalsStateStatus.failure:
            Misc.showMessage(context, state.message);
            _progressDialog.close();
            break;
          case ProductArrivalsStateStatus.success:
            _progressDialog.close();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProductArrivalPage(productArrivalEx: state.foundProductArrivalEx!)
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

  Widget _arrivalsList(BuildContext context) {
    ProductArrivalsViewModel vm = context.read<ProductArrivalsViewModel>();
    List<Widget> storageWidgets = vm.state.storages.map(((storage) {
      List<ProductArrivalEx> productArrivals = vm.state.productArrivalExList
        .where((e) => e.storage == storage).toList();

      return ExpansionTile(
        title: Text(storage.name, style: const TextStyle(fontSize: 14)),
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        children: productArrivals.map((e) => _productArrivalTile(context, e)).toList()
      );
    })).toList();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
      children: storageWidgets
    );
  }

  Widget _productArrivalTile(BuildContext context, ProductArrivalEx productArrivalEx) {
    ProductArrival productArrival = productArrivalEx.productArrival;

    return ListTile(
      title: Text('Разгрузка ${productArrival.number}'),
      subtitle: Text(productArrival.statusName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ProductArrivalPage(productArrivalEx: productArrivalEx)
          )
        );
      }
    );
  }
}
