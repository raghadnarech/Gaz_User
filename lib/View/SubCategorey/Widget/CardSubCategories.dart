// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Cart/CartForm.dart';
import 'package:gas_app/View/ProductPage/ProductsPage.dart';
import 'package:gas_app/View/MainCategorey/Controller/MainCategoriesController.dart';
import 'package:provider/provider.dart';

class CardSubCategories extends StatelessWidget {
  CardSubCategories({Key? key, this.subCategory});

  var subCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomRoute.RouteTo(
            context,
            ChangeNotifierProvider(
              create: (context) => MainCategoriesController(),
              child: CartForm(
                widget: ProductsPage(
                  subCategory: subCategory,
                ),
              ),
            ));
      },
      child: Container(
        // height: Responsive.getHeight(context) * 0.14,
        // width: Responsive.getWidth(context) * 0.29,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
          color: kFourthColor.withAlpha(150),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(27),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 27,
                  child: FadeInImage.assetNetwork(
                    placeholder: "",
                    image: '${AppApi.IMAGEURL}${subCategory!.image}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Gap(10),
              Text(
                subCategory!.name!,
                style: style12semibold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
