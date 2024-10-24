class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
