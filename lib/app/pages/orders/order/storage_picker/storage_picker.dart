import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/qr_types.dart';
import '/app/constants/strings.dart';
import '/app/constants/style.dart';
import '/app/data/database.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/utils/misc.dart';
import '/app/widgets/widgets.dart';

part 'storage_qr_scan_page.dart';
part 'storage_qr_scan_state.dart';
part 'storage_qr_scan_view_model.dart';

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
  StoragePickerState createState() => StoragePickerState();
}

class StoragePickerState extends State<StoragePicker> {
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
                  Storage? storage = await Navigator.push<Storage>(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => StorageQRScanPage(storages: widget.storages),
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
