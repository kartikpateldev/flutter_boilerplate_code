import '../entities/user.dart';

class UserModel extends User {
  UserModel({String? id, required String name, required String email})
      : super(id: id, name: name, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) {
      json['_id'] = id;
    }
    json['name'] = name;
    json['email'] = email;
    return json;
  }
}
