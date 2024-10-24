// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gas_app/Model/SubCategory.dart';
import 'package:gas_app/View/MainCategorey/Controller/MainCategoriesController.dart';
import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
import 'package:gas_app/View/ProductPage/Widgets/CustomCartProduct.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({this.subCategory});
  SubCategory? subCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBarCustom(context, '${subCategory!.name}'),
      body: Consumer<MainCategoriesController>(
        builder: (context, controller, child) => GridView.builder(
          padding: EdgeInsets.all(25),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 35, mainAxisSpacing: 40),
          itemCount: subCategory!.listproduct.length,
          itemBuilder: (context, index) => CustomCartProduct(
            product: subCategory!.listproduct[index],
          ),
        ),
      ),
    ));
  }
}
