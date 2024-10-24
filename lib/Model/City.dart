class City {
  int? cityId;
  int? regionId;
  String? nameAr;
  String? nameEn;

  City({this.cityId, this.regionId, this.nameAr, this.nameEn});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    regionId = json['region_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}
