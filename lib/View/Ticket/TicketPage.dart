// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Model/Message.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/Ticket/Controller/TicketController.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class TicketPage extends StatelessWidget {
  TicketPage({this.title});
  String? title;
  @override
  Widget build(BuildContext context) {
    return Consumer<TicketController>(
      builder: (context, controller, child) => Scaffold(
        bottomSheet: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: kBaseThirdyColor.withAlpha(100),
                blurRadius: 7,
              ),
            ],
            color: kThirdryColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextInputCustom(
                      controller: controller.message,
                      hint: 'اكتب رداً',
                    ),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.photo_size_select_actual_rounded),
                      Gap(10),
                      GestureDetector(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              controller.SendMessage(context);
                            }
                          },
                          child: Icon(Icons.send)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () => scaffoldKey.currentState?.openEndDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/svg/menu.svg',
                  width: 30,
                  height: 25,
                ),
              ),
            ),
          ],
          backgroundColor: Color(0xff445461),
          centerTitle: true,
          title: Text(
            title!,
            style: style15semibold,
          ),
        ),
        body: ListView.builder(
          itemCount: controller.messages!.length,
          itemBuilder: (context, index) {
            final message = controller.messages![index];
            if (message.receiverId == controller.reciveid) {
              return MessageRecive(message: message);
            } else {
              return MessageSent(message: message);
            }
          },
        ),
      ),
    );
  }
}

class MessageSent extends StatelessWidget {
  MessageSent({
    this.message,
  });
  Message? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
              width: Responsive.getWidth(context) * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: kThirdryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${message!.text}"),
              )),
        ],
      ),
    );
  }
}

class MessageRecive extends StatelessWidget {
  MessageRecive({this.message});
  Message? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: Responsive.getWidth(context) * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: kThirdryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${message!.text}"),
              )),
        ],
      ),
    );
  }
}
