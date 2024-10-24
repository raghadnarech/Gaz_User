// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Controller/CartController.dart';
import 'package:gas_app/Model/Product.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';

class CustomCartProductGaz extends StatefulWidget {
  CustomCartProductGaz({this.product, this.code});
  Product? product;
  String? code;

  @override
  State<CustomCartProductGaz> createState() => _CustomCartProductGazState();
}

class _CustomCartProductGazState extends State<CustomCartProductGaz> {
  int quan = 0;

  // bool cash = false;

  // bool credit = false;

  // bool e_wallet = false;

  @override
  Widget build(BuildContext context) {
    cartController = Provider.of<CartController>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: kThirdryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(27),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/splash.png",
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        image: "${AppApi.IMAGEURL}${widget.product!.image}",
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/images/splash.png"),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: kFourthColor,
                            size: 10,
                          ),
                          Gap(5),
                          AutoSizeText(
                            widget.product!.name!,
                            maxLines: 1,
                            style: style15semibold,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        "${widget.product!.price} ريال + الرسوم",
                        maxLines: 1,
                        style: style15semibold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<CartController>(
              builder: (context, controller, child) => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (quan != 0) {
                          showDialog(
                            barrierDismissible: false,
                            barrierLabel: '',
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setState) => BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Dialog(
                                  insetPadding: EdgeInsets.all(15),
                                  elevation: 10,
                                  alignment: Alignment(0, -.4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              CustomRoute.RoutePop(context);
                                              // cash = false;
                                              // credit = false;
                                              // e_wallet = false;
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: kBaseThirdyColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "سيتم إضافة ${widget.product!.name} العدد $quan إلى السلة",
                                                style: style15semibold,
                                              ),
                                              Gap(15),
                                              Gap(35),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          controller
                                                              .addGazProduct(
                                                                  widget
                                                                      .product!,
                                                                  quan,
                                                                  widget.code);
                                                          CustomRoute.RoutePop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kFourthColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Center(
                                                              child: Text(
                                                                "إضافة",
                                                                style: TextStyle(
                                                                    color:
                                                                        kBaseColor,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Gap(60),
                                                    Expanded(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: kThirdryColor,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Center(
                                                            child: Text(
                                                              "إلغاء",
                                                              style: TextStyle(
                                                                  color:
                                                                      kBaseThirdyColor,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Gap(20),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: kSecendryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: kBaseColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(5),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                quan++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              color: kBaseThirdyColor,
                              size: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: AutoSizeText(
                              "$quan",
                              minFontSize: 7,
                              style: TextStyle(
                                  // fontSize: 15,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quan != 0) {
                                  quan--;
                                }
                              });
                            },
                            child: Icon(
                              Icons.remove,
                              color: kBaseThirdyColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}