//import 'package:booking_package/custom_views/my_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
//import 'package:customer/service/navigation_service.dart';
import 'package:taxiapp/service/navigation_service.dart';

import 'CustomViews/custom_views/my_alert_dialog.dart';


class PermissionUtils {
  static final PermissionUtils _locationUtils = PermissionUtils._internal();

  factory PermissionUtils() => _locationUtils;

  PermissionUtils._internal();

  askForPermission(Permission permission, {Function? onGranted}) {
    print('####====> askForPermission() called');
    checkPermission(permission, (int type) {
      if (type == 1) {
        // Permission Granted
        onGranted!();
      } else if (type == 2) {
        // Permission Denied
        showPermissionDialog(
            title: 'Enable Permission',
            description:
                'You need to enable location permission in order to access App Functionality',
            onClick: () {
              askForPermission(permission);
            });
      } else if (type == 3) {
        // Permission Permanently Denied. Open Settings.
        showPermissionDialog(
            title: 'Open Settings',
            description:
                'You need to enable location permission from Settings in order to access App Functionality',
            onClick: () {
              openSettings(permission);
            });
      }
    });
  }

  checkPermission(Permission permission, Function onResult) async {
    print('####====> checkPermission() called');
    var status = await permission.status;
    if (status.isGranted)
      onResult(1);
    else if (status.isPermanentlyDenied)
      onResult(3);
    else {
      status = await permission.request();
      if (status.isGranted)
        onResult(1);
      else if (status.isPermanentlyDenied)
        onResult(3);
      else
        onResult(2);
    }
  }

  openSettings(Permission permission) async {
    await AppSettings.openLocationSettings();
  }

  void showPermissionDialog({title, description, Function? onClick}) =>
      showDialog(
          context: NavigationService().navigationKey.currentContext!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                contentPadding: EdgeInsets.all(0.0),
                content: MyAlertDialog(
                    btn1: title,
                    str: description,
                    onClick: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).requestFocus(FocusNode());
                      onClick!();
                    }));
          });
}
