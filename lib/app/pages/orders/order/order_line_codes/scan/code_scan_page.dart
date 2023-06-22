import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';

import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'code_scan_state.dart';
part 'code_scan_view_model.dart';

class CodeScanPage extends StatelessWidget {
  final OrderLineEx orderLineEx;

  CodeScanPage({
    required this.orderLineEx,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CodeScanViewModel>(
      create: (context) => CodeScanViewModel(context, orderLineEx: orderLineEx),
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
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CodeScanViewModel, CodeScanState>(
      builder: (context, state) {
        CodeScanViewModel vm = context.read<CodeScanViewModel>();

        _controller.text = '';

        return ScanView(
          onRead: vm.readCode,
          child: _lastLineInfoWidget(context)
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

  Widget _lastLineInfoWidget(BuildContext context) {
    CodeScanViewModel vm = context.read<CodeScanViewModel>();

    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Text(vm.state.orderLineEx.product!.name, textAlign: TextAlign.center, style: textStyle)
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
