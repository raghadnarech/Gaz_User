import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Controller/CartController.dart';
import 'package:gas_app/Model/Address.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
import 'package:gas_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text(
          "الوجهة",
          style: style15semibold,
        ),
      ),
      bottomNavigationBar: Consumer<CartController>(
        builder: (context, controller, child) => Container(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text("إلى أين تريد التوصيل"),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CheckBoxCustom(
                                check: controller.mylocation,
                                onChanged: (value) =>
                                    controller.checkmylocation(),
                              ),
                              Gap(10),
                              Text("موقعك الحالي"),
                            ],
                          ),
                          Gap(8),
                          Row(
                            children: [
                              CheckBoxCustom(
                                check: controller.selectaddress,
                                onChanged: (value) =>
                                    controller.checkselectaddress(),
                              ),
                              Gap(10),
                              Text("اختر عنوان"),
                            ],
                          ),
                          Gap(8),
                          //              controller.isloadingaddress
                          // ? Shimmer.fromColors(
                          //     baseColor:
                          //         Color.fromARGB(255, 229, 229, 229).withAlpha(150),
                          //     highlightColor: kBaseColor,
                          //     child: Container(
                          //       color: kBaseColor,
                          //       height: 45,
                          //       width: double.infinity,
                          //       child: Text(''),
                          //     ),
                          //   )
                          // :
                          if (cartController.selectaddress)
                            Consumer<HomePageController>(
                              builder: (context, controller, child) =>
                                  controller.isloadingaddress
                                      ? Shimmer.fromColors(
                                          baseColor:
                                              Color.fromARGB(255, 229, 229, 229)
                                                  .withAlpha(150),
                                          highlightColor: kBaseColor,
                                          child: Container(
                                            color: kBaseColor,
                                            height: 45,
                                            width: double.infinity,
                                            child: Text(''),
                                          ),
                                        )
                                      : DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<Address>(
                                            isDense: true,
                                            hint: Text(
                                              cartController.address == null
                                                  ? "اختر عنوان"
                                                  : cartController
                                                      .address!.name!,
                                              style: style12semibold,
                                            ),
                                            icon: Icon(Icons
                                                .keyboard_arrow_down_rounded),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              isDense: true,
                                              fillColor: kThirdryColor,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            onChanged: (Address? address) {
                                              if (address != null) {
                                                cartController
                                                    .selectAddress(address);
                                                // log('تم تحديد العنوان: $address');
                                              }
                                            },
                                            items: controller.addressList
                                                .map((address) {
                                              return DropdownMenuItem<Address>(
                                                value: address,
                                                child: Text(
                                                  '${address.name}',
                                                  style: style15semibold,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                            ),
                          Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckBoxCustom(
                                check: controller.selectlocation,
                                onChanged: (value) =>
                                    controller.checkselectlocation(),
                              ),
                              Gap(10),
                              Expanded(
                                child: Text(
                                  "حدد موقع التوصيل على الخريطة",
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("العنوان المطلوب")),
                    Gap(10),
                    Expanded(
                        child: AutoSizeText(
                      controller.textlocation!,
                      minFontSize: 12,
                    )),
                  ],
                ),
                MaxGap(40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () async {
                      await cartController.orderStore(context);
                    },
                    child: Container(
                      height: 43,
                      width: Responsive.getWidth(context) * .8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: kBaseThirdyColor.withAlpha(75),
                            blurRadius: 7,
                          )
                        ],
                        color: Color(0xff445461),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "ابدأ البحث",
                          style: TextStyle(
                            fontSize: 15,
                            color: kBaseColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<CartController>(
        builder: (context, controller, child) => Stack(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  GoogleMap(
                    scrollGesturesEnabled:
                        controller.selectlocation ? true : false,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: controller.kGooglePlex,
                    onMapCreated: (GoogleMapController controllerGM) {
                      controller.Gcontrollers = controllerGM;
                    },
                    onCameraIdle: () {
                      controller.Changeposetinon();
                    },
                    onCameraMove: (position) {
                      controller.changelatlong(position);
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   child: ,
            // )
          ],
        ),
      ),
    );
  }
}
