import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Category.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';

import 'package:http/http.dart' as http;

class MainCategoriesController with ChangeNotifier {
  List<Category> listcategory = [];

  NetworkClient client = NetworkClient(http.Client());
  Future<Either<Failure, bool>> GetMainCategory(int id) async {
    listcategory.clear();
    notifyListeners();
    log("call this method");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetProductSubCat(id),
        );
        log(response.body.toString());
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          if (res['data'] != null) {
            for (var element in res['data']) {
              listcategory.add(Category.fromJson(element));
            }
          }
          log(listcategory.length.toString());
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
