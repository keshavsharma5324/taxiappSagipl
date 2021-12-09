//import 'package:booking_package/models/response/location_bean.dart';

import 'location_bean.dart';

class DriverLocationResponse {
  String? message;
  late List<LocationBean>? data;
  bool? isSuccess;

  DriverLocationResponse({this.message, this.data, this.isSuccess});

  DriverLocationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <LocationBean>[];
      json['data'].forEach((v) {
        data!.add(LocationBean.fromJson(v));
      });
    }
    isSuccess = json['is_success'];
  }
}