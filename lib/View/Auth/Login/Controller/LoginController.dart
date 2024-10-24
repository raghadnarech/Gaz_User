// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/Model/User.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/Auth/Signup/Controller/SignupController.dart';
import 'package:gas_app/View/Auth/Signup/View/Signup.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    phonecontroller.clear();
    passwordcontroller.clear();

    log("close login");
    super.dispose();
  }

  Future<Either<Failure, bool>> Login(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        // FirebaseMessaging messaging = FirebaseMessaging.instance;

        // String? token = await messaging.getToken();
        // print(token);
        final response = await client.request(
          requestType: RequestType.POST,
          path: AppApi.LOGIN,
          body: {
            "phone": phonecontroller.text,
            "password": passwordcontroller.text,
          },
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          CustomRoute.RouteReplacementTo(
            context,
            ChangeNotifierProvider(
              create: (context) => HomePageController()
                ..getalladdress()
                ..GetProfile()
                ..GetMyOrders('pending')
                ..GetMyCancelOrders()
                ..getAllServices(),
              lazy: true,
              builder: (context, child) => HomeNavigation(),
            ),
          );
          var res = jsonDecode(response.body);
          if (res['role'] == 'user') {
            var user = User.fromJson(res);
            ServicesProvider.saveuser(user);
          } else {
            return Left(ResultFailure('لا يمكن تسجيل الدخول بهذا الحساب'));
          }
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          return Left(ResultFailure(res['message']));
        } else {
          return Left(GlobalFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  toSignUpPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => SignupController()..GetCountry(),
        lazy: true,
        builder: (context, child) => Signup(),
      ),
    );
  }
}
