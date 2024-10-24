// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Model/Address.dart';
import 'package:gas_app/Model/Order.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Address/Controller/AddAddressController.dart';
import 'package:gas_app/View/Address/View/AddAddress.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Orders/Controller/EditOrderController.dart';
import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

class EditOrder extends StatelessWidget {
  EditOrder(this.orderes);
  Orderes? orderes;
  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = [];
    if (cartController.fees.startTime != null &&
        cartController.fees.endTime != null) {
      timeSlots = cartController.generateTimeSlots(
        cartController.fees.startTime!,
        cartController.fees.endTime!,
        Duration(minutes: 30),
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text(
          "تعديل محتوى الطلب",
          style: style15semibold,
        ),
      ),
      body: Consumer<HomePageController>(
        builder: (context, homecontroller, child) =>
            Consumer<EditOrderController>(
          builder: (context, controller, child) => ListView(
            padding: EdgeInsets.all(15),
            shrinkWrap: true,
            children: [
              Text("اختر العنوان"),
              Gap(10),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<Address>(
                  isDense: true,
                  hint: Text(
                    "اختر عنوان",
                    style: style12semibold,
                  ),
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
                  onChanged: (Address? address) {
                    if (address != null) {
                      controller.selectAddress(address);
                    }
                  },
                  items: homecontroller.addressList.map((address) {
                    return DropdownMenuItem<Address>(
                      value: address,
                      child: Text(
                        '${address.name}',
                        style: style15semibold,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Gap(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اضف عنوان اخر",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(60),
                  GestureDetector(
                    onTap: () => CustomRoute.RouteReplacementTo(
                      context,
                      ChangeNotifierProvider(
                        create: (context) => AddAddressController(),
                        lazy: true,
                        builder: (context, child) => AddAddress(),
                      ),
                    ),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: kSecendryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.add,
                        color: kBaseColor,
                      ),
                    ),
                  )
                ],
              ),
              Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CheckBoxCustom(
                        color: kPrimaryColor,
                        check: !controller.sheduleappoiment,
                        onChanged: (value) {
                          controller.sheduleappoiment = false;
                          controller.date_wanted = '';
                          controller.notifyListeners();
                        },
                      ),
                      Gap(10),
                      Text("التوصيل فورياً")
                    ],
                  ),
                  Row(
                    children: [
                      CheckBoxCustom(
                        check: controller.sheduleappoiment,
                        onChanged: (value) {
                          controller.sheduleappoiment = true;
                          controller.date_wanted = '';
                          controller.notifyListeners();
                        },
                      ),
                      Gap(10),
                      Text(
                        "التوصيل ضمن وقت محدد",
                        // style: style12semibold,
                      ),
                    ],
                  )
                ],
              ),
              Gap(10),
              controller.sheduleappoiment
                  ? Row(
                      children: [
                        Icon(Icons.calendar_month_outlined),
                        Gap(10),
                        Text(
                          "اختر التوقيت المناسب",
                          style: style12semibold,
                        ),
                        Gap(10),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              isDense: true,
                              hint: Text(
                                controller.date_wanted == null
                                    ? "اختر التوقيت"
                                    : controller.date_wanted!,
                                style: style12semibold,
                              ),
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
                              onChanged: (String? date) {
                                controller.date_wanted = date;
                              },
                              items: timeSlots.map((String time) {
                                return DropdownMenuItem<String>(
                                  value: time,
                                  child: Text(
                                    time,
                                    style: style15semibold,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(),
              Gap(10),
              Row(
                children: [
                  CheckBoxCustom(
                    color: kPrimaryColor,
                    check: controller.nearestman,
                    onChanged: (value) {
                      controller.nearestman = value!;
                      controller.notifyListeners();
                    },
                  ),
                  Gap(10),
                  Text("الطلب عبر مقدمي الخدمة ضمن المنطقة")
                ],
              ),
              Gap(10),
              !controller.nearestman
                  ? Row(
                      children: [
                        Text("او الطلب عبر مندوب معين"),
                        Gap(10),
                        Expanded(
                          child: TextInputCustom(
                            hint: 'ادخل رمز المندوب',
                            controller: controller.codecontroller,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Gap(20),
              Text("* اختر نوع عملية الدفع"),
              Gap(10),
              Row(
                children: [
                  CheckBoxCustom(
                    color: kPrimaryColor,
                    check: controller.cash,
                    onChanged: (value) {
                      controller.changePaymentMethod('cash');
                    },
                  ),
                  Gap(10),
                  Text("كاش عند التسليم")
                ],
              ),
              Gap(10),
              Row(
                children: [
                  CheckBoxCustom(
                    color: kPrimaryColor,
                    check: controller.credit,
                    onChanged: (value) {
                      controller.changePaymentMethod('credit');
                    },
                  ),
                  Gap(10),
                  Text("بطاقة عند التسليم")
                ],
              ),
              Gap(10),
              Row(
                children: [
                  CheckBoxCustom(
                    color: kPrimaryColor,
                    check: controller.e_wallet,
                    onChanged: (value) {
                      controller.changePaymentMethod('wallet');
                    },
                  ),
                  Gap(10),
                  Text("محفظة الكترونية")
                ],
              ),
              Gap(30),
              GestureDetector(
                onTap: () async {
                  controller.UpdateOrder(context, id: orderes!.id!);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 43,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryColor,
                          kBaseThirdyColor,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      "تعديل",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kBaseColor,
                      ),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
