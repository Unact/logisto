part of 'order_page.dart';

class OrderStoragePicker extends StatefulWidget {
  final List<OrderStorage> orderStorages;
  final OrderStorage? value;
  final Function(OrderStorage?, bool)? onChanged;

  const OrderStoragePicker(
  {
    required this.orderStorages,
    this.value,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _OrderStoragePickerState createState() => _OrderStoragePickerState();
}

class _OrderStoragePickerState extends State<OrderStoragePicker> {
  late OrderStorage? newOrderStorage = widget.value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: DropdownButtonFormField(
            isExpanded: true,
            menuMaxHeight: 200,
            value: newOrderStorage,
            decoration: InputDecoration(
              labelText: 'Склад',
              suffixIcon: IconButton(
                onPressed: () async {
                  OrderStorage? orderStorage = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => OrderStorageQrScanPage(orderStorages: widget.orderStorages),
                      fullscreenDialog: true
                    )
                  );
                  setState(() => newOrderStorage = orderStorage);

                  if (widget.onChanged != null) widget.onChanged!(orderStorage, true);
                },
                icon: const Icon(Icons.qr_code_scanner)
              )
            ),
            items: widget.orderStorages.map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name,
                style: const TextStyle(overflow: TextOverflow.clip, fontSize: 14),
                softWrap: false
              )
            )).toList(),
            onChanged: (OrderStorage? orderStorage) {
              setState(() => newOrderStorage = orderStorage);

              if (widget.onChanged != null) widget.onChanged!(orderStorage, false);
            }
          )
        ),
      ]
    );
  }
}
