import 'dart:convert';

//import 'package:cabbooking/models/response/model/auth/User.dart';
import 'package:taxiapp/Model/response/model/auth/User.dart';
//import 'package:customer/model/auth/User.dart';

ProfileResponse registerResponseFromMap(String str) => ProfileResponse.fromMap(json.decode(str));

String registerResponseToMap(ProfileResponse data) => json.encode(data.toMap());

class ProfileResponse {
  ProfileResponse({
    this.message,
    this.data,
    this.isSuccess,
  });

  final String? message;
  final UserData? data;
  final bool? isSuccess;

  factory ProfileResponse.fromMap(Map<String, dynamic> json) => ProfileResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : UserData.fromMap(json["data"]),
    isSuccess: json["is_success"] == null ? null : json["is_success"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toMap(),
    "is_success": isSuccess == null ? null : isSuccess,
  };
}
