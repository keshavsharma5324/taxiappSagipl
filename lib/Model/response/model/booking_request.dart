// To parse this JSON data, do
//
//     final bookingRequest = bookingRequestFromJson(jsonString);

import 'dart:convert';

BookingRequest bookingRequestFromJson(String str) => BookingRequest.fromJson(json.decode(str));

String bookingRequestToJson(BookingRequest data) => json.encode(data.toJson());

class BookingRequest {
  BookingRequest({
    this.success,
  });

  Success? success;

  factory BookingRequest.fromJson(Map<String, dynamic> json) => BookingRequest(
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
    this.driverId,
    this.userId,
    this.latitude,
    this.longitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? driverId;
  int? userId;
  double? latitude;
  double? longitude;
  double? destinationLatitude;
  double? destinationLongitude;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    driverId: json["driver_id"],
    userId: json["user_id"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    destinationLatitude: json["destination_latitude"].toDouble(),
    destinationLongitude: json["destination_longitude"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "user_id": userId,
    "latitude": latitude,
    "longitude": longitude,
    "destination_latitude": destinationLatitude,
    "destination_longitude": destinationLongitude,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
