// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/Lists.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Model/SubSupplier.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Cart/CartForm.dart';
import 'package:gas_app/View/MainCategorey/Controller/MainCategoriesController.dart';
import 'package:gas_app/View/MainCategorey/MainCategoriesPage.dart';
import 'package:gas_app/View/MainCategorey/MainCategoriesPharmacy.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

class CardSubSupplier extends StatelessWidget {
  CardSubSupplier({this.subSupplier, this.index});
  SubSupplier? subSupplier;
  int? index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        cartController.selectSupplier(subSupplier!);

        if (subSupplier!.serviceId == 2) {
          CustomRoute.RouteTo(
            context,
            ChangeNotifierProvider<MainCategoriesController>(
              create: (context) => MainCategoriesController()
                ..GetMainCategory(subSupplier!.supplierId!),
              builder: (context, child) => CartForm(
                  widget: MainCategoriesPharmacy(
                subSupplier: subSupplier,
              )),
            ),
          );
        } else {
          CustomRoute.RouteTo(
            context,
            ChangeNotifierProvider<MainCategoriesController>(
              create: (context) => MainCategoriesController()
                ..GetMainCategory(subSupplier!.supplierId!),
              builder: (context, child) =>
                  CartForm(widget: MainCategoriesPage()),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: kBaseThirdyColor.withAlpha(50),
                blurRadius: 10)
          ],
          color: index! % 4 == 0
              ? kSecendryColor
              : (index! % 4 == 1 || index! % 4 == 2
                  ? kThirdryColor
                  : kSecendryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              foregroundColor: kFourthColor,
              backgroundColor: kBaseColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(listsvg[subSupplier!.serviceId! - 1],
                    // 'assets/svg/gas.svg',,
                    color: kSecendryColor),
              ),
            ),
            MaxGap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 11,
                    maxFontSize: 15,
                    subSupplier!.supplierName!,
                    style: style15semibold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
