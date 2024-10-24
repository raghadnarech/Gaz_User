import 'package:gas_app/Model/Product.dart';

class SubCategory {
  int? id;
  int? categoryId;
  String? name;
  String? image;
  List<Product> listproduct = [];

  SubCategory({this.id, this.categoryId, this.name, this.image, listproduct});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    if (json['products'] != []) {
      for (var element in json['products']) {
        listproduct.add(Product.fromJson(element));
      }
    }
  }
}
