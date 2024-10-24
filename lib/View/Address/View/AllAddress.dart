import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/View/Address/Controller/AddAddressController.dart';
import 'package:gas_app/View/Address/Controller/AllAddressController.dart';
import 'package:gas_app/View/Address/View/AddAddress.dart';
import 'package:provider/provider.dart';

class AllAddress extends StatelessWidget {
  const AllAddress({super.key});

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
        title: Text("إدارة العناوين"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "العناوين الخاصة بك",
                  style: style18semibold,
                ),
                GestureDetector(
                  onTap: () => CustomRoute.RouteTo(
                    context,
                    ChangeNotifierProvider(
                      create: (context) => AddAddressController()
                        ..GetAllRegions()
                        ..oninit(),
                      lazy: true,
                      builder: (context, child) => AddAddress(),
                    ),
                  ),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: kSecendryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.add,
                      color: kBaseColor,
                    ),
                  ),
                )
              ],
            ),
            Gap(25),
            Consumer<AllAddressController>(
              builder: (context, controller, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.addressList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: kSecendryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.addressList[index].name}",
                                  ),
                                  Text(
                                    "${controller.addressList[index].kind}",
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => controller.DeleteAddress(
                                        context,
                                        controller.addressList[index].id),
                                    child: CircleAvatar(
                                      foregroundColor: kBaseColor,
                                      backgroundColor: Color(0xffDD0B0B),
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  Text(
                                    "حذف",
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xffDD0B0B)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
