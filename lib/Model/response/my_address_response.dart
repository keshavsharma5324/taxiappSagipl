//import 'package:booking_package/models/response/location_bean.dart';
import 'package:taxiapp/Model/response/location_bean.dart';

class MyAddressResponse {
  String? message;
  List<LocationBean>? data;
  bool? isSuccess;

  MyAddressResponse({this.message, this.data, this.isSuccess});

  MyAddressResponse.fromJson(Map<String, dynamic> json) {
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