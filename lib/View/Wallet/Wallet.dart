// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // GestureDetector(
          //   onTap: () => scaffoldKey.currentState?.openEndDrawer(),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SvgPicture.asset(
          //       'assets/svg/menu.svg',
          //       width: 30,
          //       height: 25,
          //     ),
          //   ),
          // ),
        ],
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text("المحفظة"),
      ),
      body: Consumer<HomePageController>(
        builder: (context, controller, child) => ListView(
          padding: EdgeInsets.all(8),
          children: [
            // Gap(20),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text(
            //       "الحساب البنكي",
            //       style: style15semibold,
            //     ),
            //     Gap(20),
            //     Text(
            //       controller.profile.bankNum == null
            //           ? ''
            //           : controller.profile.bankNum!,
            //       style: style15semibold,
            //     ),
            //   ],
            // ),
            Gap(20),
            Text(
              "المحفظة الخاصة بك",
              style: TextStyle(
                  color: kFourthColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "الرصيد المتوافر",
                  style: style15semibold,
                ),
                Gap(20),
                Text(
                  "${controller.profile.walletTrans!.balance}",
                  style: style15semibold,
                ),
              ],
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                  child: ButtonAddTransaction(
                    controller: controller,
                  ),
                ),
                Gap(10),
                Expanded(
                  child: ButtonWithdrowTransaction(
                    controller: controller,
                  ),
                ),
              ],
            ),
            Gap(20),
            Text(
              "عمليات الإيداع على المحفظة",
              style: TextStyle(
                  color: kFourthColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Gap(10),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.profile.walletTrans!.transaction!
                  .where((element) => element.status == 'add')
                  .length,
              itemBuilder: (context, index) {
                final filteredTransactions = controller
                    .profile.walletTrans!.transaction!
                    .where((element) => element.status == 'add')
                    .toList();
                final transaction = filteredTransactions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kBaseThirdyColor.withAlpha(50),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                      color: kThirdryColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: kPrimaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "رقم الطلب",
                                    style: style15semibold,
                                  ),
                                  Gap(5),
                                  Text(
                                    "${transaction.number}",
                                    style: style15semibold,
                                  ),
                                ],
                              ),
                              Text(
                                "${DateFormat('yyyy-MM-dd').format(DateTime.parse(transaction.createdAt.toString()))}",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "المبلغ",
                                    style: style15semibold,
                                  ),
                                  Gap(15),
                                  Text(
                                    "${transaction.amount} ريال",
                                    style: style15semibold,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "رقم الحساب",
                                    style: style15semibold,
                                  ),
                                  Gap(10),
                                  Text(
                                    "${transaction.walletId}",
                                    style: style15semibold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(
              "عمليات السحب الخاصة بك",
              style: TextStyle(
                  color: kFourthColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.profile.walletTrans!.transaction!
                  .where((element) => element.status == 'withdraw')
                  .length,
              itemBuilder: (context, index) {
                final filteredTransactions = controller
                    .profile.walletTrans!.transaction!
                    .where((element) => element.status == 'withdraw')
                    .toList();
                final transaction = filteredTransactions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kBaseThirdyColor.withAlpha(50),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                      color: kThirdryColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: kPrimaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "رقم الطلب",
                                    style: style15semibold,
                                  ),
                                  Gap(5),
                                  Text(
                                    "${transaction.number}",
                                    style: style15semibold,
                                  ),
                                ],
                              ),
                              Text(
                                "${DateFormat('yyyy-MM-dd').format(DateTime.parse(transaction.createdAt.toString()))}",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "المبلغ",
                                    style: style15semibold,
                                  ),
                                  Gap(15),
                                  Text(
                                    "${transaction.amount} ريال",
                                    style: style15semibold,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "رقم الحساب",
                                    style: style15semibold,
                                  ),
                                  Gap(10),
                                  Text(
                                    "${transaction.walletId}",
                                    style: style15semibold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // Gap(50),

            // Gap(30),
          ],
        ),
      ),
    );
  }
}

class ButtonWithdrowTransaction extends StatelessWidget {
  ButtonWithdrowTransaction({required this.controller});
  HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                            controller.anotherbank = false;
                            controller.mybank = false;
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
                            Gap(20),
                            Row(
                              children: [
                                Text(
                                  "الرصيد المتاح",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Gap(10),
                                Text(
                                  "${controller.profile.walletTrans!.balance} ريال",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Gap(10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "الرصيد المراد سحبه",
                                  style: style12semibold,
                                ),
                                Gap(20),
                                Expanded(
                                    child: TextInputCustom(
                                  controller: controller.amountcontroller,
                                  hint: '',
                                  ispassword: false,
                                ))
                              ],
                            ),
                            Gap(20),
                            Row(
                              children: [
                                CheckBoxCustom(
                                  color: kFourthColor,
                                  check: controller.mybank,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        controller.mybank = value!;
                                        controller.anotherbank = false;
                                      },
                                    );
                                  },
                                ),
                                Gap(15),
                                Text(
                                  "الحساب البنكي الخاصي بي",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Gap(10),
                            Row(
                              children: [
                                CheckBoxCustom(
                                  color: kFourthColor,
                                  check: controller.anotherbank,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        controller.anotherbank = value!;
                                        controller.mybank = false;
                                      },
                                    );
                                  },
                                ),
                                Gap(15),
                                Text(
                                  "حساب بنكي اخر",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Gap(10),
                            Visibility(
                              visible: controller.anotherbank,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "رقم الحساب البنكي",
                                    style: style12semibold,
                                  ),
                                  Gap(20),
                                  Expanded(
                                      child: TextInputCustom(
                                    controller: controller.otherbank,
                                    hint: '',
                                    ispassword: false,
                                  ))
                                ],
                              ),
                            ),
                            Gap(35),
                            GestureDetector(
                              onTap: () {
                                controller.WithdrawTransaction(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topRight,
                                          colors: [
                                            Color(0xff722B23),
                                            Color(0xffE45545),
                                          ])),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Center(
                                        child: Text(
                                      "متابعة",
                                      style: TextStyle(
                                          color: kBaseColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
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
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff722B23),
                    Color(0xffE45545),
                  ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Center(
                child: Text(
              "طلب سحب رصيد",
              style: TextStyle(
                  color: kBaseColor, fontSize: 15, fontWeight: FontWeight.w600),
            )),
          ),
        ),
      ),
    );
  }
}

class ButtonAddTransaction extends StatelessWidget {
  ButtonAddTransaction({
    required this.controller,
  });
  HomePageController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            barrierDismissible: false,
            barrierLabel: '',
            context: context,
            barrierColor: Colors.transparent,
            builder: (context) => PopScope(
              canPop: false,
              child: StatefulBuilder(
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
                                controller.changeaddtrasaction('100');
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
                                  "طلب إيداع رصيد",
                                  style: TextStyle(
                                      color: kFourthColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Gap(20),
                                Text(
                                  "حدد فئة الشحن",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    CheckBoxCustom(
                                      color: kPrimaryColor,
                                      check: controller.amountcontroller.text ==
                                          '100',
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            controller
                                                .changeaddtrasaction('100');
                                          },
                                        );
                                      },
                                    ),
                                    Gap(15),
                                    Text(
                                      "شحن المحفظة بمبلغ قدره 100 ريال",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    CheckBoxCustom(
                                      color: kPrimaryColor,
                                      check: controller.amountcontroller.text ==
                                          '300',
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            controller
                                                .changeaddtrasaction('300');
                                          },
                                        );
                                      },
                                    ),
                                    Gap(15),
                                    Text(
                                      "شحن المحفظة بمبلغ قدره 300 ريال",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    CheckBoxCustom(
                                      color: kPrimaryColor,
                                      check: controller.amountcontroller.text ==
                                          '500',
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            controller
                                                .changeaddtrasaction('500');
                                          },
                                        );
                                      },
                                    ),
                                    Gap(15),
                                    Text(
                                      "شحن المحفظة بمبلغ قدره 500 ريال",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    CheckBoxCustom(
                                      color: kPrimaryColor,
                                      check: controller.amountcontroller.text ==
                                          '+500',
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            controller
                                                .changeaddtrasaction('+500');
                                          },
                                        );
                                      },
                                    ),
                                    Gap(15),
                                    Text(
                                      "شحن المحفظة بمبلغ قدره 500+ ريال",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Visibility(
                                  visible: controller.amountcontroller.text ==
                                      '+500',
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "المبلغ المراد شحنه",
                                        style: style12semibold,
                                      ),
                                      Gap(20),
                                      Expanded(
                                          child: TextInputCustom(
                                        hint: '',
                                        controller:
                                            controller.plus500controller,
                                        ispassword: false,
                                      ))
                                    ],
                                  ),
                                ),
                                Gap(35),
                                GestureDetector(
                                  onTap: () {
                                    CustomRoute.RoutePop(context);
                                    showDialog(
                                      barrierDismissible: false,
                                      barrierLabel: '',
                                      context: context,
                                      barrierColor: Colors.transparent,
                                      builder: (context) => PopScope(
                                        canPop: false,
                                        child: StatefulBuilder(
                                          builder: (context, setState) =>
                                              BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: Dialog(
                                              insetPadding: EdgeInsets.all(15),
                                              elevation: 10,
                                              alignment: Alignment(0, -.4),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          CustomRoute.RoutePop(
                                                              context);
                                                          controller
                                                              .removeimagenotif();
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          color:
                                                              kBaseThirdyColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "ارفاق صورة الإشعار",
                                                            style: TextStyle(
                                                                color:
                                                                    kFourthColor,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Gap(10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "يرجى إرفاق صورة اشعار التحويل",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Gap(20),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller.pickimage(
                                                                      ImageSource
                                                                          .gallery,
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        kSecendryColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "تحميل الصورة",
                                                                      style:
                                                                          style15semiboldwhite,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Gap(20),
                                                          ValueListenableBuilder<
                                                              File?>(
                                                            valueListenable:
                                                                controller
                                                                    .imagenotif,
                                                            builder: (context,
                                                                image, child) {
                                                              return image ==
                                                                      null
                                                                  ? Container()
                                                                  : Image.file(
                                                                      image,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    );
                                                            },
                                                          ),
                                                          GestureDetector(
                                                            onTap: () => controller
                                                                .AddTransaction(
                                                              context,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        gradient: LinearGradient(
                                                                            begin:
                                                                                Alignment.bottomCenter,
                                                                            end: Alignment.topRight,
                                                                            colors: [
                                                                              Color(0xff722B23),
                                                                              Color(0xffE45545),
                                                                            ])),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "متابعة",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kBaseColor,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )),
                                                                ),
                                                              ),
                                                            ),
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
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topRight,
                                              colors: [
                                                Color(0xff722B23),
                                                Color(0xffE45545),
                                              ])),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Center(
                                            child: Text(
                                          "متابعة",
                                          style: TextStyle(
                                              color: kBaseColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )),
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
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff1B2A36),
                    Color(0xff35536B),
                  ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Center(
                child: Text(
              "طلب إيداع رصيد",
              style: TextStyle(
                  color: kBaseColor, fontSize: 15, fontWeight: FontWeight.w600),
            )),
          ),
        ),
      ),
    );
  }
}
