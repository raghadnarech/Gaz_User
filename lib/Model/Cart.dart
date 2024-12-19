import 'package:gas_app/Model/CartProduct.dart';

class Cart {
  String? payment_kind;
  bool? toDoor;
  bool? toHouse;
  bool? isDiscount;
  String? date_wanted;
  int? address_id;
  int? haselevater = 1;
  int? selectfloor = 0;
  double? lat;
  double? long;
  List<CartProduct> listcartproduct;
  Cart({required this.listcartproduct});
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var cartProduct in listcartproduct) {
      totalPrice += (cartProduct.product!.price! * (cartProduct.Quan ?? 0));
    }
    return totalPrice;
  }

  Map<String, dynamic> toJson() {
    return {
      "payment_kind": payment_kind == null ? 'cash' : payment_kind!,
      "toDoor": toDoor! ? "1" : "0",
      "toHouse": toHouse! ? "1" : "0",
      "date_wanted": date_wanted,
      "isDiscount": isDiscount! ? "1" : "0",
      "address_id": address_id,
      'lat': lat,
      'long': long,
      "floor": selectfloor.toString(),
      "isElevetor": haselevater.toString(),
      'product':
          listcartproduct.map((cartproduct) => cartproduct.toJson()).toList(),
    };
  }
}
