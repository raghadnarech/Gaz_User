// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Destination/Controller/TrackOrderController.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TrackMandob extends StatefulWidget {
  TrackMandob(
      {this.orderid,
      this.mandobid,
      this.name,
      this.phone,
      this.total_with_fees});
  int? mandobid;
  int? orderid;
  String? name;
  String? phone;
  String? total_with_fees;
  @override
  State<TrackMandob> createState() => _TrackMandobState();
}

class _TrackMandobState extends State<TrackMandob> {
  @override
  void initState() {
    super.initState();
    trackOrderController.initStateMandobLocation(
        widget.orderid!, widget.mandobid!, context);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
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
                        trackOrderController.status!,
                        style: TextStyle(color: kFourthColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("المندوب"),
                      Gap(10),
                      Text("${widget.name!}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("الوقت المتوقع للاستلام"),
                      Gap(10),
                      Text("ربع ساعة"),
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
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: kBaseThirdyColor.withAlpha(100),
                      blurRadius: 7)
                ],
                color: kBaseColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (await canLaunchUrlString(
                              "tel:${widget.phone!}")) {
                            launchUrlString("tel:${widget.phone!}");
                            throw Exception(
                                'Could not launch tel:${widget.phone!}');
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.phone),
                            Gap(10),
                            Text("${widget.phone}")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.chat),
                          Gap(10),
                          Text("${widget.phone}")
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.mail),
                          Gap(10),
                          Text("ارسل استفسار")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controllerGM) {
                  homePageController.Gcontrollers = controllerGM;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
