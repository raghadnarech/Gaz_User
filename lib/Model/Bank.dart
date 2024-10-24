class Bank {
  int? id;
  String? name;
  int? isActive;

  Bank({this.id, this.name, this.isActive});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
  }
}
