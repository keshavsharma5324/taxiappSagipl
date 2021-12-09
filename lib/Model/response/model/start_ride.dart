// To parse this JSON data, do
//
//     final startRide = startRideFromJson(jsonString);

import 'dart:convert';

StartRide startRideFromJson(String str) => StartRide.fromJson(json.decode(str));

String startRideToJson(StartRide data) => json.encode(data.toJson());

class StartRide {
  StartRide({
    this.success,
  });

  Success? success;

  factory StartRide.fromJson(Map<String, dynamic> json) => StartRide(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success!.toJson(),
  };
}

class Success {
  Success({
    this.msg,
    this.destinationLatitude,
    this.destinationLongitude,
    this.pickupTime,
    this.rideId,
  });

  String? msg;
  double? destinationLatitude;
  double? destinationLongitude;
  String? pickupTime;
  int? rideId;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    msg: json["msg"],
    destinationLatitude: json["destination_latitude"].toDouble(),
    destinationLongitude: json["destination_longitude"].toDouble(),
    pickupTime: json["pickup_time"],
    rideId: json["ride_id"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "destination_latitude": destinationLatitude,
    "destination_longitude": destinationLongitude,
    "pickup_time": pickupTime,
    "ride_id": rideId,
  };
}
