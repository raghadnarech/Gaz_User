import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Order.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class OrderAcceptedController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  DateTime? servertime;
  Orderes order = Orderes();
  Future<Either<Failure, bool>> GetOrderById(int id) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetOrderById(id),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          order = Orderes.fromJson(res['data']);
          servertime = DateTime.parse(res['server_time']);
          notifyListeners();
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
}
