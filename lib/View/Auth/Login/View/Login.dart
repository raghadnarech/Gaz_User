import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/styles.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AuthAppBarCustom(context, true),
        body: Center(
          child: SizedBox(
            width: Responsive.getWidth(context) * .9,
            child: Consumer<LoginController>(
              builder: (context, controller, child) => ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Gap(47),
                  Text(
                    "رقم الهاتف",
                    style: style15semibold,
                  ),
                  Gap(10),
                  TextInputCustom(
                      controller: controller.phonecontroller,
                      type: TextInputType.phone,
                      icon: Icon(
                        CupertinoIcons.phone_fill,
                        color: kPrimaryColor,
                        size: 20,
                      )),
                  Gap(43),
                  Text(
                    "كلمة السر",
                    style: style15semibold,
                  ),
                  Gap(10),
                  TextInputCustom(
                      controller: controller.passwordcontroller,
                      ispassword: true,
                      type: TextInputType.text,
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                        size: 20,
                      )),
                  Gap(43),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ليس لديك حساب؟",
                        style: style15semibold,
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () => controller.toSignUpPage(context),
                        child: Text(
                          "انشاء حساب",
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
                      var result = await controller.Login(context);

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
                          "تسجيل الدخول",
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
