// To parse this JSON data, do
//
//     final nearest = nearestFromJson(jsonString);

import 'dart:convert';

Nearest nearestFromJson(String str) => Nearest.fromJson(json.decode(str));

String nearestToJson(Nearest data) => json.encode(data.toJson());

class Nearest {
  Nearest({
    this.userId,
    this.startlat,
    this.startlng,
    this.order,
  });

  String? userId;
  String? startlat;
  String? startlng;
  List<Order>? order;

  factory Nearest.fromJson(Map<String, dynamic> json) => Nearest(
    userId: json["user_id"],
    startlat: json["startlat"],//.toDouble(),
    startlng: json["startlng"],//.toDouble(),
    order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "startlat": startlat,
    "startlng": startlng,
    "order": List<dynamic>.from(order!.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.username,
    this.password,
    this.userImage,
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
  dynamic middleName;
  String? lastName;
  String? username;
  String? password;
  dynamic userImage;
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
  double? distance;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    username: json["username"],
    password: json["password"],
    userImage: json["user_image"],
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
    "user_image": userImage,
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
