import 'package:flutter/material.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';

import '../../../Services/Responsive.dart';

AppBar AppBarCustom(BuildContext context, String? text) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 131,
    flexibleSpace: Stack(
      children: [
        Positioned(
            top: 0,
            width: Responsive.getWidth(context),
            height: 95,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                width: Responsive.getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage('assets/images/appbar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )),
        Positioned(
            bottom: 0,
            width: Responsive.getWidth(context),
            // height: 60,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 43,
                width: Responsive.getWidth(context) * .9,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 7,
                        color: kBaseThirdyColor.withAlpha(150),
                      )
                    ],
                    color: kThirdryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  text!,
                  style: style15semibold,
                )),
              ),
            )),
      ],
    ),
    backgroundColor: Colors.transparent,
  );
}

// AppBar AppBarCustomMainCategories(BuildContext context, String? text) {
//   return AppBar(
//     elevation: 0,
//     toolbarHeight: 131,
//     bottom: TabBar(
//                     isScrollable: true,
//                     tabs: controller.listcategory
//                         .map((e) => Text(e.name!))
//                         .toList(),
//                   ),
//     flexibleSpace: Stack(
//       children: [
//         Positioned(
//             top: 0,
//             width: Responsive.getWidth(context),
//             height: 95,
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//               child: Container(
//                 width: Responsive.getWidth(context),
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/appbar.png'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             )),
//         Positioned(
//             bottom: 0,
//             width: Responsive.getWidth(context),
//             // height: 60,
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: 43,
//                 width: Responsive.getWidth(context) * .9,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         offset: Offset(0, 0),
//                         blurRadius: 7,
//                         color: kBaseThirdyColor.withAlpha(150),
//                       )
//                     ],
//                     color: kThirdryColor,
//                     borderRadius: BorderRadius.circular(20)),
//                 child: Center(
//                     child: Text(
//                   text!,
//                   style: style15semibold,
//                 )),
//               ),
//             )),
//       ],
//     ),
//     backgroundColor: Colors.transparent,
//   );
// }

AppBar AppBarCustomPageDrawer(BuildContext context, String? text) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 140,
    flexibleSpace: Stack(
      children: [
        Positioned(
            top: 0,
            width: Responsive.getWidth(context),
            height: 125,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                width: Responsive.getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage('assets/images/appbar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )),
        Positioned(
            top: 50,
            width: Responsive.getWidth(context),
            // height: 60,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text!,
                style: TextStyle(
                    color: kBaseColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            )),
      ],
    ),
    backgroundColor: Colors.transparent,
  );
}

AppBar AuthAppBarCustom(BuildContext context, bool? islogin) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 131,
    flexibleSpace: Stack(
      children: [
        Positioned(
            top: 0,
            width: Responsive.getWidth(context),
            height: 95,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                width: Responsive.getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage('assets/images/appbar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )),
        Positioned(
            bottom: 0,
            width: Responsive.getWidth(context),
            // height: 60,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 43,
                width: Responsive.getWidth(context) * .9,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 7,
                        color: kBaseThirdyColor.withAlpha(150),
                      )
                    ],
                    color: kThirdryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: islogin! ? Colors.transparent : kFourthColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "انشاء حساب",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: islogin ? kBaseThirdyColor : kBaseColor),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: islogin ? kFourthColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: islogin ? kBaseColor : kBaseThirdyColor),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ],
    ),
    backgroundColor: Colors.transparent,
  );
}
