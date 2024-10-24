class Region {
  int? regionId;
  int? capitalCityId;
  String? code;
  String? nameAr;
  String? nameEn;
  int? population;

  Region(
      {this.regionId,
      this.capitalCityId,
      this.code,
      this.nameAr,
      this.nameEn,
      this.population});

  Region.fromJson(Map<String, dynamic> json) {
    regionId = json['region_id'];
    capitalCityId = json['capital_city_id'];
    code = json['code'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    population = json['population'];
  }
}
