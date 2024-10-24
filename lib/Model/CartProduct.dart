import 'package:gas_app/Model/Product.dart';
import 'package:gas_app/Model/Service.dart';
import 'package:gas_app/Model/SubSupplier.dart';

class CartProduct {
  Services? service;
  SubSupplier? subSupplier;
  int? subSupplierid;
  Product? product;
  // String? code;
  int? Quan;
  CartProduct(
      {this.Quan,
      this.product,
      this.service,
      // this.code,
      this.subSupplier,
      this.subSupplierid});

  incrementproduct() {
    Quan = Quan! + 1;
  }

  dcrementproduct() {
    Quan = Quan! - 1;
  }
  //  double getTotalPrice() {
  //   double totalPrice = 0.0;
  //   for (var cartProduct in listcartproduct) {
  //     totalPrice += (cartProduct.product!.price! * (cartProduct.Quan ?? 0));
  //   }
  //   return totalPrice;
  // }

  double getTotalPrice() {
    double totalPrice = 0.0;
    totalPrice = double.parse(product!.price!.toString()) * Quan!;
    return totalPrice;
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': service!.id,
      'supplier_id':
          subSupplier == null ? product!.supplierId : subSupplier!.supplierId,
      'quantity': Quan,
      // 'code': code,
      'product_id': product!.id,
    };
  }
}
