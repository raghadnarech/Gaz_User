// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/Lists.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Controller/CartController.dart';
import 'package:gas_app/Services/CustomDialog.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Destination/Destination.dart';
import 'package:gas_app/View/HomeNavigation/HomeNavigation.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
import 'package:gas_app/View/Widgets/Drawer/CustomDrawer.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cartController = Provider.of<CartController>(context);
    homePageController = Provider.of<HomePageController>(context);
    // List<String> timeSlots = [];
    // if (cartController.fees.startTime != null &&
    //     cartController.fees.endTime != null) {
    //   timeSlots = cartController.generateTimeSlots(
    //     cartController.fees.startTime!,
    //     cartController.fees.endTime!,
    //     Duration(minutes: 30),
    //   );
    // }
    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => scaffoldKey.currentState?.openEndDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/svg/menu.svg',
                width: 30,
                height: 25,
              ),
            ),
          ),
        ],
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text(
          "السلة",
          style: style15semibold,
        ),
      ),
      body: cartController.cart.listcartproduct.isEmpty
          ? Center(child: Text("لايوجد منتجات في السلة"))
          : ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 15),
              physics: BouncingScrollPhysics(),
              children: [
                // Gap(30),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // Row(
                //     //   children: [
                //     //     CheckBoxCustom(
                //     //       check: selectall,
                //     //       onChanged: (value) {
                //     //         selectall = value!;
                //     //       },
                //     //     ),
                //     //     Gap(10),
                //     //     Text(
                //     //       "تحديد الكل",
                //     //       style: style12semibold,
                //     //     ),
                //     //   ],
                //     // ),
                // Row(
                //   children: [
                //     CheckBoxCustom(
                //       check: cartController.sheduleappoiment,
                //       onChanged: (value) {
                //         cartController.sheduleappoiment = value!;
                //         cartController.date_wanted = '';
                //         cartController.notifyListeners();
                //       },
                //     ),
                //     Gap(10),
                //     Text(
                //       "جدولة الموعد",
                //       style: style12semibold,
                //     ),
                //   ],
                // ),
                // Gap(10),

                //   ],
                // ),
                Gap(20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Text(textAlign: TextAlign.center, "الصنف")),
                    Expanded(
                        child: Text(textAlign: TextAlign.center, "المنتج")),
                    Expanded(child: Text(textAlign: TextAlign.center, "السعر")),
                    Expanded(child: Text(textAlign: TextAlign.center, "العدد")),
                    Expanded(
                        child: Text(textAlign: TextAlign.center, "الاجمالي")),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartController.cart.listcartproduct.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          color: Color(0xffEAEFF3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // CheckBoxCustom(
                            //   check: sheduleappoiment,
                            //   onChanged: (value) {
                            //     sheduleappoiment = value!;
                            //   },
                            // ),
                            // Gap(10),
                            Expanded(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "${cartController.cart.listcartproduct[index].service!.name}")),
                            Expanded(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "${cartController.cart.listcartproduct[index].product!.name}")),
                            Expanded(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "${cartController.cart.listcartproduct[index].product!.price}")),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: kSecendryColor,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cartController
                                                .cart.listcartproduct[index]
                                                .incrementproduct();
                                            cartController.updateTotalCost();
                                            cartController.notifyListeners();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            // color: kPrimaryColor,
                                            child: Icon(
                                              Icons.add,
                                              color: kBaseThirdyColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        MaxGap(6),
                                        Center(
                                          child: AutoSizeText(
                                            "${cartController.cart.listcartproduct[index].Quan}",
                                            minFontSize: 18,
                                            style: TextStyle(
                                                // fontSize: 15,
                                                color: kBaseColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        MaxGap(6),
                                        cartController
                                                    .cart
                                                    .listcartproduct[index]
                                                    .Quan ==
                                                1
                                            ? GestureDetector(
                                                onTap: () {
                                                  cartController
                                                      .removeProductFromCart(
                                                          cartController.cart
                                                                  .listcartproduct[
                                                              index]);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  // color: kPrimaryColor,
                                                  child: Icon(
                                                    Icons.delete_rounded,
                                                    color: kBaseThirdyColor,
                                                    size: 18,
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  if (cartController
                                                          .cart
                                                          .listcartproduct[
                                                              index]
                                                          .Quan !=
                                                      1) {
                                                    cartController.cart
                                                        .listcartproduct[index]
                                                        .dcrementproduct();
                                                    cartController
                                                        .updateTotalCost();
                                                    cartController
                                                        .notifyListeners();
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  // color: kPrimaryColor,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: kBaseThirdyColor,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "${cartController.cart.listcartproduct[index].getTotalPrice()}")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اجمالي عدد المنتجات",
                      style: style15semibold,
                    ),
                    Gap(5),
                    Text(
                      "${cartController.cart.listcartproduct.length}",
                      style: style15semibold,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اجمالي المنتجات",
                      style: style15semibold,
                    ),
                    Gap(5),
                    Text(
                      "${cartController.cart.getTotalPrice()} ريال",
                      style: style15semibold,
                    )
                  ],
                ),
                Gap(20),

                Divider(
                  color: kBaseThirdyColor,
                ),

                Text(
                  "رسوم التوصيل للأدوار العليا",
                  style: style15semibold,
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckBoxCustom(
                            check: cartController.haselevater == 1,
                            onChanged: (newValue) {
                              cartController.checkhaselevater(true);
                            },
                          ),
                          Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "يوجد مصعد",
                                  style: style15semibold,
                                ),
                                Text(
                                  "مجاناً",
                                  style: style12semibold.copyWith(
                                      color: kFourthColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckBoxCustom(
                            check: cartController.haselevater == 0,
                            onChanged: (newValue) {
                              cartController.checkhaselevater(false);
                            },
                          ),
                          Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "لا يوجد مصعد",
                                  style: style15semibold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(15),

                // Gap(15),
                cartController.haselevater == 1
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckBoxCustom(
                                  check: cartController.toHouse,
                                  onChanged: (value) =>
                                      cartController.changeToHouse(value!),
                                ),
                                Gap(5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "التوصيل على باب العمارة",
                                        style: style15semibold,
                                      ),
                                      Text(
                                        "مجاناً",
                                        style: style12semibold.copyWith(
                                            color: kFourthColor),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckBoxCustom(
                                  check: cartController.toDoor,
                                  onChanged: (value) =>
                                      cartController.changeToDoor(value!),
                                ),
                                Gap(5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "التوصيل على باب المنزل",
                                        style: style15semibold,
                                      ),
                                      Text(
                                        "رسوم اضافية ${cartController.fees.floorFee} ريال لكل طابق على الأنبوبة",
                                        style: style12semibold.copyWith(
                                            color: kFourthColor),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                Gap(15),

                (cartController.toHouse || cartController.haselevater == 1)
                    ? Container()
                    : Row(
                        children: [
                          Text(
                            "اختر الطابق",
                            style: style15semibold,
                          ),
                          Gap(10),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
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
                                  ),
                                ),
                                onChanged: (value) {
                                  cartController.selectedfloor(value!);
                                },
                                value: cartController.selectfloor,
                                items: listfloor.map(
                                  (e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e == 0
                                            ? "الأرضي"
                                            : e == -1
                                                ? "بدروم1"
                                                : e == -2
                                                    ? "بدروم2"
                                                    : e == -3
                                                        ? "بدروم3"
                                                        : "$e",
                                        style: style15semibold,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اجمالي رسوم الأدوار العليا",
                      style: style15semibold,
                    ),
                    Gap(5),
                    Text(
                      "${cartController.costfloors} ريال",
                      style: style15semibold,
                    )
                  ],
                ),
                // Gap(10),
                // // Gap(10),
                // cartController.haselevater == 1
                //     ? Container()
                //     : ,
                // cartController.haselevater == 1 ? Container() : Gap(10),
                // cartController.haselevater == 1
                //     ? Container()
                //     : ,
                // Visibility(
                //     visible: cartController.toDoor,
                //     child: Row(
                //       children: [
                //         Text(
                //           "الطابق",
                //           style: style12semibold,
                //         ),
                //         Gap(20),
                //         Expanded(
                //             child: DropdownButtonHideUnderline(
                //           child: DropdownButtonFormField(
                //               isDense: true,
                //               icon: Icon(Icons.keyboard_arrow_down_rounded),
                //               decoration: InputDecoration(
                //                   contentPadding: EdgeInsets.all(10),
                //                   isDense: true,
                //                   fillColor: kThirdryColor,
                //                   filled: true,
                //                   border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(5),
                //                     borderSide: BorderSide.none,
                //                   )),
                //               onChanged: (value) {
                //                 cartController.selectedFloor(value!);
                //               },
                //               value: cartController.selectfloor,
                //               items: listfloor
                //                   .map((e) => DropdownMenuItem(
                //                       value: e,
                //                       child: Text(
                //                         "$e",
                //                         style: style15semibold,
                //                       )))
                //                   .toList()),
                //         ))
                //       ],
                //     )),
                Gap(10),

                Divider(
                  color: kBaseThirdyColor,
                ),
                Text(
                  "توقيت التوصيل",
                  style: style15semibold,
                ),
                Gap(10),
                Row(
                  children: [
                    Text(
                      "اختر التوقيت",
                      style: style12semibold,
                    ),
                    Gap(10),
                    Expanded(
                      child: TextInputCustom(
                        controller: cartController.time,
                        icon: GestureDetector(
                          onTap: () =>
                              cartController.SelectAppointment(context),
                          child: Icon(
                            Icons.access_time,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(10),
                Text(
                  "رسوم التوصيل خارج أوقات الدوام",
                  style: style15semibold,
                ),
                Gap(5),
                Text(
                  "سيتم فرض رسوم إضافية لبعض المنتجات عند الطلب خارج أوقات الدوام الرسمي",
                  style: style12semibold.copyWith(fontSize: 13),
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "رسوم التوصيل خارج أوقات الدوام",
                      style: style15semibold,
                    ),
                    Gap(5),
                    Text(
                      "${cartController.fees.outTimeFees} ريال",
                      style: style15semibold,
                    )
                  ],
                ),
                Gap(15),
                Divider(
                  color: kBaseThirdyColor,
                ),
                // Text(
                //   "رسوم التوصيل خارج أوقات الدوام ${cartController.fees.outTimeFees} ريال",
                //   style: style15semibold,
                // ),
                // Gap(5),
                // Text(
                //   "المجموع الكلي مع الرسوم ${cartController.totalcostwithfees} ريال",
                //   style: style15semibold,
                // ),
                Gap(15),

                Row(
                  children: [
                    CheckBoxCustom(
                      check: cartController.isDiscount,
                      onChanged: (value) =>
                          cartController.changeIsDiscount(value!),
                    ),
                    Gap(5),
                    Text(
                      "ادخال رمز ترويجي",
                      style: style15semibold,
                    )
                  ],
                ),
                Gap(10),
                cartController.isDiscount
                    ? TextInputCustom(
                        hint: "الرمز الترويجي",
                      )
                    : Container(),
                Gap(15),
                Divider(
                  color: kBaseThirdyColor,
                ),
                Gap(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اجمالي رسوم خدمة التطبيق",
                          style: style15semibold,
                        ),
                        Text(
                          "6 ريال",
                          style: style15semibold,
                        )
                      ],
                    ),
                    Text(
                      "رسوم الخدمة ريال / منتج",
                      style: style12semibold.copyWith(color: kFourthColor),
                    )
                  ],
                ),
                Gap(15),
                Divider(
                  color: kBaseThirdyColor,
                ),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اجمالي السلة للمنتجات المحددة",
                      style: style15semibold,
                    ),
                    Text(
                      "${cartController.totalcostwithfees}",
                      style: style15semibold,
                    ),
                  ],
                ),
                Gap(40),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // cartController.printInfo();
                          showDialog(
                            barrierDismissible: false,
                            barrierLabel: '',
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setState) => BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(15),
                                              Text(
                                                "* اختر نوع عملية الدفع",
                                                style: style15semibold,
                                              ),
                                              Gap(15),
                                              Row(
                                                children: [
                                                  CheckBoxCustom(
                                                      check:
                                                          cartController.cash,
                                                      onChanged: (value) {
                                                        setState(
                                                          () {
                                                            cartController
                                                                .changePaymentMethod(
                                                                    'cash');
                                                          },
                                                        );
                                                      }),
                                                  Gap(15),
                                                  Text("كاش عند التسليم"),
                                                ],
                                              ),
                                              Gap(8),
                                              Row(
                                                children: [
                                                  CheckBoxCustom(
                                                    check: cartController.pos,
                                                    onChanged: (value) {
                                                      setState(
                                                        () {
                                                          cartController
                                                              .changePaymentMethod(
                                                                  "pos");
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  Gap(15),
                                                  Text(
                                                      "عبر نقاط البيع عند التسليم"),
                                                ],
                                              ),
                                              Gap(8),
                                              homePageController
                                                          .profile
                                                          .walletTrans!
                                                          .balance! <=
                                                      cartController
                                                          .totalcostwithfees
                                                  ? Row(
                                                      children: [
                                                        CheckBoxCustom(
                                                            check: false,
                                                            onChanged: (value) {
                                                              CustomDialog.Dialog(
                                                                  context,
                                                                  title:
                                                                      "يرجى شحن المحفظة");
                                                            }),
                                                        MaxGap(15),
                                                        Text(
                                                          "رصيد المحفظة الكترونية",
                                                          style: TextStyle(
                                                              color:
                                                                  kBaseThirdyColor,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                        ),
                                                        MaxGap(10),
                                                        Container(
                                                          // height: 20,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  kThirdryColor),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            child: Text(
                                                              "${homePageController.profile.walletTrans!.balance} ريال",
                                                              style:
                                                                  style15semibold,
                                                            ),
                                                          ),
                                                        ),
                                                        MaxGap(10),
                                                        Text(
                                                          "لايوجد رصيد كافي",
                                                          style: style12semibold
                                                              .copyWith(
                                                                  color:
                                                                      kFourthColor),
                                                        )
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        CheckBoxCustom(
                                                            check:
                                                                cartController
                                                                    .e_wallet,
                                                            onChanged: (value) {
                                                              setState(
                                                                () {
                                                                  cartController
                                                                      .changePaymentMethod(
                                                                          "wallet");
                                                                },
                                                              );
                                                            }),
                                                        Gap(15),
                                                        Text(
                                                            "رصيد المحفظة الكترونية"),
                                                        Gap(10),
                                                        Container(
                                                          // height: 20,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  kThirdryColor),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            child: Text(
                                                              "${homePageController.profile.walletTrans!.balance} ريال",
                                                              style:
                                                                  style15semibold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              Gap(8),
                                              Row(
                                                children: [
                                                  CheckBoxCustom(
                                                    check:
                                                        cartController.credit,
                                                    onChanged: (value) {
                                                      setState(
                                                        () {
                                                          cartController
                                                              .changePaymentMethod(
                                                                  "credit");
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  Gap(15),
                                                  Text(
                                                      "بطاقة عبر بوابة الدفع الالكتروني"),
                                                ],
                                              ),
                                              Gap(35),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          CustomRoute.RoutePop(
                                                              context);
                                                          cartController
                                                              .getCurrentlocation();
                                                          CustomRoute.RouteTo(
                                                              context,
                                                              Destination());
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kFourthColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Center(
                                                              child: Text(
                                                                "إضافة",
                                                                style: TextStyle(
                                                                    color:
                                                                        kBaseColor,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Gap(60),
                                                    Expanded(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: kThirdryColor,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Center(
                                                            child: Text(
                                                              "إلغاء",
                                                              style: TextStyle(
                                                                  color:
                                                                      kBaseThirdyColor,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
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
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            height: 30,

                            // width: Responsive.getWidth(context) * .8,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    color: kBaseThirdyColor.withAlpha(75),
                                    blurRadius: 7)
                              ],
                              color: Color(0xff445461),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "دفع",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: kBaseColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          CustomRoute.RouteAndRemoveUntilTo(
                              context,
                              ChangeNotifierProvider(
                                create: (context) => HomePageController()
                                  ..getalladdress()
                                  ..GetProfile()
                                  ..GetMyOrders('pending')
                                  ..GetMyCancelOrders()
                                  ..getAllServices(),
                                lazy: true,
                                builder: (context, child) => HomeNavigation(),
                              ));
                          cartController.EmptyCart();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            height: 30,
                            // width: Responsive.getWidth(context) * .8,
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
                                "إلغاء",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: kBaseColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(50)
              ],
            ),
    );
  }
}
