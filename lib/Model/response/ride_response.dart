import '../response/ride_bean.dart';
import 'dart:convert';

class RideResponse {
  String? message;
  RideBean? data;
  bool? isSuccess;

  RideResponse({this.message, this.data, this.isSuccess});

  RideResponse.fromJson(Map<String, dynamic> map) {
    message = map['message'];
    data = map['data']!= null ? RideBean.fromJson(map['data']): null;
    isSuccess = map['is_success'];
  }
}