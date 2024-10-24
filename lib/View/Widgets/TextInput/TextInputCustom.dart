// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gas_app/Constant/colors.dart';

class TextInputCustom extends StatefulWidget {
  TextInputCustom(
      {this.icon,
      this.type,
      this.controller,
      this.hint,
      this.ispassword = false,
      this.helptext = '',
      this.validator});
  Widget? icon;
  TextInputType? type;
  String? hint;
  bool? ispassword;
  TextEditingController? controller;
  String? helptext;
  String? Function(String?)? validator;
  @override
  State<TextInputCustom> createState() => _TextInputCustomState();
}

class _TextInputCustomState extends State<TextInputCustom> {
  bool? showpassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.type,
      obscureText: showpassword!,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      decoration: InputDecoration(
        counterStyle:
            TextStyle(color: kBaseThirdyColor, fontWeight: FontWeight.w500),
        counterText: widget.helptext,
        prefixIcon: widget.icon,
        suffixIcon: widget.ispassword!
            ? showpassword!
                ? GestureDetector(
                    onTap: () => setState(() {
                      showpassword = !showpassword!;
                    }),
                    child: Icon(
                      Icons.visibility_off_rounded,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                  )
                : GestureDetector(
                    onTap: () => setState(() {
                      showpassword = !showpassword!;
                    }),
                    child: Icon(
                      Icons.visibility,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                  )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        filled: true,
        hintText: widget.hint,
        fillColor: kThirdryColor,
        contentPadding: EdgeInsets.all(8),
        isDense: true,
      ),
    );
  }
}
