import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/product_arrivals_repository.dart';

part 'code_scan_state.dart';
part 'code_scan_view_model.dart';

class CodeScanPage extends StatelessWidget {
  final ProductArrivalPackageEx packageEx;
  final Product product;

  CodeScanPage({
    required this.packageEx,
    required this.product,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CodeScanViewModel>(
      create: (context) => CodeScanViewModel(
        RepositoryProvider.of<ProductArrivalsRepository>(context),
        packageEx: packageEx,
        product: product
      ),
      child: _CodeScanView(),
    );
  }
}

class _CodeScanView extends StatefulWidget {
  @override
  _CodeScanViewState createState() => _CodeScanViewState();
}

class _CodeScanViewState extends State<_CodeScanView> {
  final TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CodeScanViewModel, CodeScanState>(
      builder: (context, state) {
        CodeScanViewModel vm = context.read<CodeScanViewModel>();

        return ScanView(
          showScanner: true,
          onRead: vm.readCode,
          child: _infoWidget(context)
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case CodeScanStateStatus.success:
          case CodeScanStateStatus.failure:
            Misc.showMessage(context, state.message);
            break;
          default:
            break;
        }
      }
    );
  }

  Widget _infoWidget(BuildContext context) {
    CodeScanViewModel vm = context.read<CodeScanViewModel>();

    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Text(vm.state.product.name, textAlign: TextAlign.center, style: textStyle)
          )
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            "${vm.state.newCodes.length} из ${vm.state.total}",
            style: textStyle
          )
        )
      ]
    );
  }
}
