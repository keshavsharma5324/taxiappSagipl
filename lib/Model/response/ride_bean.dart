import 'dart:convert';
import '../response/location_bean.dart';
import '../response/user_bean.dart';

class RideBean {
  String? id;
  String? bookingId;
  String? driverId;
  String? paymentMode;
  String? distance;
  String? time;
  String? driverCurrentLocationToSourceDistance = '0.0';
  String? driverCurrentLocationToSourceTime = '';
  String? bookingType;
  String? rideStatus;
  String? rideId;
  LocationBean? locationPickup;
  LocationBean? locationDrop;
  LocationBean? driverCurrentLocation;
  String? taxiRegistration = '';
  String? taxiName = '';
  String? taxiImage = '';
  String? amount = '';
  late UserBean? driver;
  String? createdAt;

  String? historyStatus;

  // String rideCompleted

  RideBean(
      {required this.id,
      this.bookingId,
      this.driverId,
      this.paymentMode,
      this.distance,
      this.time,
      this.bookingType,
      this.rideStatus,
      this.rideId,
      this.locationPickup,
      this.locationDrop,
      this.driverCurrentLocation,
      this.taxiRegistration,
      this.taxiName,
      this.taxiImage,
      this.amount,
      this.driver,
      this.historyStatus,
      this.createdAt});

  RideBean.fromJson(Map<String, dynamic> json1) {
    id = json1['id'].toString();
    bookingId = json1['booking_id'];
    driverId = json1['driver_id'].toString();
    paymentMode = json1['payment_mode'].toString();
    distance = json1['distance'];
    time = json1['time'];
    bookingType =
        json1['booking_type'] != null ? json1['booking_type'].toString() : '';
    rideStatus = json1['type'] != null ? json1['type'].toString() : '';
    // status = json1['status'].toString();
    rideId = json1['main_ride_id'].toString();

    locationPickup = json1['location'] != null
        ? LocationBean.fromJson(json1['location'] is String
            ? json.decode(json1['location'])
            : json1['location'])
        : null;

    locationDrop = json1['location_drop'] != null
        ? LocationBean.fromJson(json1['location_drop'] is String
            ? json.decode(json1['location_drop'])
            : json1['location_drop'])
        : null;
    driverCurrentLocation = json1['driver_current_location'] != null
        ? LocationBean.fromJson(json1['driver_current_location'] is String
            ? json.decode(json1['driver_current_location'])
            : json1['driver_current_location'])
        : null;

    if (json1['user'] != null) {
      var driver1 = <UserBean>[];
      json1['user'] is String
          ? json.decode(json1['user']) is List
              ? json.decode(json1['user']).forEach((v) {
                  driver1.add(UserBean.fromJson(v));
                })
              : driver1.add(UserBean.fromJson(json.decode(json1['user'])))
          : json1['user'] is List
              ? json1['user'].forEach((v) {
                  driver1.add(UserBean.fromJson(v));
                })
              : driver1.add(UserBean.fromJson(json1['user']));
      driver = driver1[0];
    }

    if (json1['taxi_details'] != null) {
      var taxiDetails = (json1['taxi_details'] is String)
          ? json.decode(json1['taxi_details'])
          : json1['taxi_details'];

      taxiRegistration = taxiDetails['taxi_registration'];

      taxiName = (taxiDetails['model_details'] is String)
          ? json.decode(json1[taxiDetails['model_details']])['name']
          : taxiDetails['model_details']['name'];

      taxiImage = (taxiDetails['model_details'] is String)
    ? json.decode(json1[taxiDetails['model_details']])['image']
        : taxiDetails['model_details']['image'];
    }

    if (json1['taxi_info'] != null) {
      taxiImage = json1['taxi_info']['image'].toString();
    }

    if (json1['payment_info'] != null) {
      var paymentInfo = (json1['payment_info'] is String)
          ? json.decode(json1['payment_info'])
          : json1['payment_info'];

      amount = paymentInfo['amount'].toString();
    }

    createdAt = json1['created_at_date'].toString();

    if(json1['ride_status']!= null)
    historyStatus = json1['ride_status'].toString();
  }
}
