// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/View/Cart/CartPage.dart';
import 'package:gas_app/View/Orders/OrdersPage.dart';
import 'package:gas_app/View/Profile/ProfilePage.dart';
import 'package:gas_app/View/ServicePage/View/ServicesPage.dart';

class HomeNavigation extends StatefulWidget {
  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

List pages = [OrdersPage(), CartPage(), ServicesPage(), ProfilePage()];

class _HomeNavigationState extends State<HomeNavigation> {
  int page = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[page],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                page = value;
              });
            },
            selectedItemColor: kFourthColor,
            selectedLabelStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: kFourthColor),
            showUnselectedLabels: true,
            unselectedItemColor: kSecendryColor,
            unselectedLabelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kSecendryColor),
            currentIndex: page,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  label: "الطلبات",
                  icon: Icon(
                    CupertinoIcons.doc_text_fill,
                    size: 20,
                  )),
              BottomNavigationBarItem(
                  label: "السلة",
                  icon: Icon(
                    CupertinoIcons.cart_fill,
                    size: 20,
                  )),
              BottomNavigationBarItem(
                  label: "الصفحة الرئيسية",
                  icon: Icon(
                    Icons.home_filled,
                    size: 20,
                  )),
              BottomNavigationBarItem(
                  label: "البروفايل",
                  icon: Icon(
                    CupertinoIcons.profile_circled,
                    size: 20,
                  )),
            ]),
      ),
    );
  }
}
