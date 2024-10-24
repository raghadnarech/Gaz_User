// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gas_app/Constant/colors.dart';

class CheckBoxCustom extends StatefulWidget {
  final bool check;
  final ValueChanged<bool?> onChanged;
  final Color? color;

  CheckBoxCustom(
      {required this.check,
      this.color = kPrimaryColor,
      required this.onChanged});

  @override
  State<CheckBoxCustom> createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.check);
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.check ? widget.color! : kThirdryColor,
        ),
      ),
    );
  }
}
