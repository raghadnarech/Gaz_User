// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gas_app/Services/CustomDialog.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:http/http.dart' as http;
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:provider/provider.dart';

class RateController with ChangeNotifier {
  NetworkClient client = NetworkClient(http.Client());
  var comment = TextEditingController();
  int? reciver_id;
  double? stars;

  Future<Either<Failure, bool>> Rate(
      BuildContext context, int reciver_id) async {
    EasyLoading.show();
    log(reciver_id.toString());
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.POST,
          path: AppApi.Rate,
          body: {
            "stars": stars.toString(),
            "comment": comment.text,
            "reciver_id": reciver_id.toString(),
          },
        );

        log(response.statusCode.toString());
        log(response.body.toString());
        if (response.statusCode == 200) {
          EasyLoading.dismiss();

          CustomRoute.RouteAndRemoveUntilTo(
            context,
            ChangeNotifierProvider(
              lazy: true,
              create: (context) => HomePageController()
                ..GetMyCancelOrders()
                ..GetMyOrders('pending')
                ..GetProfile()
                ..getalladdress(),
              builder: (context, child) => HomeNavigation(),
            ),
          );
          CustomDialog.Dialog(context, title: "تم إضافة التقييم بنجاح");
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          notifyListeners();
          EasyLoading.dismiss();

          return Left(ResultFailure(''));
        } else {
          EasyLoading.dismiss();

          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        notifyListeners();
        EasyLoading.dismiss();

        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();

      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
