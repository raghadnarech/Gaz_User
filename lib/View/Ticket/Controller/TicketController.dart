// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gas_app/Constant/url.dart';
import 'package:gas_app/Model/Message.dart';
import 'package:gas_app/Model/Ticket.dart';
import 'package:gas_app/Services/Failure.dart';
import 'package:gas_app/Services/NetworkClient.dart';
import 'package:gas_app/Services/network_connection.dart';
import 'package:http/http.dart' as http;

class TicketController with ChangeNotifier {
  var message = TextEditingController();
  late int reciveid;
  List<Ticket> listticket = [];
  int? ticketid;
  NetworkClient client = NetworkClient(http.Client());
  oninit(int id) {
    reciveid = id;
  }

  List<Message>? messages = [];

  Future<Either<Failure, bool>> SendMessage(BuildContext context) async {
    // EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.SendMessage(ticketid!),
            body: {
              'text': message.text,
            });
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          // EasyLoading.dismiss();
          // EasyLoading.showSuccess('تم ارسال الرسالة بنجاح');
          message.clear();
          GetMessageTicket(context, ticketid!);
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          // EasyLoading.dismiss();
          // EasyLoading.showError(ResultFailure(res['message']).message);
          return Left(ResultFailure(res['message']));
        } else {
          // EasyLoading.dismiss();
          // EasyLoading.dismiss();
          // EasyLoading.showError(GlobalFailure().message);
          return Left(GlobalFailure());
        }
      } else {
        // EasyLoading.dismiss();
        // EasyLoading.showError(ServerFailure().message);
        return Left(ServerFailure());
      }
    } catch (e) {
      // EasyLoading.dismiss();
      // EasyLoading.showError(GlobalFailure().message);
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> GetAllTicket(BuildContext context) async {
    // EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetTickets,
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          res.forEach((v) {
            listticket.add(Ticket.fromJson(v));
          });
          notifyListeners();

          for (var element in listticket) {
            if (element.receiverId == reciveid) {
              ticketid = element.id;
              GetMessageTicket(context, element.id!);
              return Right(true);
            }
          }
          PostTicket(context);
          // EasyLoading.dismiss();
          // EasyLoading.showSuccess('تم ارسال الرسالة بنجاح');
          message.clear();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          // EasyLoading.dismiss();
          // EasyLoading.showError(ResultFailure(res['message']).message);
          return Left(ResultFailure(res['message']));
        } else {
          // EasyLoading.dismiss();
          // EasyLoading.dismiss();
          // EasyLoading.showError(GlobalFailure().message);
          return Left(GlobalFailure());
        }
      } else {
        // EasyLoading.dismiss();
        // EasyLoading.showError(ServerFailure().message);
        return Left(ServerFailure());
      }
    } catch (e) {
      // EasyLoading.dismiss();
      // EasyLoading.showError(GlobalFailure().message);
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> GetMessageTicket(
      BuildContext context, int ticketid) async {
    messages!.clear();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
          requestType: RequestType.GET,
          path: AppApi.GetMyTickets(ticketid),
        );
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          res['messages'].forEach((a) {
            messages!.add(Message.fromJson(a));
          });
          // Sort messages by `createdAt`
          messages!.sort((a, b) => DateTime.parse(a.createdAt!)
              .compareTo(DateTime.parse(b.createdAt!)));
          notifyListeners();
          message.clear();
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

  Future<Either<Failure, bool>> PostTicket(BuildContext context) async {
    // EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        final response = await client.request(
            requestType: RequestType.POST,
            path: AppApi.PostTicket(reciveid),
            body: {
              'text': message.text,
            });
        log(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          GetAllTicket(context);
          // EasyLoading.dismiss();
          // EasyLoading.showSuccess('تم ارسال الرسالة بنجاح');
          message.clear();
          return Right(true);
        } else if (response.statusCode == 404) {
          var res = jsonDecode(response.body);
          // EasyLoading.dismiss();
          // EasyLoading.showError(ResultFailure(res['message']).message);
          return Left(ResultFailure(res['message']));
        } else {
          // EasyLoading.dismiss();
          // EasyLoading.dismiss();
          // EasyLoading.showError(GlobalFailure().message);
          return Left(GlobalFailure());
        }
      } else {
        // EasyLoading.dismiss();
        // EasyLoading.showError(ServerFailure().message);
        return Left(ServerFailure());
      }
    } catch (e) {
      // EasyLoading.dismiss();
      // EasyLoading.showError(GlobalFailure().message);
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
