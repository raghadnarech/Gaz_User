import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Destination/TrackMandob.dart';
import 'package:gas_app/View/Destination/TrackOrder.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Orders/Controller/OrderController.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;

class TrackOrderController with ChangeNotifier {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  PusherChannelsFlutter pusherlocation = PusherChannelsFlutter.getInstance();

  Timer? _timer;
  static NetworkClient client = NetworkClient(http.Client());

  void disposePusherChannel(
      PusherChannelsFlutter pusherInstance, String channelName) {
    pusherInstance.unsubscribe(channelName: channelName);
    pusherInstance.disconnect();
  }

  void diposestate() {
    disposePusherChannel(pusher, 'order.$orderId');
    disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
    stopTracking();
  }

  void startTrackingOrder() {
    _timer?.cancel();
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
  }

  int? orderId;
  int? mandobid;
  void initState(int value, BuildContext context) {
    orderId = value;
    startTrackingOrder();
    initializePusher(context);
  }

  void initStateMandobLocation(int value, BuildContext context) {
    mandobid = value;
    initializePusherMandobLocation(context);
    initializePusher(context);
  }

  void stopTracking() {
    _timer?.cancel();
  }

  String? status = 'تم تسليم الطلب للمندوب وجاري الاتجاه للموقع';
  Future<void> initializePusher(BuildContext context) async {
    try {
      await pusher.init(
        apiKey: 'fe3f88f1777344c1362a',
        cluster: 'ap2',
        authEndpoint: "https://mayadeen-md.com/gaz/public/broadcasting/auth",
        onAuthorizer: (String channelName, String socketId, options) async {
          log("onAuthorizer");
          log("Channel Name: $channelName");
          log("Socket ID: $socketId");
          log("Options: ${options.toString()}");
        },
        onConnectionStateChange: (currentState, previousState) {
          log("Connection state changed from $previousState to $currentState");
        },
        onEvent: (event) async {
          log("Event received: ${event.data}");
          if (event.data != null && event.data.isNotEmpty) {
            var data = jsonDecode(event.data);
            if (data['invoices'] != null) {
              if (data['invoices'][0]['mandob_id'] != null &&
                  data['invoices'][0]['mandob_id'] != '') {
                stopTracking();
                status = 'تم تسليم الطلب للمندوب وجاري الاتجاه للموقع';
                CustomRoute.RouteReplacementTo(
                    context,
                    ChangeNotifierProvider(
                      create: (context) => OrderController(),
                      builder: (context, child) => TrackMandob(
                        mandobid: data['invoices'][0]['mandob_id'],
                        name: data['invoices'][0]['mandob']['user']
                            ['user_name'],
                        phone: data['invoices'][0]['mandob']['user']['phone'],
                        total_with_fees:
                            data['invoices'][0]['total_with_fees'].toString(),
                      ),
                    ));
                // disposePusherChannel(pusher, 'order.$orderId');
                disposePusherChannel(pusher, 'mandob-location.$mandobid');
              }
            }
            if (data['status'] == 'canceled') {
              final HomePageController homePageController =
                  Provider.of<HomePageController>(context, listen: false);
              homePageController.markers.clear();
              CustomRoute.RouteReplacementTo(
                  context,
                  TrackOrder(
                    id: int.parse(data['orderId']),
                  ));
              // disposePusherChannel(pusher, 'order.$orderId');
              disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
            }
            if (data['status'] == 'Delivaring') {
              status = "الطلب في طريقه اليك";
              notifyListeners();
              // CustomRoute.RouteReplacementTo(
              //     context,
              //     TrackOrder(
              //       id: int.parse(data['orderId']),
              //     ));
              // disposePusherChannel(pusher, 'order.$orderId');
              // disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
            }
          }
        },
        onError: (message, code, error) {
          log("Error: $message, Code: $code, Error: $error");
        },
      );
      await pusher.subscribe(
        channelName: 'order.$orderId',
        onEvent: (event) {
          log("Event received in subscribe: ${event.data}");
          if (event.data != null && event.data.isNotEmpty) {
            var data = jsonDecode(event.data);
            if (data['invoices'] != null) {
              if (data['invoices'][0]['mandob_id'] != null &&
                  data['invoices'][0]['mandob_id'] != '') {
                // disposePusherChannel(pusher, 'order.$orderId');
                disposePusherChannel(
                    pusherlocation, 'mandob-location.$mandobid');
                CustomRoute.RouteReplacementTo(
                    context,
                    ChangeNotifierProvider(
                      create: (context) => OrderController(),
                      builder: (context, child) => TrackMandob(
                        mandobid: data['invoices'][0]['mandob_id'],
                        name: data['invoices'][0]['mandob']['user']
                            ['user_name'],
                        phone: data['invoices'][0]['mandob']['user']['phone'],
                        total_with_fees:
                            data['invoices'][0]['total_with_fees'].toString(),
                      ),
                    ));
              }
            }
            if (data['status'] == 'canceled') {
              final HomePageController homePageController =
                  Provider.of<HomePageController>(context, listen: false);
              homePageController.markers.clear();
              CustomRoute.RouteReplacementTo(
                  context,
                  TrackOrder(
                    id: int.parse(data['orderId']),
                  ));
              // disposePusherChannel(pusher, 'order.$orderId');
              disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
            }
            if (data['status'] == 'Delivaring') {
              status = "الطلب في طريقه اليك";
              notifyListeners();
              // CustomRoute.RouteReplacementTo(
              //     context,
              //     TrackOrder(
              //       id: int.parse(data['orderId']),
              //     ));
              // disposePusherChannel(pusher, 'order.$orderId');
              // disposePusherChannel(pusherlocation, 'mandob-location.$mandobid');
            }
          }
        },
      );
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> initializePusherMandobLocation(BuildContext context) async {
    try {
      await pusherlocation.init(
        apiKey: 'fe3f88f1777344c1362a',
        cluster: 'ap2',
        authEndpoint: "https://mayadeen-md.com/gaz/public/broadcasting/auth",
        onAuthorizer: (String channelName, String socketId, options) async {
          log("onAuthorizer");
          log("Channel Name: $channelName");
          log("Socket ID: $socketId");
          log("Options: ${options.toString()}");
        },
        onConnectionStateChange: (currentState, previousState) {
          log("Connection state changed from $previousState to $currentState");
        },
        onEvent: (event) async {
          log("Event received: ${event.data}");
          if (event.data != null && event.data.isNotEmpty) {
            final HomePageController homePageController =
                Provider.of<HomePageController>(context, listen: false);
            homePageController.changemarkers(event);
          }
        },
        onError: (message, code, error) {
          log("Error: $message, Code: $code, Error: $error");
        },
      );
      await pusherlocation.subscribe(
        channelName: 'mandob-location.$mandobid',
        onEvent: (event) {
          log("Event received: ${event.data}");
          if (event.data != null && event.data.isNotEmpty) {
            final HomePageController homePageController =
                Provider.of<HomePageController>(context, listen: false);
            homePageController.changemarkers(event);
          }
        },
      );
      await pusherlocation.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }
}
