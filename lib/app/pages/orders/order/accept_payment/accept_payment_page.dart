import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:permission_handler/permission_handler.dart';

import '/app/data/database.dart';
import '/app/constants/strings.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/services/iboxpro.dart';

part 'accept_payment_state.dart';
part 'accept_payment_view_model.dart';

class AcceptPaymentPage extends StatelessWidget {
  final Order order;
  final bool cardPayment;

  AcceptPaymentPage({
    Key? key,
    required this.order,
    required this.cardPayment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcceptPaymentViewModel>(
      create: (context) => AcceptPaymentViewModel(
        context,
        order: order,
        cardPayment: cardPayment
      ),
      child: _AcceptPaymentView(),
    );
  }
}

class _AcceptPaymentView extends StatefulWidget {
  @override
  _AcceptPaymentViewState createState() => _AcceptPaymentViewState();
}

class _AcceptPaymentViewState extends State<_AcceptPaymentView> {
  final GlobalKey<SignatureState> _sign = GlobalKey<SignatureState>();

  Future<Uint8List> getSignatureData() async {
    SignatureState? sign = _sign.currentState;
    ByteData? data = (await (await sign!.getData()).toByteData(format: ImageByteFormat.png));

    return data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptPaymentViewModel, AcceptPaymentState>(
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildProgressPart(context)..addAll(_buildInfoPart(context))
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case AcceptPaymentStateStatus.failure:
          case AcceptPaymentStateStatus.finished:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context, state.message);
            });
            break;
          default:
        }
      },
    );
  }

  List<Widget> _buildProgressPart(BuildContext context) {
    AcceptPaymentViewModel vm = context.read<AcceptPaymentViewModel>();

    return [
      const CircularProgressIndicator(
        backgroundColor: Colors.white70,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
      const SizedBox(height: 40),
      Text(vm.state.message, style: const TextStyle(fontSize: 18, color: Colors.white70), textAlign: TextAlign.center),
      const SizedBox(height: 40),
      SizedBox(
        height: 32,
        child: vm.state.isCancelable ? ElevatedButton(
          child: const Text('Отмена', style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: Colors.white
          ),
          onPressed: vm.cancelPayment
        ) : Container()
      ),
      const SizedBox(height: 40)
    ];
  }

  List<Widget> _buildInfoPart(BuildContext context) {
    AcceptPaymentViewModel vm = context.read<AcceptPaymentViewModel>();

    if (!vm.state.isRequiredSignature) return [const SizedBox(height: 122)];

    return [
      Container(
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
          border: Border.all(color: Colors.grey),
          color: Colors.white
        ),
        child: Signature(key: _sign, strokeWidth: 5)
      ),
      const SizedBox(height: 40),
      SizedBox(
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                backgroundColor: Colors.white
              ),
              child: const Text('Очистить', style: TextStyle(color: Colors.black)),
              onPressed: () => _sign.currentState!.clear()
            ),
            Container(width: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                backgroundColor: Colors.white
              ),
              child: const Text('Подтвердить', style: TextStyle(color: Colors.black)),
              onPressed: () async => vm.adjustPayment(await getSignatureData())
            )
          ]
        )
      )
    ];
  }
}