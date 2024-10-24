import 'package:gas_app/Model/Product.dart';
import 'package:gas_app/Model/SubCategory.dart';

class Category {
  int? id;
  int? supplierId;
  String? name;
  List<SubCategory>? listsubcategory = [];
  List<Product>? listproduct = [];

  Category({this.id, this.supplierId, this.name, this.listsubcategory});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'];
    name = json['name'];
    if (json['sub_pro'] != []) {
      for (var element in json['sub_pro']) {
        listsubcategory!.add(SubCategory.fromJson(element));
      }
    }
    if (json['products'] != []) {
      for (var element in json['products']) {
        listproduct!.add(Product.fromJson(element));
      }
    }
  }
}
