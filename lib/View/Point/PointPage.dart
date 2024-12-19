import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Controller/PointSystemController.dart';
import 'package:gas_app/Services/CustomDialog.dart';
import 'package:gas_app/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PointPage extends StatefulWidget {
  const PointPage({super.key});

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  @override
  void initState() {
    pointSystemController.GetUserCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pointSystemController =
        Provider.of<PointSystemController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text("نقاطي"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "سياسة تجميع النقاط",
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          ),
          Gap(10),
          Container(
            decoration: BoxDecoration(
              color: Color(0xfffff6d5),
              border: Border.all(
                color: Color(0xffeed980),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "بداية مجرد دخولك إلى المنصة سيتم إهداؤك 5 نقاط مجاناً وعند كل استفادة أو طلب خدمة من خلال المنصة سيتم إهداؤك 10 نقاط عند طلب خدمة من التطبيق..",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ),
          Gap(10),
          Row(
            children: [
              Text(
                "رصيد النقاط الخاص بك",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              Gap(10),
              Consumer<PointSystemController>(
                  builder: (context, controller, child) => controller.isloading
                      ? LoadingAnimationWidget.flickr(
                          leftDotColor: kPrimaryColor,
                          rightDotColor: kFourthColor,
                          size: 15)
                      : Text(controller.points!.toString()))
            ],
          ),
          Wrap(
            spacing: 10,
            children: [
              Text(
                "كود الدعوة الخاص بك",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              Gap(10),
              Consumer<PointSystemController>(
                builder: (context, controller, child) => controller.isloading
                    ? LoadingAnimationWidget.flickr(
                        leftDotColor: kPrimaryColor,
                        rightDotColor: kFourthColor,
                        size: 15)
                    : SelectableText(
                        controller.invitecode!.toString(),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
              ),
              Consumer<PointSystemController>(
                builder: (context, controller, child) => TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                              text: controller.invitecode!.toString()))
                          .then((value) => //only if ->
                              CustomDialog.Dialog(context,
                                  title:
                                      "تم نسخ رمز الدعوة بنجاح")); // -> show a notification
                    },
                    child: Text("نسخ")),
              )
            ],
          )
        ],
      ),
    );
  }
}
