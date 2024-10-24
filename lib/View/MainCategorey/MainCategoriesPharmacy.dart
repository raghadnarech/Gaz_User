// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Model/SubSupplier.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Cart/CartForm.dart';
import 'package:gas_app/View/MainCategorey/Controller/MainCategoriesController.dart';
import 'package:gas_app/View/MainCategorey/MainCategoriesPage.dart';
import 'package:gas_app/View/Ticket/Controller/TicketController.dart';
import 'package:gas_app/View/Ticket/TicketPage.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> j = GlobalKey<ScaffoldState>();

class MainCategoriesPharmacy extends StatelessWidget {
  MainCategoriesPharmacy({this.subSupplier});
  SubSupplier? subSupplier;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MainCategoriesController>(
        builder: (context, controller, child) => Scaffold(
          key: j,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 190,
            flexibleSpace: Stack(
              children: [
                Positioned(
                    top: 0,
                    width: Responsive.getWidth(context),
                    height: 95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Container(
                        width: Responsive.getWidth(context),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage('assets/images/appbar.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    top: 88,
                    width: Responsive.getWidth(context),
                    // height: 60,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 43,
                        width: Responsive.getWidth(context) * .9,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 7,
                                color: kBaseThirdyColor.withAlpha(150),
                              )
                            ],
                            color: kThirdryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "الأصناف الرئيسية",
                          style: style15semibold,
                        )),
                      ),
                    )),
                Positioned(
                    top: 35,
                    width: Responsive.getWidth(context),
                    // height: 60,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                          onTap: () => CustomRoute.RoutePop(context),
                          child: Icon(
                            Icons.arrow_back,
                            color: kBaseColor,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    top: 140,
                    width: Responsive.getWidth(context),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: kBaseSecandryColor,
                        height: 43,
                        // child: TabBar(
                        //   isScrollable: true,s
                        //   tabs: controller.listcategory
                        //       .map((e) => Text(e.name!))
                        //       .toList(),
                        // ),
                      ),
                    ))
              ],
            ),
            leading: Container(),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () => CustomRoute.RouteReplacementTo(
                        context,
                        ChangeNotifierProvider<TicketController>(
                          create: (context) => TicketController()
                            ..oninit(subSupplier!.id!)
                            ..GetAllTicket(context),
                          builder: (context, child) => TicketPage(
                            title: "تذكرة مع صيدلي",
                          ),
                        ),
                      ),
                  child: OpenTicket()),
              Gap(50),
              GestureDetector(
                  onTap: () => CustomRoute.RouteReplacementTo(
                        context,
                        ChangeNotifierProvider<MainCategoriesController>(
                          create: (context) => MainCategoriesController()
                            ..GetMainCategory(subSupplier!.supplierId!),
                          builder: (context, child) =>
                              CartForm(widget: MainCategoriesPage()),
                        ),
                      ),
                  child: GoToStore()),
            ],
          ),
        ),
      ),
    );
  }
}

class GoToStore extends StatelessWidget {
  const GoToStore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Responsive.getWidth(context) * .8,
          height: Responsive.getHeight(context) * .15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: kFourthColor)),
          child: Stack(
            children: [
              SizedBox(
                width: Responsive.getWidth(context) * .8,
                height: Responsive.getHeight(context) * .15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/backpar.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kBaseColor.withAlpha(230),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "الدخول للمتجر و شراء دواء معين",
                    style: style18semibold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OpenTicket extends StatelessWidget {
  const OpenTicket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Responsive.getWidth(context) * .8,
          height: Responsive.getHeight(context) * .15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: kPrimaryColor)),
          child: Stack(
            children: [
              SizedBox(
                width: Responsive.getWidth(context) * .8,
                height: Responsive.getHeight(context) * .15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/backpar.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kBaseColor.withAlpha(230),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "التواصل مع الصيدلي و فتح تذكرة",
                    style: style18semibold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
