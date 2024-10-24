// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Noti.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class NotificationController with ChangeNotifier {
  List<Noti> notifications = [];
  NetworkClient client = NetworkClient(http.Client());
  bool loadingnoti = false;
  Future<Either<Failure, bool>> GetNotification() async {
    loadingnoti = true;
    notifyListeners();
    log("call this method");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.POST,
          path: AppApi.GetNoti,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          res.forEach((v) {
            notifications.add(Noti.fromJson(v));
          });
          loadingnoti = false;
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          loadingnoti = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          loadingnoti = false;
          notifyListeners();
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        loadingnoti = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      loadingnoti = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
