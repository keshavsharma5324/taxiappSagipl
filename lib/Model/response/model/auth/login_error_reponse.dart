// To parse this JSON data, do
//
//     final loginErrorResponse = loginErrorResponseFromJson(jsonString);

import 'dart:convert';

LoginErrorResponse loginErrorResponseFromJson(String str) => LoginErrorResponse.fromJson(json.decode(str));

String loginErrorResponseToJson(LoginErrorResponse data) => json.encode(data.toJson());

class LoginErrorResponse {
  LoginErrorResponse({
    this.errors,
  });

  List<Error>? errors;

  factory LoginErrorResponse.fromJson(Map<String, dynamic> json) => LoginErrorResponse(
    errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors!.map((x) => x.toJson())),
  };
}

class Error {
  Error({
    this.msg,
  });

  String? msg;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}
