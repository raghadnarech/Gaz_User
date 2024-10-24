import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/Objection/Controller/ObjectionController.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ObjectionPage extends StatelessWidget {
  const ObjectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text(
          "رفع اعتراض",
          style: style15semibold,
        ),
      ),
      body: Consumer<ObjectionController>(
        builder: (context, controller, child) => ListView(
          padding: EdgeInsets.all(8),
          children: [
            Text("نص الاعتراض"),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextInputCustom(
                controller: controller.reporttext,
              ),
            ),
            Gap(20),
            Text("ارفاق صورة"),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.pickimage(ImageSource.gallery, context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSecendryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "تحميل الصورة",
                        style: style15semiboldwhite,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Gap(20),
            controller.imagenotif != null
                ? Center(
                    child: SizedBox(
                      height: Responsive.getHeight(context) * .2,
                      child: Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                border: Border.all(color: kPrimaryColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: Image.file(
                                    File(controller.imagenotif!.path)),
                              )),
                          GestureDetector(
                            onTap: () => controller.removeimagenotif(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: kBaseColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            Gap(150),
            GestureDetector(
              onTap: () {
                controller.Report(context);
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
