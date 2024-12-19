import 'package:gas_app/Controller/CartController.dart';
import 'package:gas_app/Controller/LanguageProvider.dart';
import 'package:gas_app/Controller/PointSystemController.dart';
import 'package:gas_app/View/Destination/Controller/TrackOrderController.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> listproviders = [
  ChangeNotifierProvider<LanguageProvider>(
    create: (context) => LanguageProvider(),
  ),
  ChangeNotifierProvider<CartController>(
    create: (context) => CartController()..getFeesValues(context),
  ),
  ChangeNotifierProvider<HomePageController>(
    create: (context) => HomePageController()
      ..getalladdress()
      ..GetMyCancelOrders()
      ..GetMyOrders('pending')
      ..GetProfile()
      ..getAllServices(),
  ),
  ChangeNotifierProvider<TrackOrderController>(
    create: (context) => TrackOrderController(),
  ),
  ChangeNotifierProvider<PointSystemController>(
    create: (context) => PointSystemController(),
  )
];
