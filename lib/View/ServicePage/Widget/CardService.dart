// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/Lists.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Controller/CartController.dart';
import 'package:gas_app/Model/Service.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Cart/CartForm.dart';
import 'package:gas_app/View/ProductPage/ProductsPageGaz.dart';
import 'package:gas_app/View/SelectSubSupplier/Controller/SelectSubSupplierController.dart';
import 'package:gas_app/View/SelectSubSupplier/View/SelectSubSupplierAll.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

class CardService extends StatelessWidget {
  CardService({this.services, this.index});
  Services? services;
  int? index;
  @override
  Widget build(BuildContext context) {
    cartController = Provider.of<CartController>(context);
    return GestureDetector(
      onTap: () async {
        if (services!.id == 1) {
          await cartController.selectServices(services!);

          CustomRoute.RouteTo(
            context,
            ChangeNotifierProvider<SelectSubSupplierController>(
              create: (context) => SelectSubSupplierController()
                ..GetProductGaz(context, 'nearest_man', 1),
              child: CartForm(
                  widget: ProductsPageGaz(
                name: services!.name!,
              )),
            ),
          );
        } else {
          await cartController.selectServices(services!);

          // await SelectSubSupplierController()
          //   ..getallSubSuupplier(context, services!.id!);
          cartController.selectServices(services!);
          CustomRoute.RouteTo(
            context,
            ChangeNotifierProvider<SelectSubSupplierController>(
              create: (context) => SelectSubSupplierController()
                ..GetAllServiceSuppliers(context, services!.id!),
              builder: (context, child) =>
                  CartForm(widget: SelectSubSupplierAll()),
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
                child: SvgPicture.asset(
                  listsvg[index!],
                  color: kSecendryColor,
                ),
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
                    services!.name!,
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
