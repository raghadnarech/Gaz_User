// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/View/ProductPage/Widgets/CustomCartProductGaz.dart';
import 'package:gas_app/View/SelectSubSupplier/Controller/SelectSubSupplierController.dart';
import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductsPageGaz extends StatelessWidget {
  ProductsPageGaz({this.name, this.code});
  // List<Product>? listproduct;
  String? name;
  String? code;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<SelectSubSupplierController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBarCustom(context, '$name'),
        body: controller.isloadinggetproductgaz
            ? GridView.builder(
                padding: EdgeInsets.all(25),
                itemCount: 6,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 35,
                    mainAxisSpacing: 40),
                itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: Color.fromARGB(255, 229, 229, 229).withAlpha(150),
                  highlightColor: kBaseColor.withAlpha(100),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kBaseColor,
                    ),
                    width: double.infinity,
                    child: Text(''),
                  ),
                ),
              )
            : GridView.builder(
                padding: EdgeInsets.all(25),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 35,
                    mainAxisSpacing: 40),
                itemCount: controller.productList.length,
                itemBuilder: (context, index) => CustomCartProductGaz(
                  product: controller.productList[index],
                  code: code,
                ),
              ),
      ),
    ));
  }
}
