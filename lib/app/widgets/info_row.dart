import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final EdgeInsets padding;
  final Widget? title;
  final Widget? trailing;

  const InfoRow({
    Key? key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.title,
    this.trailing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.centerLeft,
                child: title
              )
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.centerLeft,
                child: trailing
              )
            )
          )
        ]
      ),
    );
  }
}
