// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.success,
  });

  Success? success;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success!.toJson(),
  };
}

class Success {
  Success({
    this.msg,
    this.users,
  });

  String? msg;
  List<User>? users;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    msg: json["msg"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.username,
    this.password,
    this.email,
    this.mobile,
    this.address,
    this.latitude,
    this.longitude,
    this.status,
    this.deviceId,
    this.deviceType,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? firstName;
  dynamic? middleName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? mobile;
  dynamic? address;
  dynamic? latitude;
  dynamic? longitude;
  String? status;
  String? deviceId;
  dynamic? deviceType;
  DateTime? createdAt;
  dynamic? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    username: json["username"],
    password: json["password"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    deviceId: json["device_id"],
    deviceType: json["device_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "username": username,
    "password": password,
    "email": email,
    "mobile": mobile,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "device_id": deviceId,
    "device_type": deviceType,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt,
  };
}
