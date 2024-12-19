// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Destination/TrackOrder.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Orders/Controller/OrderDetailsController.dart';
import 'package:gas_app/main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrederCartDetails extends StatefulWidget {
  OrederCartDetails({required this.controller});
  HomePageController controller;

  @override
  State<OrederCartDetails> createState() => _OrederCartDetailsState();
}

class _OrederCartDetailsState extends State<OrederCartDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetailsController>(
      builder: (context, controller, child) => Scaffold(
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
          padding: const EdgeInsets.all(8),
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
                    const Gap(5),
                    Text(
                      controller.order.order!.number ?? '',
                      style: style15semibold,
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            controller.order.order!.invoices!.isEmpty
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
                            'الإجمالي',
                            style: style18semibold,
                          ),
                        ),
                      ],
                      rows: controller.order.order!.invoices!
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
            const Gap(20),
            const Divider(endIndent: 50, indent: 50, color: kPrimaryColor),
            const Gap(20),
            Row(
              children: [
                Text(
                  "عنوان التوصيل",
                  style: style18semibold,
                ),
                const Gap(10),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Text(
                      widget.controller.addressList
                              .firstWhere((e) =>
                                  e.id == controller.order.order!.addressId)
                              .name ??
                          "غير محدد",
                      style: style15semibold,
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Text(
                  "تاريخ الطلب",
                  style: style18semibold,
                ),
                const Gap(10),
                Text(
                  DateFormat('yyyy/MM/dd').format(
                    DateTime.parse(controller.order.order!.createdAt ?? ''),
                  ),
                  style: style15semibold,
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Text(
                  "السعر الصافي",
                  style: style18semibold,
                ),
                const Gap(10),
                Text(
                  '${controller.order.order!.total ?? 0} ريال',
                  style: style15semibold,
                ),
              ],
            ),
            const Gap(10),
            controller.order.order!.toDoor == '1'
                ? Row(
                    children: [
                      Text(
                        "رسوم التوصيل",
                        style: style18semibold,
                      ),
                      const Gap(10),
                      Text(
                        '${cartController.fees.delivaryFees ?? 0} ريال',
                        style: style15semibold,
                      ),
                    ],
                  )
                : Container(),
            const Divider(
                endIndent: 50, indent: 50, thickness: 2, color: kFourthColor),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "السعر مع الرسوم",
                  style: style18semibold,
                ),
                const Gap(10),
                Text(
                  '${controller.order.order!.totalWithFees ?? 0} ريال',
                  style: style15semibold,
                ),
              ],
            ),
            const Gap(50),
            controller.order.order!.status == 'pending'
                ? GestureDetector(
                    onTap: () {
                      log(controller.order.order!.id.toString());
                      homePageController.markers = {};

                      CustomRoute.RouteTo(
                        context,
                        TrackOrder(
                          id: controller.order.order!.id,
                        ),
                      );
                    },
                    child: Container(
                      height: 43,
                      width: Responsive.getWidth(context) * .8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: kBaseThirdyColor.withAlpha(75),
                            blurRadius: 7,
                          )
                        ],
                        color: const Color(0xff445461),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "تتبع الطلب",
                          style: const TextStyle(
                            fontSize: 15,
                            color: kBaseColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
