// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/Model/Country.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/Auth/AuthPhone/AuthPhone.dart';
import 'package:gas_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:gas_app/View/Auth/Login/View/Login.dart';
import 'package:gas_app/main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SignupController with ChangeNotifier {
  @override
  void dispose() {
    logo = null;
    usernamecontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();
    passwordcontroller.clear();
    confirmpasswordcontroller.clear();
    bankidcontroller.clear();
    banknamecontroller.clear();
    log("close signup");
    super.dispose();
  }

  // List<String> liststate = ["السعودية", "الإمارات"];
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController bankidcontroller = TextEditingController();
  TextEditingController banknamecontroller = TextEditingController();
  TextEditingController invitecode_controller = TextEditingController();
  File? logo;
  ImagePicker picker = ImagePicker();
  static NetworkClient client = NetworkClient(http.Client());

  Future<Either<Failure, bool>> Signup(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final multipartFile = await http.MultipartFile.fromPath(
          'logo',
          logo!.path,
        );

        var request = await client.requestimage(
            path: AppApi.Signup,
            body: {
              "user_name": usernamecontroller.text,
              "email": emailcontroller.text,
              "password": passwordcontroller.text,
              "phone": state!.name == "المملكة العربية السعودية"
                  ? "+966${phonecontroller.text}"
                  : "+971${phonecontroller.text}",
              "country_id": state!.id.toString(),
            },
            image: multipartFile);
        var response = await request.send();
        log(response.statusCode.toString());
        var res;
        await response.stream.bytesToString().then((value) async {
          res = await jsonDecode(value);
          log(res.toString());
        });

        if (response.statusCode == 200) {
          await ServicesProvider.savephonepoint(
              res['data']['phone'].toString());
          await pointSystemController.StoreUser(
            email: emailcontroller.text,
            name: usernamecontroller.text,
            password: passwordcontroller.text,
            invitecode: invitecode_controller.text,
            phone: res['data']['phone'],
          );
          CustomRoute.RouteReplacementTo(
            context,
            AuthPhone(),
          );

          return Right(true);
        } else if (response.statusCode == 404) {
          return Left(ResultFailure(''));
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

  Country? state = Country(id: 0, name: "");
  bool isloadingcountry = true;
  List<Country> countries = [];
  Future<Either<Failure, bool>> GetCountry() async {
    isloadingcountry = true;
    notifyListeners();
    countries.clear();
    log("call this method");
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetCountry,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          for (var element in res) {
            countries.add(Country.fromJson(element));
            log(element.toString());
          }
          state = countries[0];
          isloadingcountry = false;
          notifyListeners();
          log(res.toString());
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadingcountry = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloadingcountry = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadingcountry = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadingcountry = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  SelectImage(BuildContext context) async {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("من أين تريد اختيار الصورة"),
                        Gap(30),
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await pickimage(ImageSource.camera, context);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    height: 75,
                                    'assets/svg/camera.svg',
                                    color: kPrimaryColor,
                                  ),
                                  Gap(10),
                                  Text("الكاميرا")
                                ],
                              ),
                            ),
                            MaxGap(60),
                            GestureDetector(
                              onTap: () async {
                                await pickimage(ImageSource.gallery, context);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      height: 75,
                                      'assets/svg/gallary.svg',
                                      color: kPrimaryColor),
                                  Gap(10),
                                  Text("المعرض")
                                ],
                              ),
                            )
                          ],
                        ),
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
  }

  removelogo() {
    logo = null;
    notifyListeners();
  }

  toLoginPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => LoginController(),
        lazy: true,
        builder: (context, child) => Login(),
      ),
    );
  }

  Future pickimage(ImageSource source, BuildContext context) async {
    try {
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      logo = img;
      CustomRoute.RoutePop(context);
      notifyListeners();
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
    // croppedImage.printInfo();
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
