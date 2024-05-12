import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

String userModelToJson(UserModel data) => jsonEncode(data.toJson());

class UserModel {
  UserModel({required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(id: json['id'] as String);
  final String id;

  Map<String, dynamic> toJson() => {};
}
