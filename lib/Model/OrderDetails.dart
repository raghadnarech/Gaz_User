// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

class OrderDetails {
  Order? order;
  FeesOriginalPrice? feesOriginalPrice;

  OrderDetails({
    this.order,
    this.feesOriginalPrice,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    order = json['data'] != null ? Order.fromJson(json['data']) : null;
    feesOriginalPrice = json['fees_original_price'] != null
        ? FeesOriginalPrice.fromJson(json['fees_original_price'])
        : null;
  }
}

class Order {
  int? id;
  int? userId;
  var mandobId;
  String? paymentKind;
  String? status;
  String? toDoor;
  String? toHouse;
  String? isDiscount;
  var dateWanted;
  var total;
  String? createdAt;
  String? updatedAt;
  String? number;
  var totalWithFees;
  int? addressId;
  int? isOnTime;
  String? cancelableUntil;
  var cancelReason;
  var floor;
  var isElevetor;
  List<Invoices>? invoices;
  var mandob;
  Address? address;

  Order(
      {this.id,
      this.userId,
      this.mandobId,
      this.paymentKind,
      this.status,
      this.toDoor,
      this.toHouse,
      this.isDiscount,
      this.dateWanted,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.number,
      this.totalWithFees,
      this.addressId,
      this.isOnTime,
      this.cancelableUntil,
      this.cancelReason,
      this.floor,
      this.isElevetor,
      this.invoices,
      this.mandob,
      this.address});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mandobId = json['mandob_id'];
    paymentKind = json['payment_kind'];
    status = json['status'];
    toDoor = json['toDoor'];
    toHouse = json['toHouse'];
    isDiscount = json['isDiscount'];
    dateWanted = json['date_wanted'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    number = json['number'];
    totalWithFees = json['total_with_fees'];
    addressId = json['address_id'];
    isOnTime = json['isOnTime'];
    cancelableUntil = json['cancelable_until'];
    cancelReason = json['cancel_reason'];
    floor = json['floor'];
    isElevetor = json['isElevetor'];
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(Invoices.fromJson(v));
      });
    }
    mandob = json['mandob'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }
}

class Invoices {
  int? id;
  int? orderId;
  var productId;
  int? supplierId;
  var code;
  var managerId;
  String? status;
  var price;
  String? createdAt;
  String? updatedAt;
  int? serviceId;
  var quantity;
  int? priceWithFees;
  int? nearestMan;
  List<ProductOrder>? products;
  String? number;
  int? isCanceled;
  int? nightFees;
  int? appFees;

  Invoices(
      {this.id,
      this.orderId,
      this.productId,
      this.supplierId,
      this.code,
      this.managerId,
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
      this.isCanceled,
      this.nightFees,
      this.appFees});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    supplierId = json['supplier_id'];
    code = json['code'];
    managerId = json['manager_id'];
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
    }
    number = json['number'];
    isCanceled = json['isCanceled'];
    nightFees = json['night_fees'];
    appFees = json['app_fees'];
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

class Address {
  int? id;
  int? userId;
  String? name;
  double? lang;
  double? lat;
  String? kind;
  String? floor;
  var isElevetor;
  String? createdAt;
  String? updatedAt;
  var regionId;
  int? distrectId;

  Address(
      {this.id,
      this.userId,
      this.name,
      this.lang,
      this.lat,
      this.kind,
      this.floor,
      this.isElevetor,
      this.createdAt,
      this.updatedAt,
      this.regionId,
      this.distrectId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    lang = json['lang'];
    lat = json['lat'];
    kind = json['kind'];
    floor = json['floor'];
    isElevetor = json['isElevetor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    regionId = json['region_id'];
    distrectId = json['distrect_id'];
  }
}

class FeesOriginalPrice {
  int? id;
  int? delivaryFees;
  int? outTimeFees;
  String? startTime;
  String? endTime;
  int? floorFee;
  String? createdAt;
  String? updatedAt;
  int? appFees;

  FeesOriginalPrice(
      {this.id,
      this.delivaryFees,
      this.outTimeFees,
      this.startTime,
      this.endTime,
      this.floorFee,
      this.createdAt,
      this.updatedAt,
      this.appFees});

  FeesOriginalPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    delivaryFees = json['delivary_fees'];
    outTimeFees = json['out_time_fees'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    floorFee = json['floor_fee'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appFees = json['app_fees'];
  }
}
