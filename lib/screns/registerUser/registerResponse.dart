// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    required this.success,
  });

  Success success;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success.toJson(),
  };
}

class Success {
  Success({
    required this.msg,
    required this.emailOtp,
  });

  String msg;
  String emailOtp;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    msg: json["msg"],
    emailOtp: json["emailOtp"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "emailOtp": emailOtp,
  };
}
