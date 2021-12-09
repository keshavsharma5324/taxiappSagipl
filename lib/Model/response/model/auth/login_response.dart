// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.success,
  });

  late Success success;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success.toJson(),
  };
}

class Success {
  Success({
    this.msg,
    this.token,
    this.userId,
  });

  String? msg;
  String? token;
  int? userId;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    msg: json["msg"],
    token: json["token"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "token": token,
    "user_id": userId,
  };
}
