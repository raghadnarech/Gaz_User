// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/ServicesProvider.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Address/Controller/AllAddressController.dart';
import 'package:gas_app/View/Address/View/AllAddress.dart';
import 'package:gas_app/View/BankAccount/BankAccount.dart';
import 'package:gas_app/View/BankAccount/Controller/BankAccountContrller.dart';
import 'package:gas_app/View/ContactUs/ContactUs.dart';
import 'package:gas_app/View/ContactUs/Controller/ContactUsController.dart';
import 'package:gas_app/View/CustomizChoice/Controller/CustomizChoiceController.dart';
import 'package:gas_app/View/CustomizChoice/CustomizChoise.dart';
import 'package:gas_app/View/GetInfo/AboutUs.dart';
import 'package:gas_app/View/GetInfo/Controller/GetInfoController.dart';
import 'package:gas_app/View/GetInfo/PrivacyPolicy.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Point/PointPage.dart';
import 'package:gas_app/View/Wallet/Wallet.dart';
// import 'package:gas_app/View/Noificition/Controller/NotificationController.dart';
// import 'package:gas_app/View/Noificition/Notification.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    homePageController = Provider.of<HomePageController>(context);
    return Drawer(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                Color(0xff1B2A36),
                Color(0xff35536B),
              ])),
          child: ListView(
            children: [
              Gap(10),
              CircleAvatar(
                backgroundColor: kBaseColor,
                foregroundColor: kBaseColor,
                radius: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/splash.png",
                      image:
                          "${AppApi.IMAGEURL}${homePageController.profile.logo}"),
                ),
              ),
              Gap(10),
              Center(
                  child: Text(
                "${homePageController.profile.userName}",
                style: TextStyle(
                    color: kBaseColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )),
              // Gap(20),
              // CustomSectionDrawer(
              //     assetsvg: 'assets/svg/orderDrawer.svg', titile: "الطلبات"),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/wallet.svg',
                titile: "المحفظة",
                nextpage: Wallet(),
              ),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/wallet.svg',
                titile: "بياناتي المصرفية",
                nextpage: ChangeNotifierProvider<BankAccountContrller>(
                  create: (context) => BankAccountContrller()
                    ..GetBanks(context)
                    ..GetCardBanks(context),
                  lazy: true,
                  builder: (context, child) => BankAccount(),
                  child: BankAccount(),
                ),
              ),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/man_address.svg',
                titile: "إدارة العناوين",
                nextpage: ChangeNotifierProvider<AllAddressController>(
                  create: (context) =>
                      AllAddressController()..getalladdress(context),
                  lazy: true,
                  builder: (context, child) => AllAddress(),
                ),
              ),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/choice.svg',
                titile: "تخصيص الخيارات",
                nextpage: ChangeNotifierProvider<CustomizChoiceController>(
                  create: (context) => CustomizChoiceController()
                    ..GetGasServiceSuppliers(context),
                  builder: (context, child) => CustomizChoise(),
                  child: CustomizChoise(),
                ),
              ),
              // Gap(20),
              // CustomSectionDrawer(
              //     assetsvg: 'assets/svg/profile.svg', titile: "الصفحة الشخصية"),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/noti.svg',
                titile: "نقاطي",
                nextpage: PointPage(),
              ),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/about_us.svg',
                titile: "من نحن",
                nextpage: ChangeNotifierProvider<GetInfoController>(
                  create: (context) => GetInfoController()..GetInfo(context),
                  builder: (context, child) => AboutUs(),
                ),
              ),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/priv_poli.svg',
                titile: "سياسة الخصوصية",
                nextpage: ChangeNotifierProvider(
                  create: (context) => GetInfoController()..GetInfo(context),
                  builder: (context, child) => PrivacyPolicy(),
                ),
              ),
              Gap(20),
              CustomSectionDrawer(
                assetsvg: 'assets/svg/contact_us.svg',
                titile: "تواصل معنا",
                nextpage: ChangeNotifierProvider<ContactUsController>(
                  create: (context) => ContactUsController(),
                  builder: (context, child) => ContactUs(),
                ),
              ),
              Gap(20),
              GestureDetector(
                onTap: () => ServicesProvider.logout(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kBaseColor,
                        // foregroundColor: kPrimaryColor,
                        radius: 30,
                        child: SvgPicture.asset(
                          'assets/svg/logout.svg',
                          width: 35,
                        ),
                      ),
                      Gap(10),
                      Text("تسجيل الخروج",
                          style: TextStyle(
                              color: kBaseColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                ),
              ),
              Gap(10)
            ],
          )),
    );
  }
}

class CustomSectionDrawer extends StatelessWidget {
  CustomSectionDrawer({this.assetsvg, this.nextpage, this.titile});
  String? titile;
  String? assetsvg;
  Widget? nextpage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomRoute.RouteTo(context, nextpage!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kBaseColor,
              radius: 30,
              child: SvgPicture.asset(
                assetsvg!,
                width: 35,
              ),
            ),
            Gap(10),
            Text(titile!,
                style: TextStyle(
                    color: kBaseColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
