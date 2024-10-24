// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

class Orderes {
  int? id;
  int? userId;
  String? paymentKind;
  String? status;
  String? toDoor;
  String? toHouse;
  String? isDiscount;
  var isOnTime;
  var dateWanted;
  String? total;
  String? createdAt;
  String? updatedAt;
  String? number;
  var totalWithFees;
  int? addressId;
  Mandob? mandob;
  List<Invoices>? invoices;

  Orderes(
      {this.id,
      this.userId,
      this.paymentKind,
      this.status,
      this.toDoor,
      this.toHouse,
      this.isDiscount,
      this.dateWanted,
      this.isOnTime,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.number,
      this.totalWithFees,
      this.addressId,
      this.mandob,
      this.invoices});

  Orderes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentKind = json['payment_kind'];
    status = json['status'];
    toDoor = json['toDoor'];
    toHouse = json['toHouse'];
    isDiscount = json['isDiscount'];
    isOnTime = json['isOnTime'];
    dateWanted = json['date_wanted'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    number = json['number'];
    totalWithFees = json['total_with_fees'];
    addressId = json['address_id'];
    mandob = json['mandob'] != null ? Mandob.fromJson(json['mandob']) : null;
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(Invoices.fromJson(v));
      });
    }
  }
}

class Invoices {
  int? id;
  int? orderId;
  var productId;
  int? supplierId;
  var code;
  String? status;
  var price;
  String? createdAt;
  String? updatedAt;
  int? serviceId;
  var quantity;
  var priceWithFees;
  int? nearestMan;
  List<ProductOrder>? products;
  String? number;
  int? isCanceled;

  Invoices(
      {this.id,
      this.orderId,
      this.productId,
      this.supplierId,
      this.code,
      this.status,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.serviceId,
      this.quantity,
      this.priceWithFees,
      this.nearestMan,
      this.products,
      this.number,
      this.isCanceled});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    supplierId = json['supplier_id'];
    code = json['code'];
    status = json['status'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceId = json['service_id'];
    quantity = json['quantity'];
    priceWithFees = json['price_with_fees'];
    nearestMan = json['nearest_man'];
    if (json['product'].toString() != '[]') {
      dynamic data = jsonDecode(json['product']);
      products = data.map<ProductOrder>((item) {
        return ProductOrder.fromJson(item);
      }).toList();
      number = json['number'];
      isCanceled = json['isCanceled'];
    }
  }
}

class ProductOrder {
  String name;
  int quantity;
  double price;

  ProductOrder({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class Mandob {
  int? id;
  int? userId;
  var mandobManagerId;
  String? code;
  var personalImage;
  var carImageFront;
  var carImageBack;
  var licenceImage;
  var carLicence;
  var idImage;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  var lang;
  var lat;
  User? user;

  Mandob(
      {this.id,
      this.userId,
      this.mandobManagerId,
      this.code,
      this.personalImage,
      this.carImageFront,
      this.carImageBack,
      this.licenceImage,
      this.carLicence,
      this.idImage,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.lang,
      this.lat,
      this.user});

  Mandob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mandobManagerId = json['mandob_manager_id'];
    code = json['code'];
    personalImage = json['personal_image'];
    carImageFront = json['car_image_front'];
    carImageBack = json['car_image_back'];
    licenceImage = json['licence_image'];
    carLicence = json['car_licence'];
    idImage = json['id_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['isActive'];
    lang = json['lang'];
    lat = json['lat'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['user_id'] = this.userId;
  //   data['mandob_manager_id'] = this.mandobManagerId;
  //   data['code'] = this.code;
  //   data['personal_image'] = this.personalImage;
  //   data['car_image_front'] = this.carImageFront;
  //   data['car_image_back'] = this.carImageBack;
  //   data['licence_image'] = this.licenceImage;
  //   data['car_licence'] = this.carLicence;
  //   data['id_image'] = this.idImage;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['isActive'] = this.isActive;
  //   data['lang'] = this.lang;
  //   data['lat'] = this.lat;
  //   if (this.user != null) {
  //     data['user'] = this.user!.toJson();
  //   }
  //   return data;
  // }
}

class User {
  int? id;
  String? userName;
  String? phone;
  String? email;
  var emailVerifiedAt;
  String? bankNum;
  String? bankName;
  var logo;
  String? role;
  String? createdAt;
  String? updatedAt;

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
      this.updatedAt});

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
  }
}
