// To parse this JSON data, do
//
//     final ridebooked = ridebookedFromJson(jsonString);

import 'dart:convert';

Ridebooked ridebookedFromJson(String str) => Ridebooked.fromJson(json.decode(str));

String ridebookedToJson(Ridebooked data) => json.encode(data.toJson());

class Ridebooked {
  Ridebooked({
    this.success,
  });

  Success? success;

  factory Ridebooked.fromJson(Map<String, dynamic> json) => Ridebooked(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success!.toJson(),
  };
}

class Success {
  Success({
    this.msg,
    this.userId,
    this.driverDetails,
  });

  String? msg;
  int? userId;
  List<DriverDetail>? driverDetails;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    msg: json["msg"],
    userId: json["user_id"],
    driverDetails: List<DriverDetail>.from(json["driver details"].map((x) => DriverDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "user_id": userId,
    "driver details": List<dynamic>.from(driverDetails!.map((x) => x.toJson())),
  };
}

class DriverDetail {
  DriverDetail({
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
    this.vehicleType,
    this.deviceId,
    this.deviceType,
    this.drivingLicence,
    this.taxiNo,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? firstName;
  dynamic middleName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? mobile;
  dynamic address;
  double? latitude;
  double? longitude;
  String? status;
  String? vehicleType;
  String? deviceId;
  dynamic deviceType;
  dynamic drivingLicence;
  dynamic taxiNo;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DriverDetail.fromJson(Map<String, dynamic> json) => DriverDetail(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    username: json["username"],
    password: json["password"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    status: json["status"],
    vehicleType: json["vehicle_type"],
    deviceId: json["device_id"],
    deviceType: json["device_type"],
    drivingLicence: json["driving_licence"],
    taxiNo: json["taxi_no"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "vehicle_type": vehicleType,
    "device_id": deviceId,
    "device_type": deviceType,
    "driving_licence": drivingLicence,
    "taxi_no": taxiNo,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
