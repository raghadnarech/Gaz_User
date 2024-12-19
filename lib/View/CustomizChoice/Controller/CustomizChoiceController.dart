// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/SubSupplier.dart';
import 'package:gas_app/Services/CustomDialog.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class CustomizChoiceController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  List<SubSupplier> SupplierList = [];
  bool isloadinggetallservicessupplier = false;
  String? type;
  bool nearestrepresentative = true;
  bool selectedrepresentative = false;
  bool representativefromlist = false;
  int? supplierid;
  TextEditingController codemandob = TextEditingController();
  Future<Either<Failure, bool>> GetGasServiceSuppliers(
    BuildContext context,
  ) async {
    log("i'm here");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetGazSuppliers,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var vex = jsonDecode(response.body);

          for (var element in vex['data']) {
            SupplierList.add(SubSupplier.Gaz(element));
          }
          log(SupplierList.length.toString());
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

  Future<Either<Failure, bool>> UpdateCustomChoice(
    BuildContext context,
  ) async {
    log("i'm here");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        dynamic response;
        if (nearestrepresentative) {
          response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.UpdateCustomChoice,
            body: {
              "order_type": "nearest_man",
            },
          );
        } else if (selectedrepresentative) {
          response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.UpdateCustomChoice,
            body: {
              "order_type": "code",
              "code": codemandob.text,
            },
          );
        } else if (representativefromlist) {
          response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.UpdateCustomChoice,
            body: {
              "order_type": "manager",
              "manager_id": supplierid.toString(),
            },
          );
        }
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          CustomDialog.Dialog(context, title: "تم تخصيص الخيار بنجاح");
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
