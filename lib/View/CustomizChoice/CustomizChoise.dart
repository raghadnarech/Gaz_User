// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/CustomizChoice/Controller/CustomizChoiceController.dart';
import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

class CustomizChoise extends StatefulWidget {
  @override
  State<CustomizChoise> createState() => _CustomizChoiseState();
}

class _CustomizChoiseState extends State<CustomizChoise> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text("تخصيص الاختيارات"),
      ),
      body: Center(
          child: SizedBox(
        width: Responsive.getWidth(context) * .9,
        child: Consumer<CustomizChoiceController>(
          builder: (context, controller, child) => ListView(
            children: [
              Gap(30),
              Row(
                children: [
                  CheckBoxCustom(
                    check: controller.nearestrepresentative,
                    onChanged: (value) {
                      setState(() {
                        controller.nearestrepresentative = value!;
                        controller.selectedrepresentative = false;
                        controller.representativefromlist = false;
                        controller.codemandob.clear();
                      });
                    },
                  ),
                  Gap(15),
                  Text(
                    "اختيار اقرب مندوب معين ضمن المنطقة",
                    style: style15semibold,
                  )
                ],
              ),
              Gap(20),
              Row(
                children: [
                  CheckBoxCustom(
                    check: controller.selectedrepresentative,
                    onChanged: (value) {
                      setState(() {
                        controller.selectedrepresentative = value!;
                        controller.nearestrepresentative = false;
                        controller.representativefromlist = false;
                      });
                    },
                  ),
                  Gap(15),
                  Text(
                    "ارسال الطلب الى مندوب معين",
                    style: style15semibold,
                  )
                ],
              ),
              Gap(20),
              Visibility(
                visible: controller.selectedrepresentative,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "كود المندوب",
                          style: style12semibold,
                        ),
                        Gap(20),
                        Expanded(
                          child: TextInputCustom(
                            controller: controller.codemandob,
                          ),
                        ),
                      ],
                    ),
                    Gap(25),
                  ],
                ),
              ),
              Row(
                children: [
                  CheckBoxCustom(
                    check: controller.representativefromlist,
                    onChanged: (value) {
                      setState(() {
                        controller.representativefromlist = value!;
                        controller.nearestrepresentative = false;
                        controller.selectedrepresentative = false;
                        controller.codemandob.clear();
                      });
                    },
                  ),
                  Gap(15),
                  Text(
                    "اختيار مورد معين ضمن المنطقة",
                    style: style15semibold,
                  )
                ],
              ),
              Gap(20),
              Visibility(
                  visible: controller.representativefromlist,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "اختر مورد معين",
                            style: style12semibold,
                          ),
                          Gap(20),
                          Expanded(
                              child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              isDense: true,
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                                fillColor: kThirdryColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                cartController.selectSupplier(value!);
                                setState(
                                  () {
                                    controller.supplierid = value.id;
                                  },
                                );
                              },
                              items: controller.SupplierList.map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    "${e.supplierName}",
                                    style: style15semibold,
                                  ),
                                ),
                              ).toList(),
                            ),
                          ))
                        ],
                      ),
                      Gap(25),
                    ],
                  )),
              Gap(170),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show();
                  try {
                    var result = await controller.UpdateCustomChoice(
                      context,
                    );
                    result.fold(
                      (l) {
                        EasyLoading.showError(l.message);
                        EasyLoading.dismiss();
                      },
                      (r) {
                        EasyLoading.dismiss();
                      },
                    );
                  } catch (e) {
                    EasyLoading.showToast(e.toString());
                    EasyLoading.dismiss();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 43,
                    width: Responsive.getWidth(context) * .8,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            color: kBaseThirdyColor.withAlpha(75),
                            blurRadius: 7)
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff445461),
                    ),
                    child: Center(
                      child: Text(
                        "حفظ",
                        style: TextStyle(
                            fontSize: 15,
                            color: kBaseColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    ));
  }
}
