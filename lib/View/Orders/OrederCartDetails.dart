// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Model/Order.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Destination/TrackOrder.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/main.dart';
import 'package:intl/intl.dart';

class OrederCartDetails extends StatefulWidget {
  OrederCartDetails(
      {required this.invoices,
      required this.orderes,
      required this.controller});
  HomePageController controller;
  Orderes orderes;
  List<Invoices> invoices;

  @override
  State<OrederCartDetails> createState() => _OrederCartDetailsState();
}

class _OrederCartDetailsState extends State<OrederCartDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text(
          "تفاصيل الطلب",
          style: style15semibold,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "رقم الفاتورة",
                    style: style18semibold,
                  ),
                  Gap(5),
                  Text(
                    "${widget.orderes.number}",
                    style: style15semibold,
                  ),
                ],
              ),
            ],
          ),
          Gap(20),
          widget.invoices.isEmpty
              ? Container()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          "المنتج",
                          style: style18semibold,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "القيمة",
                          style: style18semibold,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "الكمية",
                          style: style18semibold,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "الاجمالي",
                          style: style18semibold,
                        ),
                      )
                    ],
                    rows: widget.invoices
                        .expand((invoice) =>
                            invoice.products!.map((product) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        "${product.name}",
                                        style: style15semibold,
                                        maxLines: 1,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "${product.price} ريال",
                                        style: style15semibold,
                                        maxLines: 1,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "${product.quantity}",
                                        style: style15semibold,
                                        maxLines: 1,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "${product.price * product.quantity} ريال",
                                        style: style15semibold,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                )))
                        .toList(),
                  ),
                ),
          Gap(20),
          Divider(
            endIndent: 50,
            indent: 50,
            color: kPrimaryColor,
          ),
          Gap(20),
          Row(
            children: [
              Text(
                "عنوان التوصيل",
                style: style18semibold,
              ),
              Gap(10),
              Row(
                children: [
                  Icon(Icons.location_on),
                  // Text(
                  //   "${widget.controller.addressList.where((element) => element.id == widget.orderes.addressId).first.name}",
                  //   style: style15semibold,
                  // ),
                ],
              ),
            ],
          ),
          Gap(10),
          Row(
            children: [
              Text(
                "تاريخ الطلب",
                style: style18semibold,
              ),
              Gap(10),
              Text(
                "${DateFormat('yyyy/MM/dd').format(DateTime.parse(widget.orderes.createdAt.toString()))}",
                style: style15semibold,
              ),
            ],
          ),
          Gap(10),
          Row(
            children: [
              Text(
                "السعر الصافي",
                style: style18semibold,
              ),
              Gap(10),
              Text(
                "${widget.orderes.total}",
                style: style15semibold,
              ),
            ],
          ),
          Gap(10),
          Row(
            children: [
              Text(
                "السعر بعد الرمز الترويجي",
                style: style18semibold,
              ),
              Gap(10),
              Text(
                "${widget.orderes.total}",
                style: style15semibold,
              ),
            ],
          ),
          widget.orderes.toDoor == '1'
              ? Column(
                  children: [
                    Gap(10),
                    Row(
                      children: [
                        Text(
                          "رسوم التوصيل",
                          style: style18semibold,
                        ),
                        Gap(10),
                        Text(
                          "${cartController.fees.delivaryFees}",
                          style: style15semibold,
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
          widget.orderes.toHouse == '1'
              ? Column(
                  children: [
                    Gap(10),
                    Row(
                      children: [
                        Text(
                          "رسوم توصيل الأدوار العليا",
                          style: style18semibold,
                        ),
                        Gap(10),
                      ],
                    ),
                  ],
                )
              : Container(),
          widget.orderes.isOnTime == '1'
              ? Column(
                  children: [
                    Gap(10),
                    Row(
                      children: [
                        Text(
                          "رسوم توصيل خارج أوقات الدوام",
                          style: style15semibold,
                        ),
                        Gap(10),
                        Text(
                          "${cartController.fees.outTimeFees}",
                          style: style15semibold,
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
          Gap(10),
          Divider(
            endIndent: 50,
            indent: 50,
            thickness: 2,
            color: kFourthColor,
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "المجموع الكلي مع الرسوم",
                style: style18semibold,
              ),
              Gap(10),
              Text(
                "${widget.orderes.totalWithFees} ريال",
                style: style15semibold,
              ),
            ],
          ),
          Gap(50),
          widget.orderes.status == 'pending'
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () {
                      log(widget.orderes.id.toString());
                      CustomRoute.RouteTo(
                          context,
                          TrackOrder(
                            id: widget.orderes.id,
                          ));
                    },
                    child: Container(
                      height: 43,
                      width: Responsive.getWidth(context) * .8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: kBaseThirdyColor.withAlpha(75),
                              blurRadius: 7)
                        ],
                        color: Color(0xff445461),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "تتبع الطلب",
                          style: TextStyle(
                            fontSize: 15,
                            color: kBaseColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),

          //
          Gap(10),
          // Gap(20),
          // if (!isExpired)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TimerCountdown(
          //         enableDescriptions: false,
          //         timeTextStyle: TextStyle(locale: Locale('ar')),
          //         format: CountDownTimerFormat.minutesSeconds,
          //         endTime: DateTime.now()
          //             .add(Duration(seconds: 100) - difference!),
          //         onEnd: () {
          //           setState(() {
          //             isExpired = false;
          //           });
          //           // يمكن إضافة منطق لتعطيل الزر هنا بعد انتهاء العداد
          //         },
          //       ),
          //     ],
          //   ),
          // if (!isExpired) Gap(20),
          // widget.orderes.status != '6'
          //     ?
          //     : Container()
        ],
      ),
    );
  }
}
