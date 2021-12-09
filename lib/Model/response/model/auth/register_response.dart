// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.success,
  });

  Success? success;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success!.toJson(),
  };
}

class Success {
  Success({
    this.msg,
  });

  String? msg;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}
