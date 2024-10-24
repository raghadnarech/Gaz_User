import 'package:flutter/material.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomDialog {
  static Dialog(
    BuildContext context, {
    String? title,
  }) {
    showTopSnackBar(
      padding: EdgeInsets.zero,
      snackBarPosition: SnackBarPosition.top,
      curve: Curves.fastLinearToSlowEaseIn,
      Overlay.of(context),
      CustomSnackBar.success(
        maxLines: 3,
        textStyle: style15semiboldwhite,
        messagePadding: EdgeInsets.all(2),
        icon: Text(''),
        textAlign: TextAlign.start,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        backgroundColor: kFourthColor.withAlpha(200),
        message: title!,
      ),
    );
  }
}
