import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/View/BankAccount/Controller/BankAccountContrller.dart';
import 'package:provider/provider.dart';

class BankAccount extends StatelessWidget {
  const BankAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff445461),
        centerTitle: true,
        title: Text("بياناتي المصرفية"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<BankAccountContrller>(
          builder: (context, controller, child) => GestureDetector(
            onTap: () => controller.ShowdialogAddAccount(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: 43,
                width: Responsive.getWidth(context) * .8,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: kBaseThirdyColor.withAlpha(75),
                        blurRadius: 7)
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff445461),
                ),
                child: Center(
                  child: Text(
                    "إضافة بطاقة جديدة",
                    style: TextStyle(
                        fontSize: 15,
                        color: kBaseColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<BankAccountContrller>(
        builder: (context, controller, child) => ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.listaccountbank.length,
          itemBuilder: (context, index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.square,
                        color: Color(0xff960D0D),
                      ),
                      Gap(10),
                      Text("اسم البنك"),
                      Gap(10),
                      Text("${controller.listaccountbank[index].bank!.name}"),
                    ],
                  ),
                  Wrap(
                    spacing: 10,
                    children: [
                      Text("اسم صاحب الحساب حسب البطاقة"),
                      Text("${controller.listaccountbank[index].userName}"),
                    ],
                  ),
                  Row(
                    children: [
                      Gap(10),
                      Text("رقم الايبان"),
                      Gap(10),
                      Text("${controller.listaccountbank[index].cardNum}"),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => controller.DeleteCard(
                        controller.listaccountbank[index].id!, context),
                    child: Icon(
                      Icons.delete,
                      size: 25,
                      color: kFourthColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
