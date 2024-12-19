// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Model/Country.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/Auth/Signup/Controller/SignupController.dart';
import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Constant/styles.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AuthAppBarCustom(context, false),
        body: Center(
          child: SizedBox(
            width: Responsive.getWidth(context) * .9,
            child: Consumer<SignupController>(
              builder: (context, controller, child) => ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Gap(47),
                  Text(
                    "اسم الحساب",
                    style: style15semibold,
                  ),
                  Gap(10),
                  TextInputCustom(
                      validator: (p0) {
                        if (p0!.length < 6) {
                          return 'لايقل عن 6 أحرف';
                        }
                        return null;
                      },
                      // helptext: "لا يقل عن 6 أحرف",
                      controller: controller.usernamecontroller,
                      type: TextInputType.name,
                      icon: Icon(
                        CupertinoIcons.profile_circled,
                        color: kPrimaryColor,
                        size: 20,
                      )),
                  Gap(10),
                  Text(
                    "الايميل",
                    style: style15semibold,
                  ),
                  Gap(10),
                  TextInputCustom(
                      validator: (p0) {
                        if (!RegExp(
                                r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])')
                            .hasMatch(p0!)) {
                          return "يرجى إدخال بريد الكتروني صالح";
                        }
                        return null;
                      },
                      controller: controller.emailcontroller,
                      type: TextInputType.emailAddress,
                      icon: Icon(
                        CupertinoIcons.mail_solid,
                        color: kPrimaryColor,
                        size: 20,
                      )),
                  Gap(10),
                  Text(
                    "اختر البلد",
                    style: style15semibold,
                  ),
                  Gap(10),

                  Skeletonizer(
                    enableSwitchAnimation: true,
                    enabled: controller.isloadingcountry,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<Country>(
                        isDense: true,
                        hint: Text(
                          "اختر البلد",
                          style: style12semibold,
                        ),
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
                        value: controller.state,
                        onChanged: (Country? date) {
                          controller.state = date;
                          controller.notifyListeners();
                        },
                        items: controller.countries.map((Country state) {
                          return DropdownMenuItem<Country>(
                            value: state,
                            child: Text(
                              state.name!,
                              style: style15semibold,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Gap(10),
                  Text(
                    "رقم الهاتف",
                    style: style15semibold,
                  ),
                  Gap(10),

                  TextInputCustom(
                      validator: (p0) {
                        if (!RegExp(r'^5[0-9]{8}$').hasMatch(p0!)) {
                          return 'يرجى إدخال رقم صالح';
                        }
                        return null;
                      },
                      controller: controller.phonecontroller,
                      type: TextInputType.phone,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.phone_fill,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                            Gap(5),
                            controller.state!.name == 'الامارات العربية المتحدة'
                                ? Text(
                                    "+971",
                                    textDirection: TextDirection.ltr,
                                  )
                                : Text(
                                    "+966",
                                    textDirection: TextDirection.ltr,
                                  ),
                          ],
                        ),
                      )),
                  Gap(10),
                  Text(
                    "كلمة السر",
                    style: style15semibold,
                  ),
                  Gap(10),
                  TextInputCustom(
                      validator: (p0) {
                        if (!RegExp(r'^[A-Za-z0-9@#$%^&*!]{6,}$')
                            .hasMatch(p0!)) {
                          return "لا يقل عن 6 أحرف وباللغة الانكليزية";
                        }
                        return null;
                      },
                      // helptext: "لا يقل عن 6 أحرف وباللغة الانكليزية",
                      controller: controller.passwordcontroller,
                      ispassword: true,
                      type: TextInputType.text,
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                        size: 20,
                      )),
                  Gap(10),
                  Text(
                    "تأكيد كلمة السر",
                    style: style15semibold,
                  ),
                  Gap(10),
                  TextInputCustom(
                      validator: (p0) {
                        if (p0 != controller.passwordcontroller.text) {
                          return "كلمتا المرور غير متطابقتين";
                        }
                        return null;
                      },
                      // helptext: "لا يقل عن 6 أحرف وباللغة الانكليزية",
                      controller: controller.confirmpasswordcontroller,
                      ispassword: true,
                      type: TextInputType.text,
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                        size: 20,
                      )),
                  Gap(10),
                  Text(
                    "رمز الدعوة",
                    style: style15semibold,
                  ),
                  Gap(10),
                  TextInputCustom(
                      controller: controller.invitecode_controller,
                      type: TextInputType.text,
                      icon: Icon(
                        Icons.text_fields,
                        color: kPrimaryColor,
                        size: 20,
                      )),
                  // Gap(10),
                  // Text(
                  //   "اسم البنك",
                  //   style: style15semibold,
                  // ),
                  // Gap(10),
                  // TextInputCustom(
                  //     controller: controller.banknamecontroller,
                  //     type: TextInputType.text,
                  //     icon: Icon(
                  //       Icons.account_balance_wallet_rounded,
                  //       color: kPrimaryColor,
                  //       size: 20,
                  //     )),
                  Gap(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "لوغو الحساب",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(70),
                      GestureDetector(
                        onTap: () => controller.SelectImage(context),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: kSecendryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.add,
                            color: kBaseColor,
                          ),
                        ),
                      ),
                      MaxGap(40),
                      controller.logo == null
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      controller.logo!,
                                      fit: BoxFit.fill,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: GestureDetector(
                                      onTap: () => controller.removelogo(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: kSecendryColor,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: kBaseColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                  Gap(43),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "لديك حساب بالفعل؟",
                        style: style15semibold,
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () => controller.toLoginPage(context),
                        child: Text(
                          "تسجيل دخول",
                          style: TextStyle(
                              fontSize: 15,
                              color: kFourthColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  Gap(120),
                  GestureDetector(
                    onTap: () async {
                      EasyLoading.show();

                      var result = await controller.Signup(context);
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
                          "انشاء حساب",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kBaseColor,
                          ),
                        )),
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
    );
  }
}
