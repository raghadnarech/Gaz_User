import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Product.dart';
import 'package:gas_app/Model/SubSupplier.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class SelectSubSupplierController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  List<SubSupplier> SupplierList = [];
  bool isloadinggetallservicessupplier = false;

  Future<Either<Failure, bool>> GetAllServiceSuppliers(
      BuildContext context, int id) async {
    isloadinggetallservicessupplier = true;
    notifyListeners();
    log("i'm here");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetAllServiceSuppliers(id),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var vex = jsonDecode(response.body);

          for (var element in vex['data']) {
            SupplierList.add(SubSupplier.fromJson(element));
          }
          log(SupplierList.toString());
          isloadinggetallservicessupplier = false;
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadinggetallservicessupplier = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloadinggetallservicessupplier = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadinggetallservicessupplier = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadinggetallservicessupplier = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

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

  bool isloadinggetproductgaz = false;
  List<Product> productList = [];
  String? code;
  Future<Either<Failure, bool>> GetProductGaz(
    BuildContext context,
    String filter,
    dynamic IdOrCode,
  ) async {
    productList.clear();
    isloadinggetproductgaz = true;
    notifyListeners();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.ChooseWay(filter, IdOrCode),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var vex = jsonDecode(response.body);
          if (filter == 'nearest_man') {
            for (var element in vex) {
              for (var product in element['product']) {
                productList.add(Product.fromJson(product));
              }
            }
          } else if (filter == 'code') {
            code = vex['code'];
            for (var element in vex['data']) {
              for (var product in element['product']) {
                productList.add(Product.fromJson(product));
              }
            }
          } else {
            for (var element in vex) {
              for (var product in element['product']) {
                productList.add(Product.fromJson(product));
              }
            }
          }
          isloadinggetproductgaz = false;
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadinggetproductgaz = false;
          notifyListeners();

          return Left(ResultFailure(res['message']));
        } else {
          isloadinggetproductgaz = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadinggetproductgaz = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadinggetproductgaz = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
