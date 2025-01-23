// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? fullname;
  String? phoneNo;
  String? profileImage;
  String? role;
  String? token;
  String? uid;

  UserModel({
    this.email,
    this.fullname,
    this.phoneNo,
    this.profileImage,
    this.role,
    this.token,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        fullname: json["fullname"],
        phoneNo: json["phoneNo"],
        profileImage: json["profileImage"],
        role: json["role"],
        token: json["token"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "phoneNo": phoneNo,
        "profileImage": profileImage,
        "role": role,
        "token": token,
        "uid": uid,
      };
}
