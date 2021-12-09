// To parse this JSON data, do
//
//     final registerErrorResponse = registerErrorResponseFromJson(jsonString);

import 'dart:convert';

RegisterErrorResponse registerErrorResponseFromJson(String str) => RegisterErrorResponse.fromJson(json.decode(str));

String registerErrorResponseToJson(RegisterErrorResponse data) => json.encode(data.toJson());

class RegisterErrorResponse {
  RegisterErrorResponse({
    this.errors,
  });

  List<Error>? errors;

  factory RegisterErrorResponse.fromJson(Map<String, dynamic> json) => RegisterErrorResponse(
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
