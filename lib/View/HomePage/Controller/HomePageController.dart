// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Address.dart';
import 'package:gas_app/Model/Order.dart';
import 'package:gas_app/Model/Profile.dart';
import 'package:gas_app/Model/Service.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  List<Address> addressList = [];
  bool isloadingaddress = false;
  Profile profile = Profile();

  List<Orderes> listorder = [];
  List<Orderes> listcancelorder = [];

  Completer<GoogleMapController> controller = Completer();
  Map<int, Marker> markers = {};
  GoogleMapController? Gcontrollers;

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 1.4746,
  );
  List<Services> ServicesList = [];
  bool isloadinggetallservices = false;
  Future<Either<Failure, bool>> getAllServices() async {
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

  Future<Uint8List> getBytesFromSvgAsset(
      String assetName, int width, int height) async {
    // Load SVG data as a string
    String svgString = await rootBundle.loadString(assetName);

    // Convert SVG to a DrawableRoot
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, '');

    // Create a new PictureRecorder
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    // Define the desired size for the SVG
    // final viewBox = svgDrawableRoot.viewport.viewBoxRect;
    svgDrawableRoot.scaleCanvasToViewBox(
        canvas, Size(width.toDouble(), height.toDouble()));
    svgDrawableRoot.clipCanvasToViewBox(canvas);

    // Draw the SVG onto the canvas
    svgDrawableRoot.draw(
        canvas, Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()));

    // Convert the canvas to an image
    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(width, height);

    // Convert the image to a byte array
    ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void changemarkers(dynamic event) async {
      final data = jsonDecode(event.data);

    if (data['mandob_id']!=null) {
      if (event != null && event.data != null) {
      final int mandobId = data['mandob_id'];
      final double latitude = double.parse(data['latitude']);
      final double longitude = double.parse(data['longitude']);
      final Uint8List markerIcon = await getBytesFromSvgAsset(
          'assets/svg/mandob.svg', 128, 128); // Adjust size as needed
      markers[mandobId] = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: MarkerId(mandobId.toString()),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: 'Mandob $mandobId'),
      );
      Gcontrollers!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 18,
          ),
        ),
      );

      kGooglePlex = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 18,
      );

      notifyListeners();
    }
    }
  }

  Future<Either<Failure, bool>> GetProfile() async {
    notifyListeners();
    log("call this method");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetProfile,
        );
        log(response.body.toString());
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          profile = Profile.fromJson(res);
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  DateTime? servertime;
  bool isloadingorder = false;
  Future<Either<Failure, bool>> GetMyOrders(String? typeorder) async {
    isloadingorder = true;
    notifyListeners();
    log(typeorder!);
    log("call this method");
    listorder = [];
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.GetMyOrders,
            body: {
              'key': typeorder,
            });
        log(response.body.toString());
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          for (var element in res['data']) {
            listorder.add(Orderes.fromJson(element));
          }
          servertime = DateTime.parse(res['server_time']);
          isloadingorder = false;

          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadingorder = false;

          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloadingorder = false;

          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadingorder = false;

        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadingorder = false;

      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> GetMyCancelOrders() async {
    notifyListeners();
    log("call this method");
    listcancelorder = [];
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetMyCancelOrders,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          for (var element in res) {
            listcancelorder.add(Orderes.fromJson(element));
          }
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> getalladdress() async {
    isloadingaddress = true;
    addressList.clear();
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

  bool mybank = true;
  bool anotherbank = false;

  var amountcontroller = TextEditingController();
  var plus500controller = TextEditingController();
  changeaddtrasaction(String? amount) {
    amountcontroller.text = amount!;
  }

  Future<Either<Failure, bool>> AddTransaction(BuildContext context) async {
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final request = await client.requestimage(
          path: AppApi.WalletTransaction,
          body: {
            "amount": amountcontroller.text == '+500'
                ? plus500controller.text
                : amountcontroller.text,
            "status": 'add',
          },
          image: await http.MultipartFile.fromPath(
            'image',
            imagenotif.value!.path,
          ),
        );
        var response = await request.send();

        log(response.statusCode.toString());
        response.stream.bytesToString().then((value) {
          log(value.toString());
        });
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          CustomRoute.RoutePop(context);
          removeimagenotif();
          GetProfile();
          amountcontroller.clear();
          otherbank.clear();
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          notifyListeners();
          EasyLoading.dismiss();

          return Left(ResultFailure(''));
        } else {
          EasyLoading.dismiss();

          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        notifyListeners();
        EasyLoading.dismiss();

        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();

      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  TextEditingController otherbank = TextEditingController();
  Future<Either<Failure, bool>> WithdrawTransaction(
      BuildContext context) async {
    EasyLoading.show();
    log(amountcontroller.text);
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final request = await client.request(
          requestType: RequestType.POST,
          path: AppApi.WalletTransaction,
          body: anotherbank
              ? {
                  "amount": amountcontroller.text,
                  "bank": "other",
                  "bank_num": otherbank.text,
                  "status": 'withdraw',
                }
              : {
                  "amount": amountcontroller.text,
                  "bank": "own",
                  "status": 'withdraw',
                },
        );
        log(request.body.toString());
        log(request.statusCode.toString());
        if (request.statusCode == 200) {
          EasyLoading.dismiss();
          CustomRoute.RoutePop(context);
          showDialog(
            barrierDismissible: false,
            barrierLabel: '',
            context: context,
            barrierColor: Colors.transparent,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Dialog(
                  insetPadding: EdgeInsets.all(15),
                  elevation: 10,
                  alignment: Alignment(0, -.4),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: GestureDetector(
                            onTap: () {
                              CustomRoute.RoutePop(context);
                              anotherbank = false;
                              mybank = false;
                            },
                            child: Icon(
                              Icons.close,
                              color: kBaseThirdyColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "طلب سحب رصيد",
                                style: TextStyle(
                                    color: kFourthColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Gap(10),
                              Text(
                                "تمت عملية سحب الرصيد بنجاح",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Gap(20),
                              Center(
                                child: SvgPicture.asset(
                                  'assets/svg/ok.svg',
                                  width: Responsive.getWidth(context) * .7,
                                ),
                              ),
                              Gap(20),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          GetProfile();
          amountcontroller.clear();
          otherbank.clear();
          notifyListeners();
          return Right(true);
        } else if (request.statusCode == 404) {
          EasyLoading.dismiss();
          return Left(ResultFailure(''));
        } else {
          EasyLoading.dismiss();
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        notifyListeners();
        EasyLoading.dismiss();
        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  removeimagenotif() {
    imagenotif.value = null;
    notifyListeners();
  }

  ValueNotifier<File?> imagenotif = ValueNotifier<File?>(null);
  ImagePicker picker = ImagePicker();
  Future pickimage(ImageSource source, BuildContext context) async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      imagenotif.value = img;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: kPrimaryColor,
            toolbarWidgetColor: kBaseColor,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: kPrimaryColor,
            backgroundColor: kBaseColor,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    log('filePath');
    log(imageFile.toString());
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
