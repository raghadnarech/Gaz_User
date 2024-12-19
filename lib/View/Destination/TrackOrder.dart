// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:gas_app/View/Destination/Controller/TrackOrderController.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';

class TrackOrder extends StatefulWidget {
  TrackOrder({this.id});
  int? id;
  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  void initState() {
    super.initState();
    trackOrderController.initState(widget.id!, context);
  }

  @override
  Widget build(BuildContext context) {
    trackOrderController = Provider.of<TrackOrderController>(context);

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: kBaseThirdyColor.withAlpha(100),
                blurRadius: 7)
          ],
          color: kBaseColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("حالة الطلب"),
                  Gap(10),
                  Text(
                    "جاري البحث عن مندوب توصيل",
                    style: TextStyle(color: kFourthColor),
                  ),
                ],
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    await trackOrderController.DialogDeleteOrUpdateOrder(
                        context);
                  },
                  child: Container(
                    height: 43,
                    width: Responsive.getWidth(context) * .8,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            color: kBaseThirdyColor.withAlpha(75),
                            blurRadius: 7)
                      ],
                      color: kFourthColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "إلغاء الطلب",
                        style: TextStyle(
                            fontSize: 15,
                            color: kBaseColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [],
        leading: IconButton(
            onPressed: () {
              trackOrderController.disposeProvider();
              CustomRoute.RoutePop(context);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text(
          "تتبع الطلب",
          style: style15semibold,
        ),
      ),
      body: Stack(
        children: [
          Consumer<HomePageController>(
            builder: (context, homePageController, child) {
              return GoogleMap(
                scrollGesturesEnabled: true,
                markers: homePageController.markers.values.toSet(),
                initialCameraPosition: homePageController.kGooglePlex,
                onMapCreated: (GoogleMapController controllerGM) {
                  homePageController.Gcontrollers = controllerGM;
                },
              );
            },
          ),
          // Positioned(
          //   bottom: 0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       boxShadow: [
          //         BoxShadow(
          //             offset: Offset(0, 0),
          //             color: kBaseThirdyColor.withAlpha(100),
          //             blurRadius: 7)
          //       ],
          //       color: kBaseColor,
          //       borderRadius: BorderRadius.vertical(
          //         top: Radius.circular(30),
          //       ),
          //     ),
          //     width: Responsive.getWidth(context),
          //     child: Padding(
          //       padding: const EdgeInsets.all(15),
          //       child: Text("بانتظار قبول مندوب.."),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
