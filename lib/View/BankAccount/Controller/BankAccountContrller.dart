// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:gas_app/Constant/colors.dart';
import 'package:gas_app/Constant/styles.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/AccountBank.dart';
import 'package:gas_app/Model/Bank.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/Responsive.dart';
import 'package:gas_app/Services/Routes.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:gas_app/View/Widgets/TextInput/TextInputCustom.dart';
import 'package:http/http.dart' as http;

class BankAccountContrller with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  List<Bank> listbank = [];
  Future<Either<Failure, bool>> GetBanks(
    BuildContext context,
  ) async {
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetBanks,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          log(response.body.toString());
          var res = jsonDecode(response.body);
          for (var element in res) {
            listbank.add(Bank.fromJson(element));
          }
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          return Left(ResultFailure(res['message']));
        } else {
          return Left(GlobalFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  List<AccountBank> listaccountbank = [];
  Future<Either<Failure, bool>> GetCardBanks(
    BuildContext context,
  ) async {
    listaccountbank = [];
    notifyListeners();
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetCardBanks,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          log(response.body.toString());
          var res = jsonDecode(response.body);

          for (var element in res) {
            listaccountbank.add(AccountBank.fromJson(element));
          }
          notifyListeners();
          EasyLoading.dismiss();

          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          EasyLoading.dismiss();

          return Left(ResultFailure(res['message']));
        } else {
          EasyLoading.dismiss();

          return Left(GlobalFailure());
        }
      } else {
        EasyLoading.dismiss();

        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();

      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> AddCardBanks(
    BuildContext context,
  ) async {
    EasyLoading.show();

    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.AddCard,
            body: {
              'bank_id': id.toString(),
              'user_name': namecontroller.text,
              'card_num': cardnumcontroller.text,
            });
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          log(response.body.toString());
          CustomRoute.RoutePop(context);
          namecontroller.clear();
          cardnumcontroller.clear();
          id = null;
          GetCardBanks(context);
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          EasyLoading.dismiss();

          var res = jsonDecode(response.body);
          return Left(ResultFailure(res['message']));
        } else {
          EasyLoading.dismiss();

          return Left(GlobalFailure());
        }
      } else {
        EasyLoading.dismiss();

        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();

      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> DeleteCard(
    int id,
    BuildContext context,
  ) async {
    EasyLoading.show();

    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.DeleteCard(id),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          GetCardBanks(context);
          notifyListeners();
          return Right(true);
        } else if (response.statusCode == 404) {
          EasyLoading.dismiss();

          var res = jsonDecode(response.body);
          return Left(ResultFailure(res['message']));
        } else {
          EasyLoading.dismiss();

          return Left(GlobalFailure());
        }
      } else {
        EasyLoading.dismiss();

        return Left(ServerFailure());
      }
    } catch (e) {
      EasyLoading.dismiss();

      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  TextEditingController cardnumcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  int? id;
  ShowdialogAddAccount(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            insetPadding: EdgeInsets.all(15),
            elevation: 10,
            alignment: Alignment(0, -.4),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        CustomRoute.RoutePop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: kBaseThirdyColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("إضافة بطاقة جديدة"),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "اسم البنك",
                            ),
                            Gap(20),
                            Expanded(
                                child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                hint: Text("اختر بنك"),
                                isDense: true,
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  isDense: true,
                                  fillColor: kThirdryColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged: (value) {
                                  id = value!.id!;
                                },
                                items: listbank
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          "${e.name}",
                                          style: style15semibold,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ))
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "اسم صاحب الحساب",
                            ),
                            Gap(20),
                            Expanded(
                              child: TextInputCustom(
                                controller: namecontroller,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "رقم الايبان",
                            ),
                            Gap(20),
                            Expanded(
                              child: TextInputCustom(
                                helptext:
                                    "يجب ان يبدا بSA و يتكون من 14 خانة من الارقام",
                                controller: cardnumcontroller,
                              ),
                            ),
                          ],
                        ),
                        Gap(50),
                        GestureDetector(
                          onTap: () => AddCardBanks(context),
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
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "اضافة و رجوع",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: kBaseColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
