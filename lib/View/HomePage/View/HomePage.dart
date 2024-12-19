// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:gas_app/Constant/colors.dart';
// import 'package:gas_app/Constant/styles.dart';
// import 'package:gas_app/Controller/CartController.dart';
// import 'package:gas_app/Model/Address.dart';
// import 'package:gas_app/Services/CustomDialog.dart';
// import 'package:gas_app/Services/Responsive.dart';
// import 'package:gas_app/Services/Routes.dart';
// import 'package:gas_app/View/Address/View/AddAddress.dart';
// import 'package:gas_app/View/Address/Controller/AddAddressController.dart';
// import 'package:gas_app/View/Cart/CartForm.dart';
// import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
// import 'package:gas_app/View/ServicePage/Controller/ServicesPageController.dart';
// import 'package:gas_app/View/ServicePage/View/ServicesPage.dart';
// import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
// import 'package:gas_app/main.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     cartController = Provider.of<CartController>(context);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBarCustom(context, 'عنوان الطلب'),
//         body: Center(
//           child: SizedBox(
//             width: Responsive.getWidth(context) * .9,
//             child: Consumer<HomePageController>(
//               builder: (context, controller, child) => ListView(
//                 children: [
//                   Gap(30),
//                   Text(
//                     "اختر العنوان",
//                     style: style15semibold,
//                   ),
//                   Gap(15),
//                   controller.isloadingaddress
//                       ? Shimmer.fromColors(
//                           baseColor:
//                               Color.fromARGB(255, 229, 229, 229).withAlpha(150),
//                           highlightColor: kBaseColor,
//                           child: Container(
//                             color: kBaseColor,
//                             height: 45,
//                             width: double.infinity,
//                             child: Text(''),
//                           ),
//                         )
//                       : DropdownButtonHideUnderline(
//                           child: DropdownButtonFormField<Address>(
//                             isDense: true,
//                             hint: Text(
//                               cartController.address.name == null
//                                   ? "اختر عنوان"
//                                   : cartController.address.name!,
//                               style: style12semibold,
//                             ),
//                             icon: Icon(Icons.keyboard_arrow_down_rounded),
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.all(10),
//                               isDense: true,
//                               fillColor: kThirdryColor,
//                               filled: true,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             onChanged: (Address? address) {
//                               if (address != null) {
//                                 cartController.selectAddress(address);
//                                 log('تم تحديد العنوان: $address');
//                               }
//                             },
//                             items: controller.addressList.map((address) {
//                               return DropdownMenuItem<Address>(
//                                 value: address,
//                                 child: Text(
//                                   '${address.name}',
//                                   style: style15semibold,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                   Gap(20),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "اضف عنوان اخر",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Gap(60),
//                       GestureDetector(
//                         onTap: () => CustomRoute.RouteTo(
//                           context,
//                           ChangeNotifierProvider(
//                             create: (context) => AddAddressController()
//                               ..GetAllRegions()
//                               ..oninit(),
//                             lazy: true,
//                             builder: (context, child) => AddAddress(),
//                           ),
//                         ),
//                         child: Container(
//                           width: 35,
//                           height: 35,
//                           decoration: BoxDecoration(
//                               color: kSecendryColor,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Icon(
//                             Icons.add,
//                             color: kBaseColor,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Gap(170),
//                   GestureDetector(
//                     onTap: () {
//                       if (cartController.address.name != null) {
//                         CustomRoute.RouteTo(
//                             context,
//                             ChangeNotifierProvider(
//                                 create: (context) => ServicesPageController()
//                                   ..getAllServices(context),
//                                 child: CartForm(
//                                   widget: ServicesPage(),
//                                 )));
//                       } else {
//                         CustomDialog.Dialog(context,
//                             title: "لا يمكنك المتابعة قبل اختيار عنوان الطلب");
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25),
//                       child: Container(
//                         height: 43,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               kPrimaryColor,
//                               kBaseThirdyColor,
//                             ],
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "متابعة",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: kBaseColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ), 
//     );
//   }
// }
