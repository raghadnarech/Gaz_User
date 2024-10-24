// ignore_for_file: use_build_context_synchronously

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
import 'package:gas_app/Model/Profile.dart';
import 'package:gas_app/Services/CustomDialog.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditProfileController with ChangeNotifier {
  Profile profile = Profile();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confpasswordcontroller = TextEditingController();
  TextEditingController oldpasswordcontroller = TextEditingController();

  oninit(Profile profile) {
    this.profile = profile;
    usernamecontroller.text = profile.userName!;
    emailcontroller.text = profile.email!;
    phonecontroller.text = profile.phone!;
  }

  bool isloadingprofile = true;
  Future<Either<Failure, bool>> GetProfile() async {
    isloadingprofile = true;
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
          oninit(profile);

          isloadingprofile = false;
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          isloadingprofile = false;
          notifyListeners();
          return Left(ResultFailure(res['message']));
        } else {
          isloadingprofile = false;
          notifyListeners();
          return Left(GlobalFailure());
        }
      } else {
        isloadingprofile = false;
        notifyListeners();
        return Left(ServerFailure());
      }
    } catch (e) {
      isloadingprofile = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  static NetworkClient client = NetworkClient(http.Client());

  Future<Either<Failure, bool>> UpdateProfile(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        http.MultipartRequest request;
        if (logo == null) {
          request = await client.requestwithoutimage(
            path: AppApi.UpdateProfile,
            body: {
              "user_name": usernamecontroller.text,
              "email": emailcontroller.text,
              "phone": phonecontroller.text,
              // "address_id": bankidcontroller.text,
              // "code": banknamecontroller.text,
              "order_type": "",
              // nearest_man
              // code => code request
              // manager => id manager
            },
          );
        } else {
          final multipartFile = await http.MultipartFile.fromPath(
            'logo',
            logo!.path,
          );
          request = await client.requestimage(
              path: AppApi.UpdateProfile,
              body: {
                "user_name": usernamecontroller.text,
                "email": emailcontroller.text,
                "phone": phonecontroller.text,
              },
              image: multipartFile);
        }
        var response = await request.send();
        log(response.statusCode.toString());
        response.stream.bytesToString().then((value) {
          log(value.toString());
        });
        if (response.statusCode == 200) {
          CustomRoute.RouteAndRemoveUntilTo(
            context,
            ChangeNotifierProvider(
              create: (context) => HomePageController()
                ..GetProfile()
                ..GetMyCancelOrders()
                ..getalladdress()
                ..GetMyOrders('pending'),
              builder: (context, child) => HomeNavigation(),
            ),
          );
          CustomDialog.Dialog(context, title: "تم تعديل الملف الشخصي بنجاح");
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

  Future<Either<Failure, bool>> UpdateUserName(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        http.MultipartRequest request;
        // if (logo == null) {
        request = await client.requestwithoutimage(
          path: AppApi.UpdateProfile,
          body: {
            "key": 'user_name',
            "user_name": usernamecontroller.text,
            // "email": emailcontroller.text,
            // "phone": phonecontroller.text,
            // "address_id": bankidcontroller.text,
            // "code": banknamecontroller.text,
            // "order_type": "",
            // nearest_man
            // code => code request
            // manager => id manager
          },
        );
        // } else {
        //   final multipartFile = await http.MultipartFile.fromPath(
        //     'logo',
        //     logo!.path,
        //   );
        //   request = await client.requestimage(
        //       path: AppApi.UpdateProfile,
        //       body: {
        //         "user_name": usernamecontroller.text,
        //         "email": emailcontroller.text,
        //         "phone": phonecontroller.text,
        //         "bank_num": bankidcontroller.text,
        //         "bank_name": banknamecontroller.text,
        //       },
        //       image: multipartFile);
        // }
        var response = await request.send();
        log(response.statusCode.toString());
        response.stream.bytesToString().then((value) {
          log(value.toString());
        });
        if (response.statusCode == 200) {
          CustomRoute.RoutePop(context);
          GetProfile();
          CustomDialog.Dialog(context, title: "تم تعديل الملف الشخصي بنجاح");
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

  Future<Either<Failure, bool>> UpdateEmail(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        http.MultipartRequest request;
        // if (logo == null) {
        request = await client.requestwithoutimage(
          path: AppApi.UpdateProfile,
          body: {
            "key": 'email',
            "email": emailcontroller.text,
            // "email": emailcontroller.text,
            // "phone": phonecontroller.text,
            // "address_id": bankidcontroller.text,
            // "code": banknamecontroller.text,
            // "order_type": "",
            // nearest_man
            // code => code request
            // manager => id manager
          },
        );
        // } else {
        //   final multipartFile = await http.MultipartFile.fromPath(
        //     'logo',
        //     logo!.path,
        //   );
        //   request = await client.requestimage(
        //       path: AppApi.UpdateProfile,
        //       body: {
        //         "user_name": usernamecontroller.text,
        //         "email": emailcontroller.text,
        //         "phone": phonecontroller.text,
        //         "bank_num": bankidcontroller.text,
        //         "bank_name": banknamecontroller.text,
        //       },
        //       image: multipartFile);
        // }
        var response = await request.send();
        log(response.statusCode.toString());
        response.stream.bytesToString().then((value) {
          log(value.toString());
        });
        if (response.statusCode == 200) {
          CustomRoute.RoutePop(context);
          GetProfile();
          CustomDialog.Dialog(context, title: "تم تعديل الملف الشخصي بنجاح");
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

  Future<Either<Failure, bool>> UpdatePassword(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        http.MultipartRequest request;
        // if (logo == null) {
        request = await client.requestwithoutimage(
          path: AppApi.UpdateProfile,
          body: {
            "key": 'password ',
            "password ": passwordcontroller.text,
            'old_password': oldpasswordcontroller.text,
            // "email": emailcontroller.text,
            // "phone": phonecontroller.text,
            // "address_id": bankidcontroller.text,
            // "code": banknamecontroller.text,
            // "order_type": "",
            // nearest_man
            // code => code request
            // manager => id manager
          },
        );
        // } else {
        //   final multipartFile = await http.MultipartFile.fromPath(
        //     'logo',
        //     logo!.path,
        //   );
        //   request = await client.requestimage(
        //       path: AppApi.UpdateProfile,
        //       body: {
        //         "user_name": usernamecontroller.text,
        //         "email": emailcontroller.text,
        //         "phone": phonecontroller.text,
        //         "bank_num": bankidcontroller.text,
        //         "bank_name": banknamecontroller.text,
        //       },
        //       image: multipartFile);
        // }
        var response = await request.send();
        log(response.statusCode.toString());
        response.stream.bytesToString().then((value) {
          log(value.toString());
        });
        if (response.statusCode == 200) {
          CustomRoute.RoutePop(context);
          GetProfile();
          CustomDialog.Dialog(context, title: "تم تعديل الملف الشخصي بنجاح");
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

  Future<Either<Failure, bool>> UpdatePhone(BuildContext context) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        http.MultipartRequest request;
        // if (logo == null) {
        request = await client.requestwithoutimage(
          path: AppApi.UpdateProfile,
          body: {
            "key": 'phone',
            "phone": phonecontroller.text,
            // "email": emailcontroller.text,
            // "phone": phonecontroller.text,
            // "address_id": bankidcontroller.text,
            // "code": banknamecontroller.text,
            // "order_type": "",
            // nearest_man
            // code => code request
            // manager => id manager
          },
        );
        // } else {
        //   final multipartFile = await http.MultipartFile.fromPath(
        //     'logo',
        //     logo!.path,
        //   );
        //   request = await client.requestimage(
        //       path: AppApi.UpdateProfile,
        //       body: {
        //         "user_name": usernamecontroller.text,
        //         "email": emailcontroller.text,
        //         "phone": phonecontroller.text,
        //         "bank_num": bankidcontroller.text,
        //         "bank_name": banknamecontroller.text,
        //       },
        //       image: multipartFile);
        // }
        var response = await request.send();
        log(response.statusCode.toString());
        response.stream.bytesToString().then((value) {
          log(value.toString());
        });
        if (response.statusCode == 200) {
          CustomRoute.RoutePop(context);
          GetProfile();
          CustomDialog.Dialog(context, title: "تم تعديل الملف الشخصي بنجاح");
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

  File? logo;
  ImagePicker picker = ImagePicker();

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

  Showdialogeditusername(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("تغيير اسم الحساب"),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextInputCustom(
                                controller: usernamecontroller,
                                icon: Icon(Icons.account_circle_rounded),
                              ),
                            ),
                          ],
                        ),
                        Gap(50),
                        GestureDetector(
                          onTap: () => UpdateUserName(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              height: 43,
                              width: Responsive.getWidth(context) * .8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      color: kBaseThirdyColor.withAlpha(75),
                                      blurRadius: 7)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "تعديل و حفظ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: kBaseColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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
  }

  Showdialogeditemail(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("تغيير البريد الالكتروني"),
                        Gap(20),
                        Text("البريد الالكتروني الجديد"),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextInputCustom(
                                controller: emailcontroller,
                                icon: Icon(Icons.mail),
                              ),
                            ),
                          ],
                        ),
                        Gap(50),
                        GestureDetector(
                          onTap: () => UpdateEmail(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              height: 43,
                              width: Responsive.getWidth(context) * .8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      color: kBaseThirdyColor.withAlpha(75),
                                      blurRadius: 7)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "إرسال رمز التحقق",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: kBaseColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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
  }

  Showdialogeditphone(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("تغيير رقم الهاتف"),
                        Gap(20),
                        Text("رقم الهاتف الجديد"),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.ltr,
                          children: [
                            Expanded(
                              child: TextInputCustom(
                                controller: phonecontroller,
                                icon: Icon(Icons.phone),
                              ),
                            ),
                          ],
                        ),
                        Gap(50),
                        GestureDetector(
                          onTap: () => UpdatePhone(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              height: 43,
                              width: Responsive.getWidth(context) * .8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      color: kBaseThirdyColor.withAlpha(75),
                                      blurRadius: 7)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "إرسال رمز التحقق",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: kBaseColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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
  }

  Showdialogeditpassword(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("تغيير كلمة السر"),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("كلمة السر القديمة"),
                            Gap(20),
                            Expanded(
                              child: TextInputCustom(
                                controller: oldpasswordcontroller,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("كلمة السر الجديدة"),
                            Gap(20),
                            Expanded(
                              child: TextInputCustom(
                                controller: passwordcontroller,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("تأكيد كلمة السر الجديدة"),
                            Gap(20),
                            Expanded(
                              child: TextInputCustom(
                                controller: confpasswordcontroller,
                                validator: (p0) {
                                  if (p0 != passwordcontroller.text) {
                                    return 'كلمتا المرور غير متطابقتين';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Gap(50),
                        GestureDetector(
                          onTap: () => UpdatePassword(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              height: 43,
                              width: Responsive.getWidth(context) * .8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      color: kBaseThirdyColor.withAlpha(75),
                                      blurRadius: 7)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "تعديل وحفظ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: kBaseColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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
  }
}
