import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Service.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';

import 'package:gas_app/Services/network_connection.dart';

import 'package:http/http.dart' as http;

class ServicesPageController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  List<Services> ServicesList = [];
  bool isloadinggetallservices = false;
  Future<Either<Failure, bool>> getAllServices(BuildContext context) async {
    isloadinggetallservices = true;
    notifyListeners();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetAllServices,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var mex = jsonDecode(response.body);

          for (var element in mex['data']) {
            ServicesList.add(Services.fromJson(element));
          }
          isloadinggetallservices = false;
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadinggetallservices = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloadinggetallservices = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadinggetallservices = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadinggetallservices = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
