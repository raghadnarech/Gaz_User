class Address {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic lang;
  dynamic lat;
  dynamic kind;
  dynamic floor;
  dynamic isElevetor;
  dynamic createdAt;
  dynamic updatedAt;

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
      this.updatedAt});

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
  }
}
