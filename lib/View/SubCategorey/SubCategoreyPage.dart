// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, unused_element

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Model/Category.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/SubCategorey/Widget/CardSubCategories.dart';
import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class SubCategoreyPage extends StatelessWidget {
  SubCategoreyPage({this.category});
  Category? category;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBarCustom(context, '${category!.name}'),
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Gap(30),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: .8,
                crossAxisSpacing: 20,
              ),
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(25),
              shrinkWrap: true,
              itemCount: category!.listsubcategory!.length,
              itemBuilder: (context, index) => CardSubCategories(
                subCategory: category!.listsubcategory![index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDialogaccept(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                title: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "هل انت متأكد من حذف التصنيف الفرعي مع العلم انه سيتم حذف جميع التصنيفات الفرعية ؟",
                      style: TextStyle(color: kFourthColor, fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "نعم ",
                            style: TextStyle(
                                color: kFourthColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                      Gap(10),
                      TextButton(
                          onPressed: () {
                            CustomRoute.RoutePop(context);
                          },
                          child: Text(
                            "لا ",
                            style: style12semibold,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
