// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/View/Rate/Controller/RateController.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';

class RatePage extends StatelessWidget {
  RatePage(this.reciver);
  var reciver;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text(
          "تقييم المورد",
          style: style15semibold,
        ),
      ),
      body: Consumer<RateController>(
        builder: (context, controller, child) => ListView(
          padding: EdgeInsets.all(8),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("تقييم المندوب"),
                RatingBar(
                  minRating: 1,
                  maxRating: 5,
                  allowHalfRating: false,
                  itemSize: 25,
                  ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      half: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      empty: Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                      )),
                  glow: false,
                  onRatingUpdate: (value) {
                    controller.stars = value;
                  },
                )
              ],
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextInputCustom(
                controller: controller.comment,
              ),
            ),
            Gap(100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("تقييم الخدمة"),
                RatingBar(
                  allowHalfRating: false,
                  itemSize: 25,
                  minRating: 1,
                  maxRating: 5,
                  ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      half: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      empty: Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                      )),
                  glow: false,
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextInputCustom(),
            ),
            Gap(150),
            GestureDetector(
              onTap: () {
                controller.Rate(context, reciver.userId);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xff722B23),
                            Color(0xffE45545),
                          ])),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                        child: Text(
                      "ارسال",
                      style: TextStyle(
                          color: kBaseColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
