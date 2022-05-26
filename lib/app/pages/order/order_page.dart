import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery, Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/accept_payment/accept_payment_page.dart';
import '/app/pages/order_qr_scan/order_qr_scan_page.dart';
import '/app/pages/order_storage_qr_scan/order_storage_qr_scan_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/utils/format.dart';
import '/app/utils/parsing.dart';
import '/app/widgets/widgets.dart';

part 'order_state.dart';
part 'order_view_model.dart';
part 'order_storage_picker.dart';

class OrderPage extends StatelessWidget {
  final OrderExtended orderExtended;

  OrderPage({
    Key? key,
    required this.orderExtended
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderViewModel>(
      create: (context) => OrderViewModel(context, orderExtended: orderExtended),
      child: _OrderView(),
    );
  }
}

class _OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<_OrderView> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  Completer<void> _dialogCompleter = Completer();
  final ButtonStyle _buttonStyle = TextButton.styleFrom(primary: Colors.blue);

  Future<List<dynamic>?> _showAcceptDialog(bool showOrderStoragePicker) async {
    OrderViewModel vm = context.read<OrderViewModel>();

    return await showDialog<List<dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Order order = vm.state.order;
        String weight = order.weight != null ? Format.numberStr(order.weight! / 1000) : '';
        String volume = order.volume != null ? Format.numberStr(order.volume! / 1000000) : '';
        TextEditingController _weightDialogController = TextEditingController(text: weight);
        TextEditingController _volumeDialogController = TextEditingController(text: volume);
        bool? hasDocuments = !order.documentsReturn;
        TextStyle textStyle = const TextStyle(fontSize: 14);
        OrderStorage? newOrderStorage = vm.state.toStorage;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Подтвердите заказ'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    !showOrderStoragePicker ? Container() : OrderStoragePicker(
                      orderStorages: vm.state.acceptableStorages,
                      value: newOrderStorage,
                      onChanged: (orderStorage, _) => setState(() => newOrderStorage = orderStorage)
                    ),
                    TextFormField(
                      maxLines: 1,
                      autocorrect: false,
                      controller: _weightDialogController,
                      style: textStyle,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Вес, кг')
                    ),
                    TextFormField(
                      maxLines: 1,
                      autocorrect: false,
                      controller: _volumeDialogController,
                      style: textStyle,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Объем, м3')
                    ),
                    !order.documentsReturn ?
                      Container() :
                      DropdownButtonFormField(
                        isExpanded: true,
                        menuMaxHeight: 200,
                        decoration: const InputDecoration(labelText: 'Документы'),
                        value: hasDocuments,
                        items: [true, false].map((e) => DropdownMenuItem<bool>(
                          value: e,
                          child: Text(e ? 'Да' : 'Нет', style: textStyle)
                        )).toList(),
                        onChanged: (bool? newVal) => setState(() => hasDocuments = newVal)
                      )
                  ]
                )
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(Strings.ok),
                  onPressed: showOrderStoragePicker && newOrderStorage == null ? null : () {
                    Navigator.of(context).pop(
                      [hasDocuments, _weightDialogController.text, _volumeDialogController.text, newOrderStorage]
                    );
                  }
                ),
                TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(null))
              ],
            );
          }
        );
      }
    );
  }

  Future<void> openDialog() async {
    showDialog<void>(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false
    );
    await _dialogCompleter.future;
    Navigator.of(context).pop();
  }

  void closeDialog() {
    _dialogCompleter.complete();
    _dialogCompleter = Completer();
  }

  void showMessageAndCloseDialog(String message) {
    showMessage(message);
    closeDialog();
  }

  Future<void> showQRScanPage() async {
    OrderViewModel vm = context.read<OrderViewModel>();
    bool res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => OrderQRScanPage(order: vm.state.order),
        fullscreenDialog: true
      )
    ) ?? false;

    vm.finishScan(res);
  }

  Future<void> showAcceptPaymentDialog() async {
    OrderViewModel vm = context.read<OrderViewModel>();
    String result = await showDialog<String>(
      context: context,
      builder: (_) => AcceptPaymentPage(order: vm.state.order, cardPayment: vm.state.cardPayment),
      barrierDismissible: false
    ) ?? 'Платеж отменен';

    vm.finishPayment(result);
  }

  Future<void> showConfirmationDialog(String message, Function callback) async {
    bool result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
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

  Future<void> showOrderTransferDialog() async {
    OrderViewModel vm = context.read<OrderViewModel>();
    OrderStorage? result = await showDialog<OrderStorage>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        OrderStorage? newOrderStorage;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 8, 24.0),
              title: const Text('Выберите склад'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    OrderStoragePicker(
                      orderStorages: vm.state.transferableStorages,
                      value: newOrderStorage,
                      onChanged: (orderStorage, isScanned) {
                        setState(() => newOrderStorage = orderStorage)

                        if (isScanned) Navigator.of(context).pop(newOrderStorage);
                      }
                    )
                  ]
                )
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(Strings.ok),
                  onPressed: newOrderStorage == null ? null : () => Navigator.of(context).pop(newOrderStorage)
                ),
                TextButton(child: const Text(Strings.cancel), onPressed: () => Navigator.of(context).pop(null))
              ],
            );
          }
        );
      });

    if (result != null) vm.transferOrder(result);
  }

  Future<void> showAcceptOrderDialog() async {
    OrderViewModel vm = context.read<OrderViewModel>();
    List<dynamic>? result = await _showAcceptDialog(true);

    if (result != null) {
      vm.acceptOrder(result[0], result[1], result[2], result[3]);
    }
  }

  Future<void> showAcceptStorageTransferDialog() async {
    OrderViewModel vm = context.read<OrderViewModel>();
    List<dynamic>? result = await _showAcceptDialog(false);

    if (result != null) {
      vm.acceptStorageTransferOrder(result[0], result[1], result[2]);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
  }

  List<Widget> orderInfoRows(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();
    Order order = vm.state.order;
    String deliveryTime = order.deliveryDateTimeFrom != null ?
      ' ' + Format.timeStr(order.deliveryDateTimeFrom) + '-' + Format.timeStr(order.deliveryDateTimeTo) :
      '';
    String weight = order.weight != null ? Format.numberStr(order.weight! / 1000) : '';
    String volume = order.volume != null ? Format.numberStr(order.volume! / 1000000) : '';

    _weightController.text = weight;
    _weightController.selection = TextSelection.fromPosition(TextPosition(offset: weight.length));

    _volumeController.text = volume;
    _volumeController.selection = TextSelection.fromPosition(TextPosition(offset: volume.length));

    return [
      InfoRow(title: const Text('Номер в ИМ'), trailing: Text(order.number)),
      InfoRow(
        title: const Text('Статус'),
        trailing: Text(order.statusName)
      ),
      InfoRow(
        title: const Text('Курьер'),
        trailing: Text(order.courierName ?? '')
      ),
      InfoRow(
        title: const Text('Дата доставки'),
        trailing: Text(Format.dateStr(order.deliveryDate) + deliveryTime)
      ),
      InfoRow(
        title: const Text('Адрес доставки'),
        trailing: ExpandingText(order.deliveryAddressName, textAlign: TextAlign.left)
      ),
      InfoRow(
        title: const Text('Кол-во мест'),
        trailing: Text(order.packages.toString())
      ),
      InfoRow(
        title: const Text('Вес, кг'),
        trailing: !vm.state.scanned ? Text(weight) : TextFormField(
          maxLines: 1,
          autocorrect: false,
          controller: _weightController,
          style: const TextStyle(fontSize: 14),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only()),
          onFieldSubmitted: vm.updateWeight
        ),
      ),
      InfoRow(
        title: const Text('Объем, м3'),
        trailing: !vm.state.scanned ? Text(volume) : TextFormField(
          maxLines: 1,
          autocorrect: false,
          controller: _volumeController,
          style: const TextStyle(fontSize: 14),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only()),
          onFieldSubmitted: vm.updateVolume
        )
      ),
      InfoRow(
        title: const Text('Адрес забора'),
        trailing: ExpandingText(order.pickupAddressName, textAlign: TextAlign.left)
      ),
      InfoRow(
        title: const Text('Текущий склад'),
        trailing: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: order.storageAccepted == null && vm.state.fromStorage != null ? 'Заказ в пути\n' : '',
                style: const TextStyle(fontSize: 10)
              ),
              TextSpan(text: vm.state.toStorage?.name ?? '', style: const TextStyle(fontSize: 14)),
            ]
          )
        )
      ),
      InfoRow(
        title: const Text('Дата приемки'),
        trailing: Text(Format.dateTimeStr(order.firstMovementDate))
      ),
      InfoRow(
        title: const Text('К оплате'),
        trailing: Row(
          children: [
            Text(Format.numberStr(order.paySum)),
            !vm.state.payable ? Container() : Row(
              children: [
                SizedBox(
                  width: 48,
                  child: TextButton(
                    onPressed: () => vm.tryStartPayment(false),
                    child: const Icon(Icons.account_balance_wallet, color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: TextButton(
                    onPressed: () => vm.tryStartPayment(true),
                    child: const Icon(Icons.credit_card, color: Colors.black),
                  )
                )
              ]
            )
          ]
        )
      ),
      ExpansionTile(
        title: const Text('Позиции', style: TextStyle(fontSize: 14)),
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        children: vm.state.lines.map<Widget>((e) => _buildOrderLineTile(context, e)).toList()
      ),
      orderActions(context),
      orderPickupActions(context)
    ];
  }

  Widget orderActions(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();

    List<Widget> actions = [
      !(vm.state.storageTransferAcceptable) ? null : TextButton(
        onPressed: showAcceptStorageTransferDialog,
        child: Column(children: const [Icon(Icons.how_to_reg_sharp, color: Colors.black), Text('Принять')]),
        style: _buttonStyle
      ),
      !vm.state.acceptable ? null : TextButton(
        onPressed: showAcceptOrderDialog,
        child: Column(children: const [Icon(Icons.fact_check, color: Colors.black), Text('Приемка')]),
        style: _buttonStyle
      ),
      !vm.state.transferable ? null : TextButton(
        onPressed: showOrderTransferDialog,
        child: Column(children: const [Icon(Icons.transfer_within_a_station, color: Colors.black), Text('Передать')]),
        style: _buttonStyle
      ),
    ].whereType<Widget>().toList();

    if (actions.isEmpty) return Container();

    return ExpansionTile(
      title: const Text('Передвижение', style: TextStyle(fontSize: 14)),
      initiallyExpanded: false,
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      children: [Row(children: actions, mainAxisAlignment: MainAxisAlignment.spaceAround)]
    );
  }

  Widget orderPickupActions(BuildContext context) {
    OrderViewModel vm = context.read<OrderViewModel>();

    List<Widget> actions = [
      !(vm.state.transferAcceptable) ? null : TextButton(
        onPressed: vm.acceptTransferOrder,
        child: Column(children: const [Icon(Icons.how_to_reg_sharp, color: Colors.black), Text('Принять')]),
        style: _buttonStyle
      ),
      !vm.state.deliverable ? null : TextButton(
        onPressed: vm.tryConfirmOrder,
        child: Column(children: const [Icon(Icons.assignment_turned_in, color: Colors.black), Text('Выдать')]),
        style: _buttonStyle
      ),
      !vm.state.deliverable ? null : TextButton(
        onPressed: vm.tryCancelOrder,
        child: Column(children: const [Icon(Icons.assignment_return, color: Colors.black), Text('Вернуть')]),
        style: _buttonStyle
      ),
    ].whereType<Widget>().toList();

    if (actions.isEmpty) return Container();

    return ExpansionTile(
      title: const Text('ПВЗ', style: TextStyle(fontSize: 14)),
      initiallyExpanded: false,
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      children: [Row(children: actions, mainAxisAlignment: MainAxisAlignment.spaceAround)]
    );
  }

  Widget _buildOrderLineTile(BuildContext context, OrderLine orderLine) {
    OrderViewModel vm = context.read<OrderViewModel>();
    String amountStr = (orderLine.factAmount ?? orderLine.amount).toString();
    TextStyle style = const TextStyle(fontSize: 12);

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SizedBox(
              height: 36,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ExpandingText(orderLine.name, textAlign: TextAlign.left, style: style),
              )
            )
          ),
          Row(
            children: <Widget>[
              Text(Format.numberStr(orderLine.price) + ' x ', style: style),
              !vm.state.deliverable ? Text(amountStr, style: style) :
                SizedBox(
                  width: 40,
                  height: 36,
                  child: TextFormField(
                    initialValue: amountStr,
                    style: style,
                    textAlign: TextAlign.center,
                    onChanged: (newValue) async => await vm.updateOrderLineAmount(orderLine, newValue),
                    keyboardType: const TextInputType.numberWithOptions(signed: true),
                    decoration: const InputDecoration(contentPadding: EdgeInsets.only(bottom: 12)),
                  )
                )
            ],
          )
        ]
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderViewModel, OrderState>(
      builder: (context, state) {
        OrderViewModel vm = context.read<OrderViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: Text('Заказ ${state.order.trackingNumber}'),
          ),
          body: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                children: orderInfoRows(context)..add(SizedBox(height: !vm.state.scannable ? 0 : 72))
              ),
              !vm.state.scannable ? Container() : SizedBox(
                height: 72,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1.0))
                  ),
                  padding: const EdgeInsets.only(bottom: 4, right: 8, left: 8),
                  child: Center(
                    child: TextButton(
                      onPressed: vm.startScan,
                      child: const Icon(Icons.qr_code_scanner, color: Colors.black),
                      style: _buttonStyle
                    )
                  )
                )
              )
            ],
          )
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case OrderStateStatus.inProgress:
            await openDialog();
            break;
          case OrderStateStatus.scanFinished:
          case OrderStateStatus.paymentFinished:
          case OrderStateStatus.failure:
          case OrderStateStatus.success:
            showMessageAndCloseDialog(state.message);
            break;
          case OrderStateStatus.scanStarted:
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              await showQRScanPage();
            });
            break;
          case OrderStateStatus.paymentStarted:
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              await showAcceptPaymentDialog();
            });
            break;
          case OrderStateStatus.needUserConfirmation:
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              await showConfirmationDialog(state.message, state.confirmationCallback);
            });
            break;
          default:
            break;
        }
      },
    );
  }
}
