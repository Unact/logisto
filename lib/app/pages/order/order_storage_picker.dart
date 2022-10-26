part of 'order_page.dart';

class StoragePicker extends StatefulWidget {
  final List<Storage> storages;
  final Storage? value;
  final Function(Storage?, bool)? onChanged;

  const StoragePicker(
  {
    required this.storages,
    this.value,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _StoragePickerState createState() => _StoragePickerState();
}

class _StoragePickerState extends State<StoragePicker> {
  late Storage? newStorage = widget.value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: DropdownButtonFormField(
            isExpanded: true,
            menuMaxHeight: 200,
            value: newStorage,
            decoration: InputDecoration(
              labelText: 'Склад',
              suffixIcon: IconButton(
                onPressed: () async {
                  Storage? storage = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => StorageQrScanPage(storages: widget.storages),
                      fullscreenDialog: true
                    )
                  );
                  setState(() => newStorage = storage);

                  if (widget.onChanged != null) widget.onChanged!(storage, true);
                },
                icon: const Icon(Icons.qr_code_scanner)
              )
            ),
            items: widget.storages.map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name,
                style: const TextStyle(overflow: TextOverflow.clip, fontSize: 14),
                softWrap: false
              )
            )).toList(),
            onChanged: (Storage? storage) {
              setState(() => newStorage = storage);

              if (widget.onChanged != null) widget.onChanged!(storage, false);
            }
          )
        ),
      ]
    );
  }
}
