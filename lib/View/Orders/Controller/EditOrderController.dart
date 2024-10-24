// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/Model/Address.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EditOrderController with ChangeNotifier {
  TextEditingController codecontroller = TextEditingController();
  Address address = Address();
  String? date_wanted;
  bool sheduleappoiment = false;
  bool nearestman = false;
  bool cash = true;
  bool credit = false;
  bool e_wallet = false;
  String? payment_kind = 'cash';

  void selectAddress(Address newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void changePaymentMethod(String method) {
    payment_kind = method;
    cash = method == "cash";
    credit = method == "credit";
    e_wallet = method == "wallet";
    notifyListeners();
  }

  Future<Either<Failure, bool>> UpdateOrder(
    BuildContext context, {
    int? id,
  }) async {
    EasyLoading.show();
    var s = {
      "payment_kind": payment_kind ?? 'cash',
      "date_wanted": date_wanted.toString(),
      "nearest_man": nearestman.toString(),
      "code": codecontroller.text,
      "address_id": address.id,
    };
    log(s.toString());
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        http.Response response = await http.post(
          Uri.parse("${AppApi.url}${AppApi.UpdateOrder(id!)}"),
          headers: {
            "Accept": "application/json",
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
          },
          body: json.encode({
            "payment_kind": payment_kind ?? 'cash',
            "date_wanted": date_wanted.toString(),
            "nearest_man": nearestman.toString(),
            "code": codecontroller.text,
            "address_id": address.id,
          }),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          log(response.body);
          log(response.statusCode.toString());
          EasyLoading.dismiss();
          CustomRoute.RouteAndRemoveUntilTo(
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
              ));
          return Right(true);
        } else if (response.statusCode == 404) {
          EasyLoading.dismiss();

          return Left(ResultFailure(''));
        } else {
          EasyLoading.dismiss();

          return Left(GlobalFailure());
        }
      } else {
        EasyLoading.dismiss();

        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();

      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
