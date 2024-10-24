// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/SelectSubSupplier/Controller/SelectSubSupplierController.dart';
import 'package:gas_app/View/SelectSubSupplier/Widget/CardSubSupplier.dart';
import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SelectSubSupplierAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBarCustom(context, 'اختر المورد الفرعي'),
      body: Center(
          child: SizedBox(
        width: Responsive.getWidth(context) * .8,
        child: Consumer<SelectSubSupplierController>(
          builder: (context, controller, child) => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Gap(60),
              controller.isloadinggetallservicessupplier
                  ? GridView.builder(
                      itemCount: 6,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 45,
                        crossAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor:
                            Color.fromARGB(255, 229, 229, 229).withAlpha(150),
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
                  : controller.SupplierList.isEmpty
                      ? Center(child: Text("لايوجد موردين لهذه الخدمة بعد"))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 45,
                            crossAxisSpacing: 30,
                          ),
                          itemCount: controller.SupplierList.length,
                          itemBuilder: (context, index) => CardSubSupplier(
                            index: index,
                            subSupplier: controller.SupplierList[index],
                          ),
                        )
            ],
          ),
        ),
      )),
    ));
  }
}
