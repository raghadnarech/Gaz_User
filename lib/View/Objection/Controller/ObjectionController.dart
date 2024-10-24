// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gas_app/Services/CustomDialog.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:http/http.dart' as http;
import 'package:gas_app/Constant/url.dart';

import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'dart:io';
import 'package:gas_app/Constant/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ObjectionController with ChangeNotifier {
  NetworkClient client = NetworkClient(http.Client());
  var reporttext = TextEditingController();
  removeimagenotif() {
    imagenotif = null;
    notifyListeners();
  }

  File? imagenotif;
  ImagePicker picker = ImagePicker();
  Future pickimage(ImageSource source, BuildContext context) async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      imagenotif = img;
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
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<Either<Failure, bool>> Report(BuildContext context) async {
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final request = await client.requestimage(
          path: AppApi.Report,
          body: {
            "text": reporttext.text,
          },
          image: await http.MultipartFile.fromPath(
            'image',
            imagenotif!.path,
          ),
        );
        var response = await request.send();

        log(response.statusCode.toString());
        response.stream.bytesToString().then((value) {
          log(value.toString());
        });
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          removeimagenotif();
          CustomRoute.RouteAndRemoveUntilTo(
            context,
            ChangeNotifierProvider(
              lazy: true,
              create: (context) => HomePageController()
                ..GetMyCancelOrders()
                ..GetMyOrders('pending')
                ..GetProfile()
                ..getalladdress(),
              builder: (context, child) => HomeNavigation(),
            ),
          );
          CustomDialog.Dialog(context,
              title: "تم رفع الاعتراض بنجاح سيتم التواصل معك باقرب وقت");
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
}
