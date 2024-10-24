// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/Profile/Controller/EditProfileController.dart';
import 'package:gas_app/View/Widgets/Drawer/CustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ChangeNotifierProvider<EditProfileController>(
      create: (context) => EditProfileController()..GetProfile(),
      lazy: true,
      child: Scaffold(
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
          title: Text("الملف الشخصي"),
        ),
        body: Center(
          child: SizedBox(
            width: Responsive.getWidth(context) * .9,
            child: Consumer<EditProfileController>(
              builder: (context, controller, child) => ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Gap(20),
                  CircleAvatar(
                    backgroundColor: kBaseColor,
                    foregroundColor: kBaseColor,
                    radius: 90,
                    child: Skeletonizer(
                      enabled: controller.isloadingprofile,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: kPrimaryColor,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignCenter),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/splash.png',
                            placeholderFit: BoxFit.fill,
                            fit: BoxFit.fill,
                            image:
                                "${AppApi.IMAGEURL}${controller.profile.logo}",
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/splash.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: kFourthColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "تعديل لوغو الحساب",
                            style: TextStyle(
                                color: kBaseColor, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("اسم الحساب"),
                      Gap(20),
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.isloadingprofile,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffEBEBEB),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: kBaseThirdyColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Text(
                                "${controller.profile.userName}",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () => controller.Showdialogeditusername(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kSecendryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: kBaseColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("البريد الالكتروني"),
                      Gap(20),
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.isloadingprofile,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffEBEBEB),
                              border: Border.all(
                                color: kBaseThirdyColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Text(
                                "${controller.profile.email}",
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () => controller.Showdialogeditemail(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kSecendryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: kBaseColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("رقم الهاتف"),
                      Gap(20),
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.isloadingprofile,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffEBEBEB),
                              border: Border.all(
                                color: kBaseThirdyColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: AutoSizeText(
                                "${controller.profile.phone}",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () => controller.Showdialogeditphone(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kSecendryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: kBaseColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("كلمة المرور"),
                      Gap(20),
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.isloadingprofile,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffEBEBEB),
                              border: Border.all(
                                color: kBaseThirdyColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Text(
                                "*********",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () => controller.Showdialogeditpassword(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kSecendryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: kBaseColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
