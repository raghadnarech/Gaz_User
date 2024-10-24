class District {
  int? districtId;
  int? cityId;
  int? regionId;
  String? nameAr;
  String? nameEn;

  District(
      {this.districtId, this.cityId, this.regionId, this.nameAr, this.nameEn});

  District.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}
