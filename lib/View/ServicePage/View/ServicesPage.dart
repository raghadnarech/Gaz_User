import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/HomePage/Controller/HomePageController.dart';
import 'package:gas_app/View/ServicePage/Widget/CardService.dart';
import 'package:gas_app/View/Widgets/AppBar/AppBarCustom.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBarCustom(context, 'اختر نوع الخدمة'),
      body: Center(
        child: SizedBox(
          width: Responsive.getWidth(context) * .8,
          child: Consumer<HomePageController>(
            builder: (context, controller, child) =>
                ListView(physics: BouncingScrollPhysics(), children: [
              Gap(60),
              controller.isloadinggetallservices
                  ? GridView.builder(
                      itemCount: 6,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 45,
                        crossAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor:
                            Color.fromARGB(255, 229, 229, 229).withAlpha(150),
                        highlightColor: kBaseColor.withAlpha(100),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kBaseColor,
                          ),
                          width: double.infinity,
                          child: Text(''),
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: 1,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 45,
                        crossAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) => CardService(
                        index: index,
                        services: controller.ServicesList[index],
                      ),
                    )
            ]),
          ),
        ),
      ),
    ));
  }
}


                  //
                  // Center(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //             offset: Offset(0, 0),
                  //             color: kBaseThirdyColor.withAlpha(50),
                  //             blurRadius: 10)
                  //       ],
                  //       color: kThirdryColor,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "قريباً",
                  //         style: style18semibold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Center(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //             offset: Offset(0, 0),
                  //             color: kBaseThirdyColor.withAlpha(50),
                  //             blurRadius: 10)
                  //       ],
                  //       color: kSecendryColor,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "قريباً",
                  //         style: style18semibold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Center(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //             offset: Offset(0, 0),
                  //             color: kBaseThirdyColor.withAlpha(50),
                  //             blurRadius: 10)
                  //       ],
                  //       color: kSecendryColor,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "قريباً",
                  //         style: style18semibold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Center(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //             offset: Offset(0, 0),
                  //             color: kBaseThirdyColor.withAlpha(50),
                  //             blurRadius: 10)
                  //       ],
                  //       color: kThirdryColor,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "قريباً",
                  //         style: style18semibold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
               