// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/MainCategorey/Controller/MainCategoriesController.dart';
import 'package:gas_app/View/SubCategorey/Widget/CardSubCategories.dart';
import 'package:gas_app/View/ProductPage/Widgets/CustomCartProduct.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> j = GlobalKey<ScaffoldState>();

class MainCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MainCategoriesController>(
        builder: (context, controller, child) => DefaultTabController(
          length: controller.listcategory.length,
          initialIndex: 0,
          child: Scaffold(
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
                          child: TabBar(
                            isScrollable: true,
                            tabs: controller.listcategory
                                .map((e) => Text(e.name!))
                                .toList(),
                          ),
                        ),
                      ))
                ],
              ),
              leading: Container(),
              backgroundColor: Colors.transparent,
            ),
            body: TabBarView(
              physics: BouncingScrollPhysics(),
              children: controller.listcategory
                  .map((e) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: e.listsubcategory!.isEmpty ? 2 : 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(25),
                        shrinkWrap: true,
                        itemCount: e.listsubcategory!.isEmpty
                            ? e.listproduct!.length
                            : e.listsubcategory!.length,
                        itemBuilder: (context, index) =>
                            e.listsubcategory!.isEmpty
                                ? CustomCartProduct(
                                    product: e.listproduct![index],
                                  )
                                : CardSubCategories(
                                    subCategory: e.listsubcategory![index],
                                  ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
