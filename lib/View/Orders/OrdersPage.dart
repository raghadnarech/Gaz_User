// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Objection/Controller/ObjectionController.dart';
import 'package:gas_app/View/Objection/ObjectionPage.dart';
import 'package:gas_app/View/Orders/OrederCartDetails.dart';
import 'package:gas_app/View/Rate/Controller/RateController.dart';
import 'package:gas_app/View/Rate/RatePage.dart';
import 'package:gas_app/View/Widgets/Drawer/CustomDrawer.dart';
import 'package:gas_app/main.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(),
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
        title: Text("الطلبات"),
      ),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Text("الجارية"),
                  ),
                  Tab(
                    child: Text("الملغاة"),
                  ),
                  Tab(
                    child: Text("السابقة"),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                    children: [Orders(), CancelOrder(), PreviosOrders()]),
              )
            ],
          )),
    );
  }
}

class Orders extends StatefulWidget {
  const Orders({
    super.key,
  });

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      homePageController.GetMyOrders('pending');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homePageController =
        Provider.of<HomePageController>(context, listen: false);
    return Consumer<HomePageController>(
      builder: (context, controller, child) => RefreshIndicator(
        onRefresh: () => controller.GetMyOrders('pending'),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Gap(10),
              controller.isloadingorder
                  ? Center(
                      child: LoadingAnimationWidget.beat(
                          color: kPrimaryColor, size: 30))
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.listorder.length,
                      itemBuilder: (context, index) {
                        DateTime orderCreationTime = DateTime.parse(
                            controller.listorder[index].createdAt.toString());
                        Duration difference = controller.servertime!
                            .difference(orderCreationTime);
                        bool isExpired = difference > Duration(minutes: 15);
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor,
                              ),
                              color: kThirdryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "اسم المورد",
                                            style: style15semibold,
                                          ),
                                          Gap(10),
                                          Text(
                                            "غير معروف",
                                            style: style15semibold,
                                          ),
                                        ],
                                      ),
                                      Gap(5),
                                      Row(
                                        children: [
                                          Text(
                                            "حالة الطلب",
                                            style: style15semibold,
                                          ),
                                          Gap(10),
                                          Text(
                                            "${controller.listorder[index].status}",
                                            style: style15semibold,
                                          ),
                                        ],
                                      ),
                                      Gap(5),
                                      Text(
                                        Intl.DateFormat('HH:mm | yyyy-MM-dd')
                                            .format(
                                          DateTime.parse(controller
                                              .listorder[index].createdAt!),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // controller.listorder[index].status != '6'
                                      //     ?
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              GestureDetector(
                                                onTap: () => isExpired
                                                    ? {}
                                                    : CustomRoute.RouteTo(
                                                        context,
                                                        ChangeNotifierProvider(
                                                          create: (context) =>
                                                              ObjectionController(),
                                                          builder: (context,
                                                                  child) =>
                                                              ObjectionPage(),
                                                        )),
                                                child: Text(
                                                  "رفع اعتراض",
                                                  style: TextStyle(
                                                    color: isExpired
                                                        ? Colors.grey
                                                        : kFourthColor, // تغيير لون النص بناءً على الحالة
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Gap(5),
                                              if (!isExpired)
                                                TimerCountdown(
                                                  enableDescriptions: false,
                                                  timeTextStyle: TextStyle(
                                                      locale: Locale('ar')),
                                                  format: CountDownTimerFormat
                                                      .minutesSeconds,
                                                  endTime: DateTime.now().add(
                                                      Duration(minutes: 15) -
                                                          difference),
                                                  onEnd: () {
                                                    setState(() {
                                                      isExpired = false;
                                                    });
                                                    // يمكن إضافة منطق لتعطيل الزر هنا بعد انتهاء العداد
                                                  },
                                                ),
                                              // Text(
                                              //   "13:00",
                                              //   style: TextStyle(
                                              //       color: kBaseThirdyColor,
                                              //       fontSize: 12,
                                              //       fontWeight: FontWeight.w600),
                                              // ),
                                            ],
                                          ),
                                          Gap(5),
                                          GestureDetector(
                                            onTap: () => CustomRoute.RouteTo(
                                                context,
                                                ChangeNotifierProvider(
                                                  create: (context) =>
                                                      RateController(),
                                                  builder: (context, child) =>
                                                      RatePage(controller
                                                          .listorder[index]
                                                          .mandob),
                                                )),
                                            child: Text(
                                              "تقييم الطلب",
                                              style: TextStyle(
                                                  color: kFourthColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Gap(5),
                                        ],
                                      ),
                                      // : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          CustomRoute.RouteTo(
                                              context,
                                              OrederCartDetails(
                                                invoices: controller
                                                    .listorder[index].invoices!,
                                                orderes:
                                                    controller.listorder[index],
                                                controller: controller,
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kFourthColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Text(
                                              "التفاصيل",
                                              style: TextStyle(
                                                  color: kBaseColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CancelOrder extends StatefulWidget {
  const CancelOrder({
    super.key,
  });

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      homePageController.GetMyOrders('canceled');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homePageController =
        Provider.of<HomePageController>(context, listen: false);
    return Consumer<HomePageController>(
      builder: (context, controller, child) => RefreshIndicator(
        onRefresh: () => controller.GetMyOrders('canceled'),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // shrinkWrap: true,
            children: [
              Gap(10),
              // Container(
              //   width: Responsive.getWidth(context),
              //   height: 100,
              //   color: kBaseSecandryColor,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Wrap(
              //       direction: Axis.horizontal,
              //       verticalDirection: VerticalDirection.down,
              //       runAlignment: WrapAlignment.start,
              //       spacing: 20,
              //       children: [
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kSecendryColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "تم ارسال الطلب",
              //               style: TextStyle(
              //                   color: kSecendryColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kPrimaryColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "تم قبول الطلب من المورد",
              //               style: TextStyle(
              //                   color: kPrimaryColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kFourthColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "يتم تجهيز الطلب",
              //               style: TextStyle(
              //                   color: kFourthColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: Colors.green,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "تم الانتهاء من التجهيز",
              //               style: TextStyle(
              //                   color: Colors.green,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kBaseThirdyColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "استلام المندوب للطلب",
              //               style: TextStyle(
              //                   color: kBaseThirdyColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Gap(20),
              controller.isloadingorder
                  ? Center(
                      child: LoadingAnimationWidget.beat(
                          color: kPrimaryColor, size: 30))
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.listorder.length,
                      itemBuilder: (context, index) {
                        DateTime orderCreationTime = DateTime.parse(
                            controller.listorder[index].createdAt.toString());
                        Duration difference = controller.servertime!
                            .difference(orderCreationTime);
                        bool isExpired = difference > Duration(minutes: 15);
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor,
                              ),
                              color: kThirdryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "اسم المورد",
                                            style: style15semibold,
                                          ),
                                          Gap(10),
                                          Text(
                                            "غير معروف",
                                            style: style15semibold,
                                          ),
                                        ],
                                      ),
                                      Gap(5),
                                      Row(
                                        children: [
                                          Text(
                                            "حالة الطلب",
                                            style: style15semibold,
                                          ),
                                          Gap(10),
                                          Text(
                                            "${controller.listorder[index].status}",
                                            style: style15semibold,
                                          ),
                                        ],
                                      ),
                                      Gap(5),
                                      Text(
                                        Intl.DateFormat('HH:mm | yyyy-MM-dd')
                                            .format(
                                          DateTime.parse(controller
                                              .listorder[index].createdAt!),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // controller.listorder[index].status != '6'
                                      //     ?
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              GestureDetector(
                                                onTap: () => isExpired
                                                    ? {}
                                                    : CustomRoute.RouteTo(
                                                        context,
                                                        ChangeNotifierProvider(
                                                          create: (context) =>
                                                              ObjectionController(),
                                                          builder: (context,
                                                                  child) =>
                                                              ObjectionPage(),
                                                        )),
                                                child: Text(
                                                  "رفع اعتراض",
                                                  style: TextStyle(
                                                    color: isExpired
                                                        ? Colors.grey
                                                        : kFourthColor, // تغيير لون النص بناءً على الحالة
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Gap(5),
                                              if (!isExpired)
                                                TimerCountdown(
                                                  enableDescriptions: false,
                                                  timeTextStyle: TextStyle(
                                                      locale: Locale('ar')),
                                                  format: CountDownTimerFormat
                                                      .minutesSeconds,
                                                  endTime: DateTime.now().add(
                                                      Duration(minutes: 15) -
                                                          difference),
                                                  onEnd: () {
                                                    setState(() {
                                                      isExpired = false;
                                                    });
                                                    // يمكن إضافة منطق لتعطيل الزر هنا بعد انتهاء العداد
                                                  },
                                                ),
                                              // Text(
                                              //   "13:00",
                                              //   style: TextStyle(
                                              //       color: kBaseThirdyColor,
                                              //       fontSize: 12,
                                              //       fontWeight: FontWeight.w600),
                                              // ),
                                            ],
                                          ),
                                          Gap(5),
                                          GestureDetector(
                                            onTap: () => CustomRoute.RouteTo(
                                                context,
                                                ChangeNotifierProvider(
                                                  create: (context) =>
                                                      RateController(),
                                                  builder: (context, child) =>
                                                      RatePage(controller
                                                          .listorder[index]
                                                          .mandob),
                                                )),
                                            child: Text(
                                              "تقييم الطلب",
                                              style: TextStyle(
                                                  color: kFourthColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Gap(5),
                                        ],
                                      ),
                                      // : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          CustomRoute.RouteTo(
                                              context,
                                              OrederCartDetails(
                                                invoices: controller
                                                    .listorder[index].invoices!,
                                                orderes:
                                                    controller.listorder[index],
                                                controller: controller,
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kFourthColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Text(
                                              "التفاصيل",
                                              style: TextStyle(
                                                  color: kBaseColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviosOrders extends StatefulWidget {
  const PreviosOrders({
    super.key,
  });

  @override
  State<PreviosOrders> createState() => _PreviosOrdersState();
}

class _PreviosOrdersState extends State<PreviosOrders> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      homePageController.GetMyOrders('old');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homePageController =
        Provider.of<HomePageController>(context, listen: false);
    return Consumer<HomePageController>(
      builder: (context, controller, child) => RefreshIndicator(
        onRefresh: () => controller.GetMyOrders('old'),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // shrinkWrap: true,
            children: [
              Gap(10),
              // Container(
              //   width: Responsive.getWidth(context),
              //   height: 100,
              //   color: kBaseSecandryColor,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Wrap(
              //       direction: Axis.horizontal,
              //       verticalDirection: VerticalDirection.down,
              //       runAlignment: WrapAlignment.start,
              //       spacing: 20,
              //       children: [
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kSecendryColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "تم ارسال الطلب",
              //               style: TextStyle(
              //                   color: kSecendryColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kPrimaryColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "تم قبول الطلب من المورد",
              //               style: TextStyle(
              //                   color: kPrimaryColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kFourthColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "يتم تجهيز الطلب",
              //               style: TextStyle(
              //                   color: kFourthColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: Colors.green,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "تم الانتهاء من التجهيز",
              //               style: TextStyle(
              //                   color: Colors.green,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         ),
              //         Wrap(
              //           spacing: 10,
              //           alignment: WrapAlignment.center,
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Container(
              //               color: kBaseThirdyColor,
              //               width: 10,
              //               height: 10,
              //             ),
              //             Text(
              //               "استلام المندوب للطلب",
              //               style: TextStyle(
              //                   color: kBaseThirdyColor,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Gap(20),
              controller.isloadingorder
                  ? Center(
                      child: LoadingAnimationWidget.beat(
                          color: kPrimaryColor, size: 30))
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.listorder.length,
                      itemBuilder: (context, index) {
                        DateTime orderCreationTime = DateTime.parse(
                            controller.listorder[index].createdAt.toString());
                        Duration difference = controller.servertime!
                            .difference(orderCreationTime);
                        bool isExpired = difference > Duration(minutes: 15);
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor,
                              ),
                              color: kThirdryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "اسم المورد",
                                            style: style15semibold,
                                          ),
                                          Gap(10),
                                          Text(
                                            "غير معروف",
                                            style: style15semibold,
                                          ),
                                        ],
                                      ),
                                      Gap(5),
                                      Row(
                                        children: [
                                          Text(
                                            "حالة الطلب",
                                            style: style15semibold,
                                          ),
                                          Gap(10),
                                          Text(
                                            "${controller.listorder[index].status}",
                                            style: style15semibold,
                                          ),
                                        ],
                                      ),
                                      Gap(5),
                                      Text(
                                        Intl.DateFormat('HH:mm | yyyy-MM-dd')
                                            .format(
                                          DateTime.parse(controller
                                              .listorder[index].createdAt!),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // controller.listorder[index].status != '6'
                                      //     ?
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              GestureDetector(
                                                onTap: () => isExpired
                                                    ? {}
                                                    : CustomRoute.RouteTo(
                                                        context,
                                                        ChangeNotifierProvider(
                                                          create: (context) =>
                                                              ObjectionController(),
                                                          builder: (context,
                                                                  child) =>
                                                              ObjectionPage(),
                                                        )),
                                                child: Text(
                                                  "رفع اعتراض",
                                                  style: TextStyle(
                                                    color: isExpired
                                                        ? Colors.grey
                                                        : kFourthColor, // تغيير لون النص بناءً على الحالة
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Gap(5),
                                              if (!isExpired)
                                                TimerCountdown(
                                                  enableDescriptions: false,
                                                  timeTextStyle: TextStyle(
                                                      locale: Locale('ar')),
                                                  format: CountDownTimerFormat
                                                      .minutesSeconds,
                                                  endTime: DateTime.now().add(
                                                      Duration(minutes: 15) -
                                                          difference),
                                                  onEnd: () {
                                                    setState(() {
                                                      isExpired = false;
                                                    });
                                                    // يمكن إضافة منطق لتعطيل الزر هنا بعد انتهاء العداد
                                                  },
                                                ),
                                              // Text(
                                              //   "13:00",
                                              //   style: TextStyle(
                                              //       color: kBaseThirdyColor,
                                              //       fontSize: 12,
                                              //       fontWeight: FontWeight.w600),
                                              // ),
                                            ],
                                          ),
                                          Gap(5),
                                          GestureDetector(
                                            onTap: () => CustomRoute.RouteTo(
                                                context,
                                                ChangeNotifierProvider(
                                                  create: (context) =>
                                                      RateController(),
                                                  builder: (context, child) =>
                                                      RatePage(controller
                                                          .listorder[index]
                                                          .mandob),
                                                )),
                                            child: Text(
                                              "تقييم الطلب",
                                              style: TextStyle(
                                                  color: kFourthColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Gap(5),
                                        ],
                                      ),
                                      // : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          CustomRoute.RouteTo(
                                              context,
                                              OrederCartDetails(
                                                invoices: controller
                                                    .listorder[index].invoices!,
                                                orderes:
                                                    controller.listorder[index],
                                                controller: controller,
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kFourthColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Text(
                                              "التفاصيل",
                                              style: TextStyle(
                                                  color: kBaseColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
