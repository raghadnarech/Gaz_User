import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/OrderAccepted/Controller/OrderAcceptedController.dart';
import 'package:gas_app/View/Ticket/Controller/TicketController.dart';
import 'package:gas_app/View/Ticket/TicketPage.dart';
import 'package:provider/provider.dart';

class OrderAccepted extends StatefulWidget {
  const OrderAccepted({super.key});

  @override
  State<OrderAccepted> createState() => _OrderAcceptedState();
}

class _OrderAcceptedState extends State<OrderAccepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // GestureDetector(
          //   onTap: () => scaffoldKey.currentState?.openEndDrawer(),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SvgPicture.asset(
          //       'assets/svg/menu.svg',
          //       width: 30,
          //       height: 25,
          //     ),
          //   ),
          // ),
        ],
        // leading: GestureDetector(
        //     onTap: () => CustomRoute.RoutePop(context),
        //     child: Icon(Icons.arrow_back)),
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text("قبول الطلب"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Consumer<OrderAcceptedController>(
            builder: (context, controller, child) {
              return GestureDetector(
                onTap: () => CustomRoute.RouteReplacementTo(
                  context,
                  ChangeNotifierProvider<TicketController>(
                    create: (context) => TicketController()
                      ..oninit(controller.order.mandob!.user!.id!)
                      ..GetAllTicket(context),
                    builder: (context, child) => TicketPage(
                      title: "التواصل مع المندوب",
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("التواصل مع المندوب ضمن التطبيق"),
                    Gap(10),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffDD0B0B),
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/svg/chat.svg',
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Text(
            "*يرجى الملاحظة انك تستطيع الغاء الطلب خلال مدة أقصاها 100 ثانية",
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
          Consumer<OrderAcceptedController>(
              builder: (context, controller, child) {
            DateTime orderCreationTime =
                DateTime.parse(controller.order.createdAt.toString());
            Duration difference =
                controller.servertime!.difference(orderCreationTime);
            // bool isExpired = difference > Duration(seconds: 100);
            return Column(
              children: [
                // Text("${controller.servertime}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("اسم المندوب"),
                        Gap(10),
                        Text("اسم المندوب"),
                      ],
                    ),
                    TimerCountdown(
                      enableDescriptions: false,
                      timeTextStyle: TextStyle(locale: Locale('ar')),
                      format: CountDownTimerFormat.minutesSeconds,
                      endTime: DateTime.now()
                          .add(Duration(seconds: 100) - difference),
                      onEnd: () {
                        // setState(() {
                        //   isExpired = false;
                        // });
                        // يمكن إضافة منطق لتعطيل الزر هنا بعد انتهاء العداد
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("الوقت المتوقع للاستلام"),
                    Gap(10),
                    Text("ربع ساعة"),
                  ],
                ),
                Row(
                  children: [
                    Text("السعر"),
                    Gap(10),
                    Text("ريال 100"),
                  ],
                ),
                Row(
                  children: [
                    Text("رقم المندوب"),
                    Gap(10),
                    Text("0505056540"),
                  ],
                ),
                Row(
                  children: [
                    Text("رقم السيارة"),
                    Gap(10),
                    Text("55656526652"),
                  ],
                ),
                Gap(50),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () {
                      // CustomRoute.RouteTo(
                      //     context,
                      //     ChangeNotifierProvider(
                      //         create: (context) => OrderController()
                      //           ..oninit(controller.order.id!),
                      //         builder: (context, child) => TrackMandob(
                      //               mandob: Mandob(
                      //                   id: 2,
                      //                   user: User(
                      //                       userName: "lak",
                      //                       phone: "65464565")),
                      //             )));
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
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff1B2A36),
                              Color(0xff35536B),
                            ]),
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
                ),
                Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () {
                      // CustomRoute.RouteTo(
                      //     context,
                      //     ChangeNotifierProvider(
                      //         create: (context) => OrderController()
                      //           ..oninit(controller.order.id!),
                      //         builder: (context, child) => TrackMandob(
                      //               mandob: controller.order.mandob!,
                      //             )));
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
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff722B23),
                              Color(0xffE45545),
                            ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "إلغاء الطلب",
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
              ],
            );
          }),
        ],
      ),
    );
  }
}
