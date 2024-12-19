// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gas_app/Services/CustomDialog.dart';
import 'package:gas_app/View/Destination/TrackOrder.dart';
import 'package:gas_app/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/Model/Address.dart';
import 'package:gas_app/Model/Cart.dart';
import 'package:gas_app/Model/CartProduct.dart';
import 'package:gas_app/Model/Fees.dart';
import 'package:gas_app/Model/Product.dart';
import 'package:gas_app/Model/Service.dart';
import 'package:gas_app/Model/SubSupplier.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:permission_handler/permission_handler.dart';

class CartController with ChangeNotifier {
  List<CartProduct> listcartproduct = [];
  Cart cart = Cart(listcartproduct: []);
  Address? address;
  Services? services;
  SubSupplier? supplier;
  TextEditingController time = TextEditingController();
  String? payment_kind = 'cash';
  bool toDoor = false;
  bool sheduleappoiment = false;
  bool toHouse = false;
  bool isDiscount = false;
  Completer<GoogleMapController> controller = Completer();
  Map<int, Marker> markers = {};
  GoogleMapController? Gcontrollers;
  double? lat = 0;
  double? long = 0;

  getCurrentlocation() async {
    var status = await Permission.location.request();
    log(status.toString());

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    Gcontrollers!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat!, long!),
      zoom: 14.4746,
    )));
    Changeposetinon();
    notifyListeners();
  }

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 1.4746,
  );
  bool cash = true;
  bool credit = false;
  bool pos = false;
  bool e_wallet = false;
  String? date_wanted;

  double totalcostwithfees = 0;
  double totalcost = 0;

  double costfees = 0;
  int costfloors = 0;
  int selectfloor = 0;

  Fees fees = Fees();
  bool isloadingfees = false;
  bool? residential = true;
  bool? commercial = false;
  int? haselevater = 0;
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

  checkhaselevater(bool newValue) {
    if (newValue) {
      toHouse = true;
      toDoor = false;
      costfloors = 0;
      updateTotalCost();
      notifyListeners();
    } else {
      toHouse = true;
      toDoor = false;
      updateTotalCost();
      notifyListeners();
    }
    haselevater = newValue ? 1 : 0;
    updateTotalCost();

    notifyListeners();
  }

  SelectAppointment(BuildContext context) {
    showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    ).then((value) {
      time.text = value!.format(context).toString();
      notifyListeners();
    });
  }

  selectedfloor(int value) {
    costfloors = 0;
    notifyListeners();
    selectfloor = value;
    if (selectfloor == 0) {
      haselevater = 1;
    }

    notifyListeners();
    updateTotalCost();
  }

  bool mylocation = true;
  bool selectaddress = false;
  bool selectlocation = false;
  checkmylocation() {
    address = null;
    mylocation = true;
    selectaddress = false;
    selectlocation = false;
    getCurrentlocation();
    notifyListeners();
  }

  checkselectaddress() async {
    homePageController.getalladdress();
    mylocation = false;
    selectaddress = true;
    selectlocation = false;
    notifyListeners();
  }

  checkselectlocation() {
    address = null;
    mylocation = false;
    selectaddress = false;
    selectlocation = true;
    notifyListeners();
  }

  NetworkClient client = NetworkClient(http.Client());

  void addProduct(
    Product product,
    int quantity,
  ) {
    cart.listcartproduct.add(CartProduct(
      service: services,
      subSupplier: supplier,
      Quan: quantity,
      product: product,
    ));
    updateTotalCost();
  }

  void addGazProduct(Product product, int quantity, String? code) {
    cart.listcartproduct.add(
      CartProduct(
        service: services,
        subSupplierid: product.supplierId,
        Quan: quantity,
        product: product,
      ),
    );
    updateTotalCost();
  }

  @override
  void dispose() {
    cart = Cart(listcartproduct: []);
    super.dispose();
  }

  void removeProductFromCart(CartProduct cartProduct) {
    cart.listcartproduct.removeWhere((element) => element == cartProduct);
    updateTotalCost();
  }

  void updateTotalCost() {
    totalcost = cart.getTotalPrice();
    totalcostwithfees = totalcost + calculateTotalFees();
    notifyListeners();
  }

  void changeToHouse(bool value) {
    toHouse = value;
    toDoor = false;
    costfloors = 0;
    updateTotalCost();
  }

  void changeToDoor(bool value) {
    toDoor = value;

    if (toDoor) {
      selectfloor = 1;
      costfloors = fees.floorFee!;
      toHouse = false;
    } else {
      toHouse = false;
      costfloors = 0;
    }
    updateTotalCost();
  }

  void selectedFloor(int value) {
    costfloors = 0;
    notifyListeners();
    if (selectfloor != value) {
      selectfloor = value;
      costfloors = selectfloor > 0
          ? fees.floorFee! * selectfloor * cart.listcartproduct.length
          : fees.floorFee! * cart.listcartproduct.length;
      updateTotalCost();
    }
  }

  void changeIsDiscount(bool value) {
    isDiscount = value;
    notifyListeners();
  }

  void changePaymentMethod(String method) {
    payment_kind = method;
    cash = method == "cash";
    credit = method == "credit";
    e_wallet = method == "wallet";
    pos = method == "pos";
    notifyListeners();
  }

  Future<void> selectServices(Services newServices) async {
    log("select services");
    services = newServices;
    notifyListeners();
  }

  void selectSupplier(SubSupplier newSupplier) {
    supplier = newSupplier;
    notifyListeners();
  }

  void selectAddress(Address newAddress) {
    address = newAddress;
    lat = address!.lat;
    long = address!.lang;
    Gcontrollers!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat!, long!),
      zoom: 14.4746,
    )));
    Changeposetinon();
    notifyListeners();
  }

  double calculateTotalFees() {
    double totalFees = 0;
    costfloors = 0;
    notifyListeners();
    if (toDoor) {
      totalFees += selectfloor > 0
          ? fees.floorFee! * selectfloor * cart.listcartproduct.length
          : fees.floorFee! * cart.listcartproduct.length;
      costfloors = selectfloor > 0
          ? fees.floorFee! * selectfloor * cart.listcartproduct.length
          : fees.floorFee! * cart.listcartproduct.length;
    }
    return totalFees;
  }

  void printInfo() {
    cart.toDoor = toDoor;
    cart.toHouse = toHouse;
    cart.isDiscount = isDiscount;
    cart.address_id = address!.id;
    cart.date_wanted = date_wanted;
    cart.haselevater = haselevater;
    cart.selectfloor = selectfloor;
    log(cart.toJson().toString());
    notifyListeners();
  }

  EmptyCart() {
    cart = Cart(listcartproduct: []);
    notifyListeners();
  }

  Future<Either<Failure, bool>> orderStore(BuildContext context) async {
    cart.toDoor = toDoor;
    cart.toHouse = toHouse;
    cart.isDiscount = isDiscount;
    cart.address_id = address!.id;
    cart.date_wanted = date_wanted;
    cart.haselevater = haselevater;
    cart.selectfloor = selectfloor;
    cart.lat = lat;
    cart.long = long;

    Map<String, dynamic> requestBody = cart.toJson();

    log(requestBody.toString());
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        http.Response response = await http.post(
          Uri.parse("${AppApi.url}${AppApi.StoreOrder}"),
          headers: {
            "Accept": "application/json",
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${ServicesProvider.gettoken()}'
          },
          body: json.encode(requestBody),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          log(response.body);
          log(response.statusCode.toString());
          EasyLoading.dismiss();
          int id = jsonDecode(response.body)['order']['id'];
          await pointSystemController.StorePoint(
              ServicesProvider.getphone(), 'UserOrder');
          CustomRoute.RouteReplacementTo(
              context,
              TrackOrder(
                id: id,
              ));
          EmptyCart();
          return Right(true);
        } else if (response.statusCode == 400) {
          EasyLoading.dismiss();
          CustomDialog.Dialog(context,
              title: "لم يتم تخصيص طريقة الطلب توجه الى تخصيص الخيارات");
          return Left(ResultFailure(''));
        } else if (response.statusCode == 404) {
          EasyLoading.dismiss();

          return Left(ResultFailure(''));
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

  List<String> generateTimeSlots(
      TimeOfDay startTime, TimeOfDay endTime, Duration interval) {
    List<String> timeSlots = [];
    TimeOfDay currentTime = startTime;

    while (currentTime.hour < endTime.hour ||
        (currentTime.hour == endTime.hour &&
            currentTime.minute < endTime.minute)) {
      String formattedTime = formatTimeOfDay(currentTime);
      timeSlots.add(formattedTime);

      // Add interval
      currentTime = currentTime.replacing(
        hour: currentTime.minute + interval.inMinutes >= 60
            ? currentTime.hour + 1
            : currentTime.hour,
        minute: (currentTime.minute + interval.inMinutes) % 60,
      );
    }

    return timeSlots;
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String? textlocation = '';
  changelatlong(CameraPosition position) {
    lat = position.target.latitude;
    long = position.target.longitude;
    // notifyListeners();
  }

  Changeposetinon() {
    if (selectlocation) {
      getlocation();
    } else {
      getlocation();
    }
    // notifyListeners();
  }

  void getlocation() async {
    textlocation = await ServicesProvider.saveLocation(lat, long);
    notifyListeners();
  }

  List<String> timeSlots = [];
  Future<Either<Failure, bool>> getFeesValues(BuildContext context) async {
    isloadingfees = true;
    notifyListeners();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetFeesValues,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          fees = Fees.fromJson(res);
          timeSlots = generateTimeSlots(
              fees.startTime!, fees.endTime!, Duration(minutes: 30));
          isloadingfees = false;

          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadingfees = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloadingfees = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadingfees = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadingfees = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
