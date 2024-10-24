// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Controller/CartController.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Cart/CartPage.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

class CartForm extends StatelessWidget {
  CartForm({required this.widget});
  Widget widget;
  @override
  Widget build(BuildContext context) {
    cartController = Provider.of<CartController>(context);
    return Scaffold(
      bottomNavigationBar: cartController.cart.listcartproduct.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: kBaseThirdyColor.withAlpha(100),
                      blurRadius: 7)
                ],
                color: kBaseColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "اجمالي قيمة المنتجات:",
                              style: style15semibold,
                            ),
                            Gap(5),
                            Text("${cartController.cart.getTotalPrice()} ريال"),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              CustomRoute.RouteTo(context, CartPage());
                            },
                            child: Text("السلة"))
                      ],
                    ),
                  )
                ],
              ),
            )
          : null,
      body: widget,
    );
  }
}
