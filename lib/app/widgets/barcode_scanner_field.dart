import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScannerField extends EditableText {
  BarcodeScannerField({
    Key? key,
    void Function(String)? onChanged
  }) : super(
    key: key,
    autofocus: true,
    showCursor: false,
    controller: TextEditingController(),
    focusNode: _BarcodeScannerFieldFocusNode(),
    style: const TextStyle(),
    onChanged: onChanged,
    cursorColor: Colors.transparent,
    backgroundCursorColor: Colors.transparent
  );

  @override
  BarcodeScannerFieldState createState() => BarcodeScannerFieldState();
}

class BarcodeScannerFieldState extends EditableTextState {
  @override
  void initState() {
    widget.focusNode.addListener(funcionListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(funcionListener);
    super.dispose();
  }

  @override
  void requestKeyboard() {
    super.requestKeyboard();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void funcionListener() {
    if (widget.focusNode.hasFocus) requestKeyboard();
  }
}

class _BarcodeScannerFieldFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
