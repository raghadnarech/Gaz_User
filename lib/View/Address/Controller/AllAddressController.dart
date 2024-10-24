// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Address.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class AllAddressController with ChangeNotifier {
  bool isloadingaddress = false;
  static NetworkClient client = NetworkClient(http.Client());
  List<Address> addressList = [];
  Future<Either<Failure, bool>> getalladdress(BuildContext context) async {
    addressList.clear();
    isloadingaddress = true;
    notifyListeners();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetAllMyAddress,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var vex = jsonDecode(response.body);

          for (var element in vex['data']) {
            addressList.add(Address.fromJson(element));
          }
          isloadingaddress = false;
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadingaddress = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloadingaddress = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadingaddress = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadingaddress = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> DeleteAddress(
      BuildContext context, int id) async {
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.DeleteAddress(id),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          getalladdress(context);
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          EasyLoading.dismiss();
          return Left(ResultFailure(res['message']));
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
