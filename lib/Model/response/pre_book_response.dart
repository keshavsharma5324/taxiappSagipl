import 'package:taxiapp/Model/response/ride_bean.dart';

//import '../../models/response/ride_bean.dart';

class PreBookResponse {
  String? message;
  List<RideBean>? list;
  bool? isSuccess;

  PreBookResponse({this.message, this.list, this.isSuccess});

  PreBookResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      var data = <RideBean>[];
      !(json['data'] is List)
          ? json['data']['data'].forEach((v) { // Instant
              data.add(RideBean.fromJson(v));
            })
          : json['data'].forEach((v) { // Pre-Book
              data.add(RideBean.fromJson(v));
            });
      list = data;
    }

    isSuccess = json['is_success'];
  }
}
