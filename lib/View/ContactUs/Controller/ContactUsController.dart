import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class ContactUsController with ChangeNotifier {
  var message = TextEditingController();
  NetworkClient client = NetworkClient(http.Client());

  Future<Either<Failure, bool>> SendContact(BuildContext context) async {
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.SendContact,
            body: {
              'text': message.text,
            });
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('تم ارسال الرسالة بنجاح');
          message.clear();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          EasyLoading.dismiss();
          EasyLoading.showError(ResultFailure(res['message']).message);
          return Left(ResultFailure(res['message']));
        } else {
          EasyLoading.dismiss();
          EasyLoading.dismiss();
          EasyLoading.showError(GlobalFailure().message);
          return Left(GlobalFailure());
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(ServerFailure().message);
        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(GlobalFailure().message);
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
