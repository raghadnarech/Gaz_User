// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Order.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Objection/Controller/ObjectionController.dart';
import 'package:gas_app/View/Objection/ObjectionPage.dart';
import 'package:gas_app/View/Rate/Controller/RateController.dart';
import 'package:gas_app/View/Rate/RatePage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  int? id;

  oninit(int id) {
    this.id = id;
  }

  Future<Either<Failure, bool>> ReciveOrderAsUser(
      BuildContext context, Mandob mandob) async {
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.POST,
          path: AppApi.ReciveOrderAsUser(id!),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          EasyLoading.dismiss();

          showdialogratingandobjection(context, mandob);

          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          EasyLoading.dismiss();

          return Left(ResultFailure(res['message']));
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

  showdialogratingandobjection(BuildContext context, Mandob mandob) {
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
                      },
                      child: Icon(
                        Icons.close,
                        color: kBaseThirdyColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        CustomRoute.RoutePop(context);
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
                      },
                      child: Text("تخطي"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => CustomRoute.RouteTo(
                              context,
                              ChangeNotifierProvider(
                                create: (context) => ObjectionController(),
                                builder: (context, child) => ObjectionPage(),
                              )),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color(0xff722B23),
                                      Color(0xffE45545),
                                    ]),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/objection.svg',
                                  ),
                                  Gap(10),
                                  Text(
                                    maxLines: 1,
                                    "رفع اعتراض",
                                    style: style15semiboldwhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => CustomRoute.RouteTo(
                              context,
                              ChangeNotifierProvider(
                                create: (context) => RateController(),
                                builder: (context, child) => RatePage(mandob),
                              )),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color(0xff1B2A36),
                                      Color(0xff35536B),
                                    ]),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/rating.svg',
                                  ),
                                  Gap(10),
                                  Text(
                                    maxLines: 1,
                                    "تقييم المندوب",
                                    style: style15semiboldwhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
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
