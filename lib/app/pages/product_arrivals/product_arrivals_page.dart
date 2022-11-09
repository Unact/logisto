import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
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
      create: (context) => ProductArrivalsViewModel(context),
      child: _ProductArrivalsView(),
    );
  }
}

class _ProductArrivalsView extends StatefulWidget {
  @override
  _ProductArrivalsViewState createState() => _ProductArrivalsViewState();
}

class _ProductArrivalsViewState extends State<_ProductArrivalsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductArrivalsViewModel, ProductArrivalsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Разгрузка')),
          body: _arrivalsList(context)
        );
      },
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
      title: Text('Приемка ${productArrival.number}'),
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
