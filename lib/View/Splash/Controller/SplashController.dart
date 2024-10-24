// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Auth/Signup/Controller/SignupController.dart';
import 'package:gas_app/View/Auth/Signup/View/Signup.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:provider/provider.dart';

class SplashController with ChangeNotifier {
  @override
  dispose() {
    log("close splash");
    super.dispose();
  }

  whenIslogin(BuildContext context) async {
    Future.delayed(Duration(seconds: 5)).then((value) async {
      if (await ServicesProvider.isLoggin()) {
        toHomePage(context);
      } else {
        toAuthPage(context);
      }
    });
  }

  toHomePage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      HomeNavigation(),
    );
  }

  toAuthPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => SignupController()..GetCountry(),
        lazy: true,
        child: Signup(),
      ),
    );
  }
}
