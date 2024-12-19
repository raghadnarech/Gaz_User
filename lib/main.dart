import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Controller/CartController.dart';
import 'package:gas_app/Controller/ListProvider.dart';
import 'package:gas_app/Controller/PointSystemController.dart';
import 'package:gas_app/View/Destination/Controller/TrackOrderController.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/Splash/Controller/SplashController.dart';
import 'package:gas_app/View/Splash/Splash.dart';
import 'package:gas_app/l10n/app_localizations.dart';
import 'package:gas_app/l10n/l10n.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: listproviders,
      child: const MyApp(),
    ),
  );
}

HomePageController homePageController = HomePageController();
CartController cartController = CartController();
TrackOrderController trackOrderController = TrackOrderController();
PointSystemController pointSystemController = PointSystemController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gas App',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: kBaseColor,
        scaffoldBackgroundColor: kBaseColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => kPrimaryColor,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor,
        ),
        useMaterial3: false,
        colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecendryColor,
        ).copyWith(background: kBaseColor),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: Locale('ar'),
      home: ChangeNotifierProvider<SplashController>(
        create: (context) => SplashController()..whenIslogin(context),
        lazy: true,
        builder: (context, child) => Splash(),
      ),
      builder: (context, child) {
        EasyLoading.instance
          ..displayDuration = const Duration(seconds: 3)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 45.0
          ..radius = 15.0
          ..maskType = EasyLoadingMaskType.black
          ..progressColor = kPrimaryColor
          ..backgroundColor = kBaseColor
          ..indicatorColor = kPrimaryColor
          ..textColor = kPrimaryColor
          ..maskColor = Colors.black
          ..userInteractions = false
          ..animationStyle = EasyLoadingAnimationStyle.opacity
          ..dismissOnTap = false;
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
