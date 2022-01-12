// To parse this JSON data, do
//
//     final driver = driverFromJson(jsonString);

import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    this.userId,
    this.lat,
    this.long,
    this.userName,
    this.driverId,
  });

  String? userId;
  String? lat;
  String? long;
  String? userName;
  String? driverId;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    userId: json["user_id"],
    lat: json["lat"],//.toDouble(),
    long: json["long"],//.toDouble(),
    userName: json["user_name"],
    driverId: json["driver_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "lat": lat,
    "long": long,
    "user_name": userName,
    "driver_id": driverId,
  };
}
