// ignore_for_file: use_key_in_widget_constructors, prefer_collection_literals

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Responsive.dart';

import 'package:gas_app/View/Address/Controller/AddAddressController.dart';

import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarCustom(context, 'إضافة العناوين'),
        body: Center(
          child: SizedBox(
            width: Responsive.getWidth(context) * .9,
            child: Consumer<AddAddressController>(
              builder: (context, controller, child) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(30),
                    Text(
                      "أضف عنوان",
                      style: style15semibold,
                    ),
                    Gap(15),
                    Row(
                      children: [
                        Text(
                          "اسم العنوان",
                          style: style12semibold,
                        ),
                        Gap(20),
                        Expanded(
                          child: TextInputCustom(
                            controller: controller.nameAddress,
                          ),
                        ),
                      ],
                    ),
                    Gap(15),
                    Gap(20),
                    Text(
                      "اختر المنطقة",
                      style: style15semibold,
                    ),
                    Gap(10),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                          hint: Text("اختر المنطقة"),
                          value: controller.region,
                          isDense: true,
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,
                              fillColor: kThirdryColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              )),
                          onChanged: (value) => controller.changeregion(value!),
                          items: controller.listregion
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    "${e.nameAr}",
                                    style: style15semibold,
                                  )))
                              .toList()),
                    ),
                    Gap(20),
                    controller.region == null
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اختر المدينة",
                                style: style15semibold,
                              ),
                              Gap(10),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                    hint: Text("اختر المدينة"),
                                    value: controller.city,
                                    isDense: true,
                                    icon:
                                        Icon(Icons.keyboard_arrow_down_rounded),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        isDense: true,
                                        fillColor: kThirdryColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        )),
                                    onChanged: (value) =>
                                        controller.changecity(value!),
                                    items: controller.listcity
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              "${e.nameAr}",
                                              style: style15semibold,
                                            )))
                                        .toList()),
                              ),
                              Gap(20),
                            ],
                          ),
                    // Gap(20),
                    controller.city == null
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اختر الأحياء",
                                style: style15semibold,
                              ),
                              Gap(10),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                    hint: Text("اختر الحي"),
                                    value: controller.district,
                                    isDense: true,
                                    icon:
                                        Icon(Icons.keyboard_arrow_down_rounded),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        isDense: true,
                                        fillColor: kThirdryColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        )),
                                    onChanged: (value) =>
                                        controller.changedistrict(value!),
                                    items: controller.listdistrict
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              "${e.nameAr}",
                                              style: style15semibold,
                                            )))
                                        .toList()),
                              ),
                              Gap(20),
                            ],
                          ),
                    Gap(20),
                    Text(
                      "العنوان على الخريطة",
                      style: style12semibold,
                    ),
                    Gap(10),
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: kThirdryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GoogleMap(
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              scrollGesturesEnabled: true,
                              initialCameraPosition: controller.kGooglePlex,
                              onCameraMove: (position) {
                                controller.changelatlong(position);
                              },
                              onMapCreated: (GoogleMapController controllerGM) {
                                controller.gmcontroller = controllerGM;
                              },
                              gestureRecognizers: Set()
                                ..add(Factory<PanGestureRecognizer>(
                                    () => PanGestureRecognizer()))
                                ..add(Factory<VerticalDragGestureRecognizer>(
                                    () => VerticalDragGestureRecognizer()))
                                ..add(Factory<HorizontalDragGestureRecognizer>(
                                    () => HorizontalDragGestureRecognizer())),
                            ),
                          ),
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
                        ),
                      ],
                    ),
                    Gap(15),
                    Text(
                      "نوع الطلب",
                      style: style12semibold,
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CheckBoxCustom(
                                check: controller.residential!,
                                onChanged: (newValue) {
                                  controller.checkResidential(newValue!);
                                },
                              ),
                              Gap(10),
                              Text(
                                "سكني",
                                style: style12semibold,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CheckBoxCustom(
                                check: controller.commercial!,
                                onChanged: (newValue) {
                                  controller.checkCommercial(newValue!);
                                },
                              ),
                              Gap(10),
                              Text(
                                "تجاري",
                                style: style12semibold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Gap(15),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "الطابق",
                    //       style: style12semibold,
                    //     ),
                    //     Gap(20),
                    //     Expanded(
                    //       child: DropdownButtonHideUnderline(
                    //         child: DropdownButtonFormField(
                    //           isDense: true,
                    //           icon: Icon(Icons.keyboard_arrow_down_rounded),
                    //           decoration: InputDecoration(
                    //             contentPadding: EdgeInsets.all(10),
                    //             isDense: true,
                    //             fillColor: kThirdryColor,
                    //             filled: true,
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(5),
                    //               borderSide: BorderSide.none,
                    //             ),
                    //           ),
                    //           onChanged: (value) {
                    //             controller.selectedfloor(value!);
                    //           },
                    //           value: controller.selectfloor,
                    //           items: listfloor.map((e) {
                    //             return DropdownMenuItem(
                    //               value: e,
                    //               child: Text(
                    //                 "$e",
                    //                 style: style15semibold,
                    //               ),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Gap(15),
                    // Row(
                    //   children: [
                    //     CheckBoxCustom(
                    //       check: controller.haselevater == 1,
                    //       onChanged: (newValue) {
                    //         controller.checkhaselevater(newValue!);
                    //       },
                    //     ),
                    //     Gap(10),
                    //     Text(
                    //       "يوجد مصعد",
                    //       style: style15semibold,
                    //     ),
                    //   ],
                    // ),
                    Gap(50),
                    GestureDetector(
                      onTap: () async {
                        EasyLoading.show();
                        var result = await controller.AddAddress(context);

                        result.fold(
                          (l) {
                            EasyLoading.dismiss();
                            EasyLoading.showError(l.message);
                          },
                          (r) {
                            EasyLoading.dismiss();
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          height: 43,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                kPrimaryColor,
                                kBaseThirdyColor,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "إضافة",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kBaseColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(63),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
