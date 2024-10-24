class User {
  bool? role;
  String? token;

  User({this.role, this.token});
  User.fromJson(dynamic responsedata) {
    role = responsedata['role'] == 'user' ? true : false;
    token = responsedata['token'];
  }
}
