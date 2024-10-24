class SubSupplier {
  int? id;
  int? supplierId;
  int? serviceId;
  String? lang;
  String? lat;
  String? area;
  String? city;
  String? street;
  String? supplierName;
  String? supplierPhone;
  String? supplierEmail;
  String? supplierBankNum;
  String? supplierBankName;
  String? supplierLogo;
  String? supplierService;

  SubSupplier({
    this.id,
    this.supplierId,
    this.serviceId,
    this.lang,
    this.lat,
    this.area,
    this.city,
    this.street,
    this.supplierName,
    this.supplierPhone,
    this.supplierEmail,
    this.supplierBankNum,
    this.supplierBankName,
    this.supplierLogo,
    this.supplierService,
  });

  SubSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'];
    serviceId = json['service_id'];
    lang = json['lang'];
    lat = json['lat'];
    area = json['area'];
    city = json['city'];
    street = json['street'];
    supplierName = json['supplier_name'];
    supplierPhone = json['supplier_phone'];
    supplierEmail = json['supplier_email'];
    supplierBankNum = json['supplier_bankNum'];
    supplierBankName = json['supplier_bankName'];
    supplierLogo = json['supplier_logo'];
    supplierService = json['supplier_service'];
  }

  SubSupplier.Gaz(Map<String, dynamic> json) {
    id = json['id'];
    // supplierId = json['user_id'];
    serviceId = json['service_id'];
    lang = json['lang'];
    lat = json['lat'];
    area = json['area'];
    city = json['city'];
    street = json['street'];
    supplierName = json['user']['user_name'];
    supplierPhone = json['user']['phone'];
    supplierEmail = json['user']['email'];
    supplierBankNum = json['user']['bank_num'];
    supplierBankName = json['user']['bank_name'];
    supplierLogo = json['user']['logo'];
    // supplierService = json['user']['supplier_service'];
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplierId,
      'service_id': serviceId,
      'lang': lang,
      'lat': lat,
      'area': area,
      'city': city,
      'street': street,
      'supplier_name': supplierName,
      'supplier_phone': supplierPhone,
      'supplier_email': supplierEmail,
      'supplier_bankNum': supplierBankNum,
      'supplier_bankName': supplierBankName,
      'supplier_logo': supplierLogo,
      'supplier_service': supplierService,
    };
  }
}
