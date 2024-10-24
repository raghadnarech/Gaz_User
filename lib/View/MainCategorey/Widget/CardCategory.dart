// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Model/Category.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/SubCategorey/SubCategoreyPage.dart';

class CardCategory extends StatelessWidget {
  CardCategory({this.color, required this.category});
  Color? color;
  Category? category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomRoute.RouteTo(
            context,
            SubCategoreyPage(
              category: category,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
            ),
            Gap(10),
            Text(
              category!.name!,
              style: style12semibold,
            ),
          ],
        ),
      ),
    );
  }
}
