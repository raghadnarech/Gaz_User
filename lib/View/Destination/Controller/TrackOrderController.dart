import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Services/Failure.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/Destination/TrackMandob.dart';
import 'package:gas_app/View/Destination/TrackOrder.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
import 'package:gas_app/main.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;

class TrackOrderController with ChangeNotifier {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  PusherChannelsFlutter pusherlocation = PusherChannelsFlutter.getInstance();

  Timer? _timer;
  static NetworkClient client = NetworkClient(http.Client());
  Map<String, bool> subscribedChannels = {};

  int? orderId;
  int? mandobid;
  String? status = 'تم تسليم الطلب للمندوب وجاري الاتجاه للموقع';

  void initorderid(int id) {
    orderId = id;
  }

  /// إدارة الاشتراك في القنوات
  Future<void> subscribeToChannel(String channelName,
      PusherChannelsFlutter pusherInstance, BuildContext context) async {
    if (subscribedChannels[channelName] == true) {
      log('Already subscribed to $channelName');
      return;
    }

    try {
      await pusherInstance.subscribe(
        channelName: channelName,
        onEvent: (event) {
          log("Event received in $channelName: ${event.data}");
          _handleEvent(event, channelName, context);
        },
      );
      subscribedChannels[channelName] = true;
      log('Subscribed to $channelName successfully');
    } catch (e) {
      log('Failed to subscribe to $channelName: $e');
    }
  }

  void unsubscribeFromChannel(
      String channelName, PusherChannelsFlutter pusherInstance) {
    if (subscribedChannels[channelName] != true) {
      log('Not subscribed to $channelName');
      return;
    }

    pusherInstance.unsubscribe(channelName: channelName);
    subscribedChannels[channelName] = false;
    log('Unsubscribed from $channelName');
  }

  void disposePusherChannel(
      PusherChannelsFlutter pusherInstance, String channelName) {
    unsubscribeFromChannel(channelName, pusherInstance);
    pusherInstance.disconnect();
  }

  // disposeTrackOrder(int orderId) {
  //   disposePusherChannel(pusher, 'order.$orderId');
  //   stopTracking();
  // }

  // disposeTrackMandob(int orderId, int mandodId) {
  //   disposePusherChannel(pusher, 'order.$orderId');
  //   disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
  // }

  void disposeProvider() {
    disposePusherChannel(pusher, 'order.$orderId');
    disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
    stopTracking();
    orderId = null;
    homePageController.markers = {};
    homePageController.notifyListeners();
  }

  void stopTracking() {
    _timer?.cancel();
  }

  void startTrackingOrder() {
    // if (_timer!.isActive) {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      try {
        final response = await client.request(
          requestType: RequestType.GET,
          path: '/time-check/$orderId',
        );
        log(response.statusCode.toString());
        log(response.body.toString());
      } catch (e) {
        log('Error getting location: $e');
      }
    });
    // }
  }

  /// تهيئة الاشتراك في قناة الطلب
  void initState(int value, BuildContext context) {
    orderId = value;
    log("Initializing orderId: $orderId");

    startTrackingOrder();
    _initializePusher(context, 'order.$orderId', pusher);
  }

  /// تهيئة الاشتراك في قناة موقع المندوب
  void initStateMandobLocation(int orderId, int value, BuildContext context) {
    mandobid = value;
    _initializePusher(context, 'mandob-location.$mandobid', pusherlocation);
    _initializePusher(context, 'order.$orderId', pusher);
  }

  /// تهيئة Pusher للقناة
  Future<void> _initializePusher(BuildContext context, String channelName,
      PusherChannelsFlutter pusherInstance) async {
    try {
      await pusherInstance.init(
        apiKey: 'fe3f88f1777344c1362a',
        cluster: 'ap2',
        authEndpoint: "https://mayadeen-md.com/gaz/public/broadcasting/auth",
        onAuthorizer: (String channelName, String socketId, options) async {
          log("onAuthorizer for $channelName");
        },
        onConnectionStateChange: (currentState, previousState) {
          log("Connection state changed from $previousState to $currentState");
        },
        onError: (message, code, error) {
          log("Error: $message, Code: $code, Error: $error");
        },
      );
      await subscribeToChannel(channelName, pusherInstance, context);
      await pusherInstance.connect();
    } catch (e) {
      log("ERROR initializing Pusher for $channelName: $e");
    }
  }

  /// التعامل مع الأحداث الواردة من القناة
  void _handleEvent(
      PusherEvent event, String channelName, BuildContext context) async {
    log("Event received in $channelName: ${event.data}");
    if (event.data != null && event.data.isNotEmpty) {
      var data = jsonDecode(event.data);
      if (event.data != null && event.data.isNotEmpty) {
        final HomePageController homePageController =
            Provider.of<HomePageController>(context, listen: false);
        homePageController.changemarkers(event);
      }
      if (data['status'] == 'canceled') {
        // عند إلغاء الطلب
        status = "تم إلغاء الطلب";
        orderId = int.parse(data['orderId']);
        homePageController.markers = {};
        homePageController.notifyListeners();
        stopTracking();
        disposePusherChannel(pusher, 'order.$orderId');
        disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
        CustomRoute.RouteReplacementTo(
          context,
          TrackOrder(
            id: int.parse(data['orderId']),
          ),
        );
      } else if (data['status'] == 'Delivaring') {
        // عند بدء التوصيل
        status = "الطلب في طريقه اليك";
        notifyListeners();
      } else if (data['invoices'] != null &&
          data['invoices'][0]['mandob_id'] != null) {
        // عند تسليم الطلب للمندوب
        final mandobId = data['invoices'][0]['mandob_id'];
        status = 'تم تسليم الطلب للمندوب وجاري الاتجاه للموقع';
        final orderId = data['order_id'];
        stopTracking();
        disposePusherChannel(pusher, 'order.$orderId');
        disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
        // استبدال الشاشة
        CustomRoute.RouteReplacementTo(
          context,
          TrackMandob(
            orderid: orderId,
            mandobid: mandobId,
            name: data['invoices'][0]['mandob']['user']['user_name'],
            phone: data['invoices'][0]['mandob']['user']['phone'],
            total_with_fees: data['invoices'][0]['total_with_fees'].toString(),
          ),
        );
      }
    }
  }

  Future<Either<Failure, bool>> CancelOrder() async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.CancelOrder(orderId!),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          log(res.toString());
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);

          return Left(ResultFailure(res['message']));
        } else {
          return Left(GlobalFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> UpdateOrder() async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.POST,
          path: AppApi.UpdateOrder(orderId!),
          body: {},
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          log(res.toString());
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);

          return Left(ResultFailure(res['message']));
        } else {
          return Left(GlobalFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  DialogDeleteOrUpdateOrder(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                      },
                      child: Icon(
                        Icons.close,
                        color: kBaseThirdyColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(15),
                        Row(
                          children: [
                            CheckBoxCustom(
                                check: cartController.cash,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      // cartController
                                      //     .changePaymentMethod('cash');
                                    },
                                  );
                                }),
                            Gap(15),
                            Text("الغاء الطلب كلياً"),
                          ],
                        ),
                        Gap(8),
                        Row(
                          children: [
                            CheckBoxCustom(
                              check: cartController.pos,
                              onChanged: (value) {
                                setState(
                                  () {
                                    // cartController.changePaymentMethod("pos");
                                  },
                                );
                              },
                            ),
                            Gap(15),
                            Text("إعادة الطلب مرة أخرى من مندوب آخر"),
                          ],
                        ),
                        Gap(8),
                        Row(
                          children: [
                            CheckBoxCustom(
                                check: false,
                                onChanged: (value) {
                                  // CustomDialog.Dialog(
                                  //     context,
                                  //     title:
                                  //         "يرجى شحن المحفظة");
                                }),
                            MaxGap(15),
                            Text(
                              "جدولة استلام الطلب",
                            ),
                          ],
                        ),
                        Gap(8),
                        Row(
                          children: [
                            CheckBoxCustom(
                              check: cartController.credit,
                              onChanged: (value) {
                                setState(
                                  () {
                                    cartController
                                        .changePaymentMethod("credit");
                                  },
                                );
                              },
                            ),
                            Gap(15),
                            Text("تغيير عنوان التوصيل"),
                          ],
                        ),
                        Gap(35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    // CustomRoute.RoutePop(
                                    //     context);
                                    // cartController
                                    //     .getCurrentlocation();
                                    // CustomRoute.RouteTo(
                                    //     context,
                                    //     Destination());
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          "التالي",
                                          style: TextStyle(
                                              color: kBaseColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
}
