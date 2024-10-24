// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:gas_app/Model/Bank.dart';

class AccountBank {
  int? id;
  int? userId;
  int? bankId;
  String? createdAt;
  String? updatedAt;
  String? cardNum;
  String? userName;
  User? user;
  Bank? bank;

  AccountBank(
      {this.id,
      this.userId,
      this.bankId,
      this.createdAt,
      this.updatedAt,
      this.cardNum,
      this.userName,
      this.user,
      this.bank});

  AccountBank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankId = json['bank_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cardNum = json['card_num'];
    userName = json['user_name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
  }
}

class User {
  int? id;
  String? userName;
  String? phone;
  String? email;
  var emailVerifiedAt;
  var bankNum;
  var bankName;
  String? logo;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? accountStatus;
  var regionId;
  int? countryId;

  User(
      {this.id,
      this.userName,
      this.phone,
      this.email,
      this.emailVerifiedAt,
      this.bankNum,
      this.bankName,
      this.logo,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.accountStatus,
      this.regionId,
      this.countryId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    bankNum = json['bank_num'];
    bankName = json['bank_name'];
    logo = json['logo'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accountStatus = json['account_status'];
    regionId = json['region_id'];
    countryId = json['country_id'];
  }
}
