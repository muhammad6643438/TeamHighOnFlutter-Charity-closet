class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNo;
  String? profileImage;
  String? role;
  String? token;

  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNo,
    this.profileImage,
    this.role,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      fullName: json['fullname'],
      phoneNo: json['phoneNo'],
      profileImage: json['profileImage'],
      role: json['role'],
      token: json['token'],
    );
  }
}
