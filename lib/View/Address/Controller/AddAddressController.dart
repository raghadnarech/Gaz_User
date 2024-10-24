// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/City.dart';
import 'package:gas_app/Model/District.dart';
import 'package:gas_app/Model/Region.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddAddressController with ChangeNotifier {
  bool? residential = true;
  bool? commercial = false;

  double? lat = 0;
  double? long = 0;

  // Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  GoogleMapController? gmcontroller;
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );
  oninit() async {
    var status = await Permission.location.request();
    log(status.toString());

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    gmcontroller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat!, long!),
      zoom: 14.4746,
    )));
    notifyListeners();
  }

  TextEditingController nameAddress = TextEditingController();
  @override
  void dispose() {
    nameAddress.clear();
    log("cloass Add Address");
    super.dispose();
  }

  static NetworkClient client = NetworkClient(http.Client());

  Region? region;
  City? city;
  District? district;
  changeregion(Region value) async {
    region = value;
    listcity.clear();
    listdistrict.clear();
    city = null;
    district = null;
    GetAllCities();
    notifyListeners();
  }

  // void onCameraIdle() async {
  //   log('asd');
  //   await GetLocation(lat!, long!);
  // }
  changecity(City value) async {
    listdistrict.clear();
    district = null;
    city = value;

    GetAllDistricts();
    notifyListeners();
  }

  changedistrict(District value) async {
    district = value;
    notifyListeners();
  }

  List<Region> listregion = [];
  List<City> listcity = [];
  List<District> listdistrict = [];
  Future<Either<Failure, bool>> GetAllDistricts() async {
    listdistrict.clear();
    log("call this method");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetAllDistricts(city!.cityId!),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          for (var element in res) {
            listdistrict.add(District.fromJson(element));
            log(element.toString());
          }
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

  Future<Either<Failure, bool>> GetAllCities() async {
    listcity.clear();
    log("call this method");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetAllCities(region!.regionId!),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          for (var element in res) {
            listcity.add(City.fromJson(element));
            log(element.toString());
          }
          notifyListeners();
          // log(res.toString());
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

  Future<Either<Failure, bool>> GetAllRegions() async {
    listregion.clear();
    log("call this method");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetAllRegions,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          for (var element in res) {
            listregion.add(Region.fromJson(element));
            log(element.toString());
          }
          notifyListeners();
          log(res.toString());
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

  changelatlong(CameraPosition position) {
    lat = position.target.latitude;
    long = position.target.longitude;
    // notifyListeners();
  }

  Future<Either<Failure, bool>> AddAddress(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.AddAddress,
            body: {
              "name": nameAddress.text,
              "lang": long.toString(),
              "lat": lat.toString(),
              "region": region.toString(),
              "city": city.toString(),
              "distrect_id": district!.districtId.toString(),
              "kind": residential! ? 'سكني' : 'تجاري',
            });
        log(response.body.toString());
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          CustomRoute.RouteAndRemoveUntilTo(
            context,
            ChangeNotifierProvider(
              lazy: true,
              create: (context) => HomePageController()
                ..getalladdress()
                ..GetProfile()
                ..GetMyCancelOrders()
                ..GetMyOrders('pending')
                ..getAllServices(),
              builder: (context, child) => HomeNavigation(),
            ),
          );
          // var res = jsonDecode(response.body);
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

  checkResidential(bool newValue) {
    residential = newValue;
    commercial = false;
    notifyListeners();
  }

  checkCommercial(bool newValue) {
    commercial = newValue;
    residential = false;
    notifyListeners();
  }
}
