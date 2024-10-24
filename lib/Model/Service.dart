class Services {
  int? id;
  String? name;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Services({this.id, this.name, this.isActive, this.createdAt, this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
