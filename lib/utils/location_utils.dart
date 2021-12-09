/*import 'dart:async';

import 'package:taxiapp/utils/CustomViews/custom_views/my_alert_dialog.dart';

//import '../custom_views/my_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class LocationUtils {
  static final LocationUtils _locationUtils = LocationUtils._internal();

  factory LocationUtils() => _locationUtils;

  LocationUtils._internal();

  checkLocationService1({Function? onGranted}) async {
    var isEnabled = await Location().serviceEnabled();

    if (isEnabled)
      onGranted!();
    else {
      isEnabled = await Location().requestService();
      if (isEnabled) onGranted!();
    }
  }

  // StreamSubscription<LocationData> _locationSubscription;
  //
  // final Location location = Location();
  // getLocationUpdates() async {
  //   location.changeSettings(distanceFilter: 50, interval: 5000);
  //   _locationSubscription =
  //       location.onLocationChanged().handleError((dynamic err) {
  //         _locationSubscription.cancel();
  //       }).listen((LocationData currentLocation) async {
  //         print('Getting Current Location ===> ${currentLocation.latitude}, ${currentLocation.longitude }');
  //         // MyNotificationStream().addLocationStream(currentLocation);
  //       });
  // }














  Future<bool> checkPermission(
      Permission permission, BuildContext context, String type) async {
    var status = await permission.status;
    if (status.isRestricted) {
      // Didn't ask for permission yet.
      return _requestPermission(permission, context, type);
    } else if (status.isPermanentlyDenied) {
      _showDialog(context, type);
      return false;
    } else if (!status.isGranted) {
      return _requestPermission(permission, context, type);
    }
    return true;
  }

  Future<bool> _requestPermission(
      Permission permission, BuildContext context, type) async {
    var status = await permission.request();
    if (status.isGranted) {
      return true;
    }
    if (status.isPermanentlyDenied) {
      // Open Settings
      _showDialog(context, type);
    } else if (!status.isGranted) {
      _requestPermission(permission, context, type);
    }
    return false;
  }

  void _openAppSettings(context, type) async {
    await openAppSettings();
    _requestPermission(Permission.location, context, type);
  }

  void _showDialog(BuildContext context, String type) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            contentPadding: EdgeInsets.all(0.0),
            content: MyAlertDialog(
                btn1: 'Open Settings',
                str: 'You need to enable $type Permission from settings.',
                onClick: () {
                  Navigator.of(context).pop();
                  FocusScope.of(context).requestFocus(FocusNode());
                  _openAppSettings(context, type);
                }));
      });

  Future<LocationData?> getCurrentLocation() async {
    var locationData = await Location().getLocation();
    if (locationData != null) {
      return locationData;
    } else {
      getCurrentLocation();
    }
  }

  // Future<bool> checkLocationService() async {
  //   var isServiceEnabled = await Location().serviceEnabled();
  //   if (!isServiceEnabled) {
  //     isServiceEnabled = await Location().requestService();
  //     if (!isServiceEnabled) {
  //       checkLocationService();
  //     }
  //   }
  // }

  dynamic checkLocationService() async {
    print('checkLocationService() Called');
    var isServiceEnabled = await Location().serviceEnabled();
    if (!isServiceEnabled) {
      print('Location Service Not Enabled');
      _requestLocationService();
    } else {
      print('Location Service Enabled');
      return true;
    }
  }

  Future _requestLocationService() async {
    print('_requestLocationService() Called');
    await Location().requestService();
    checkLocationService();
  }
}*/
