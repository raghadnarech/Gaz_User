// ignore_for_file: prefer_typing_uninitialized_variables

class Product {
  int? id;
  int? categoryId;
  int? supplierId;
  int? subCategoryId;
  int? isOffer;
  int? isActive;
  String? name;
  var price;
  String? discountCode;
  String? timeFrom;
  String? timeTo;
  String? image;
  String? offerText;
  String? offerValueKind;
  String? offerValue;
  String? offerStatus;

  Product({
    this.id,
    this.categoryId,
    this.supplierId,
    this.subCategoryId,
    this.isOffer,
    this.isActive,
    this.name,
    this.price,
    this.discountCode,
    this.timeFrom,
    this.timeTo,
    this.image,
    this.offerText,
    this.offerValueKind,
    this.offerValue,
    this.offerStatus,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      supplierId: json['supplier_id'],
      subCategoryId: json['sub_category_id'],
      isOffer: json['isOffer'],
      isActive: json['isActive'],
      name: json['name'],
      price: json['price'],
      discountCode: json['discount_code'],
      timeFrom: json['time_from'],
      timeTo: json['time_to'],
      image: json['image'],
      offerText: json['offer_text'],
      offerValueKind: json['offer_value_kind'].toString(),
      offerValue: json['offer_value'].toString(),
      offerStatus: json['offer_status'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'supplier_id': supplierId,
      'sub_category_id': subCategoryId,
      'isOffer': isOffer,
      'isActive': isActive,
      'name': name,
      'price': price,
      'discount_code': discountCode,
      'time_from': timeFrom,
      'time_to': timeTo,
      'image': image,
      'offer_text': offerText,
      'offer_value_kind': offerValueKind,
      'offer_value': offerValue,
      'offer_status': offerStatus,
    };
  }
}
