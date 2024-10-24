// // ignore_for_file: use_key_in_widget_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:gap/gap.dart';
// import 'package:gas_app/Constant/colors.dart';
// import 'package:gas_app/Constant/styles.dart';
// import 'package:gas_app/Services/Responsive.dart';
// import 'package:gas_app/Services/Routes.dart';
// import 'package:gas_app/View/Cart/CartForm.dart';
// import 'package:gas_app/View/ProductPage/ProductsPageGaz.dart';
// import 'package:gas_app/View/SelectSubSupplier/Controller/SelectSubSupplierController.dart';
// import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
// import 'package:gas_app/View/Widgets/CheckBox/CheckBoxCustom.dart';
// import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
// import 'package:gas_app/main.dart';
// import 'package:provider/provider.dart';

// class SelectSubSupplierGas extends StatefulWidget {
//   @override
//   State<SelectSubSupplierGas> createState() => _SelectSubSupplierGasState();
// }

// class _SelectSubSupplierGasState extends State<SelectSubSupplierGas> {
//   bool nearestrepresentative = true;
//   bool selectedrepresentative = false;
//   bool representativefromlist = false;
//   int? supplierid;
//   TextEditingController codemandob = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBarCustom(context, 'اختر المورد الفرعي'),
//       body: Center(
//           child: SizedBox(
//         width: Responsive.getWidth(context) * .9,
//         child: Consumer<SelectSubSupplierController>(
//           builder: (context, controller, child) => ListView(
//             children: [
//               Gap(30),
//               Row(
//                 children: [
//                   CheckBoxCustom(
//                     check: nearestrepresentative,
//                     onChanged: (value) {
//                       setState(() {
//                         nearestrepresentative = value!;
//                         selectedrepresentative = false;
//                         representativefromlist = false;
//                         codemandob.clear();
//                       });
//                     },
//                   ),
//                   Gap(15),
//                   Text(
//                     "اختيار اقرب مندوب معين ضمن المنطقة",
//                     style: style15semibold,
//                   )
//                 ],
//               ),
//               Gap(20),
//               Row(
//                 children: [
//                   CheckBoxCustom(
//                     check: selectedrepresentative,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedrepresentative = value!;
//                         nearestrepresentative = false;
//                         representativefromlist = false;
//                       });
//                     },
//                   ),
//                   Gap(15),
//                   Text(
//                     "ارسال الطلب الى مندوب معين",
//                     style: style15semibold,
//                   )
//                 ],
//               ),
//               Gap(20),
//               Visibility(
//                 visible: selectedrepresentative,
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "كود المندوب",
//                           style: style12semibold,
//                         ),
//                         Gap(20),
//                         Expanded(
//                           child: TextInputCustom(
//                             controller: codemandob,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Gap(25),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   CheckBoxCustom(
//                     check: representativefromlist,
//                     onChanged: (value) {
//                       setState(() {
//                         representativefromlist = value!;
//                         nearestrepresentative = false;
//                         selectedrepresentative = false;
//                         codemandob.clear();
//                       });
//                     },
//                   ),
//                   Gap(15),
//                   Text(
//                     "اختيار مورد معين ضمن المنطقة",
//                     style: style15semibold,
//                   )
//                 ],
//               ),
//               Gap(20),
//               Visibility(
//                   visible: representativefromlist,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "اختر مورد معين",
//                             style: style12semibold,
//                           ),
//                           Gap(20),
//                           Expanded(
//                               child: DropdownButtonHideUnderline(
//                             child: DropdownButtonFormField(
//                               isDense: true,
//                               icon: Icon(Icons.keyboard_arrow_down_rounded),
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.all(10),
//                                 isDense: true,
//                                 fillColor: kThirdryColor,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                               onChanged: (value) {
//                                 cartController.selectSupplier(value!);
//                                 setState(
//                                   () {
//                                     supplierid = value.id;
//                                   },
//                                 );
//                               },
//                               items: controller.SupplierList.map(
//                                 (e) => DropdownMenuItem(
//                                   value: e,
//                                   child: Text(
//                                     "${e.supplierName}",
//                                     style: style15semibold,
//                                   ),
//                                 ),
//                               ).toList(),
//                             ),
//                           ))
//                         ],
//                       ),
//                       Gap(25),
//                     ],
//                   )),
//               Gap(170),
//               GestureDetector(
//                 onTap: () async {
//                   EasyLoading.show(status: 'يتم جلب المنتجات');
//                   try {
//                     var result = await controller.GetProductGaz(
//                         context,
//                         nearestrepresentative
//                             ? "nearest_man"
//                             : representativefromlist
//                                 ? "supplier_id"
//                                 : "code",
//                         nearestrepresentative
//                             ? 1
//                             : representativefromlist
//                                 ? supplierid!
//                                 : codemandob.text);
//                     result.fold(
//                       (l) {
//                         EasyLoading.showError(l.message);
//                         EasyLoading.dismiss();
//                       },
//                       (r) {
//                         EasyLoading.dismiss();

//                         CustomRoute.RouteTo(
//                             context,
//                             CartForm(
//                                 widget: ProductsPageGaz(
//                               name: "غاز",
//                               listproduct: controller.productList,
//                               code:
//                                   selectedrepresentative ? codemandob.text : '',
//                             )));
//                       },
//                     );
//                   } catch (e) {
//                     EasyLoading.showToast(e.toString());
//                     EasyLoading.dismiss();
//                   }
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Container(
//                     height: 43,
//                     width: Responsive.getWidth(context) * .8,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             offset: Offset(0, 5),
//                             color: kBaseThirdyColor.withAlpha(75),
//                             blurRadius: 7)
//                       ],
//                       borderRadius: BorderRadius.circular(20),
//                       color: Color(0xff445461),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "متابعة",
//                         style: TextStyle(
//                             fontSize: 15,
//                             color: kBaseColor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       )),
//     ));
//   }
// }
