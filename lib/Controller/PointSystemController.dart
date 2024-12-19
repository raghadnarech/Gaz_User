import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class PointSystemController with ChangeNotifier {
  // static NetworkClient client = NetworkClient(http.Client());
  String? baseurl = 'https://mayadeen-md.com/pointsPro/public/api';
  String? invitecode;
  String? points;
  bool isloading = false;
  Future<Either<Failure, bool>> StorePoint(
      String? phone, String? reason) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await http.post(
          Uri.parse("$baseurl${AppApi.StorePoint}"),
          body: {
            'phone': phone,
            'app': 'gaz',
            'reason': reason,
          },
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
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

  Future<Either<Failure, bool>> StoreUser(
      {String? name,
      String? email,
      String? password,
      String? phone,
      var invitecode}) async {
    log(name!);
    log(email!);
    log(password!);
    log(phone!);
    log(invitecode.toString());
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await http.post(
          Uri.parse("$baseurl${AppApi.StoreUser}"),
          body: {
            'name': name.toString(),
            'email': email.toString(),
            'password': password.toString(),
            'phone': phone.toString(),
            'app_id': 2.toString(),
            'invite_code': invitecode == null ? '' : invitecode.toString()
          },
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          log(res.toString());
          await StorePoint(phone, 'userRegister');
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

  Future<Either<Failure, bool>> GetUserCode() async {
    try {
      isloading = true;
      notifyListeners();
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await http.post(
          Uri.parse("$baseurl${AppApi.GetUserCode}"),
          body: {
            'phone': ServicesProvider.getphone(),
          },
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          invitecode = res['invite_code'].toString();
          points = res['points'].toString();
          isloading = false;
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloading = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloading = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloading = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
