// To parse this JSON data, do
//
//     final searchCab = searchCabFromJson(jsonString);

import 'dart:convert';

SearchCab searchCabFromJson(String str) => SearchCab.fromJson(json.decode(str));

String searchCabToJson(SearchCab data) => json.encode(data.toJson());

class SearchCab {
  SearchCab({
    this.success,
  });

  Success? success;

  factory SearchCab.fromJson(Map<String, dynamic> json) => SearchCab(
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
    this.distance,
  });

  int? id;
  String? firstName;
  dynamic? middleName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? mobile;
  dynamic? address;
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
  double? distance;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    distance: json["distance"].toDouble(),
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
    "distance": distance,
  };
}
