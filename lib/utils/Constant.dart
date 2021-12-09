//import 'package:connectivity/connectivity.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/utils/app_colors.dart';
//import 'package:customer/utils/ColorHelper.dart';
//import 'package:customer/utils/Gap.dart';
//import 'package:customer/utils/ImageHelper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_geocoder/geocoder.dart';


Future<Position> _getGeoLocationPosition() async {

  bool serviceEnabled;
  LocationPermission permission;
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
/*Future<void> GetAddressFromLatLong(Position position)async {
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemarks);
  Placemark place = placemarks[0];
  Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  setState(()  {
  });
}*/


Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

getSnackBar(String msg, String actionLable, GlobalKey<ScaffoldState> key) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 2),
   // backgroundColor: kPrimaryColor,
    behavior: SnackBarBehavior.floating,
    content: Text(msg,
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),


     action: SnackBarAction(
       textColor: Colors.white,
      label: actionLable,
      onPressed: () {
        // Some code to undo the change.
         key.currentState!.hideCurrentSnackBar();
       },
    // ),
  ));
  return snackBar;
}

/*showSuccessBottomSheet(String msg) {
  showModalBottomSheet(
      context: NavigationService().navigationKey.currentContext!,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0)),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(NavigationService().navigationKey.currentContext!).size.height/3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(successSignUp, height:80, width:80,),
                VerticalGap(gap: 12),
                Flexible(
                  child: Text(msg,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: AppColors.themeGreenColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0,
                      )),
                )
              ],
            ),
          ),
        );
      });
}*/

showLoader(String msg) {
  showModalBottomSheet(
      context: NavigationService().navigationKey.currentContext!,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0)),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(NavigationService().navigationKey.currentContext!).size.height/6,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.white70,
                ),
              //  VerticalGap(gap: 12),
                Text(msg,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                     // color: AppColors.themeGreenColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                    ))
              ],
            ),
          ),
        );
      });
}

hideLoader() {
  Navigator.of(NavigationService().navigationKey.currentContext!,
      rootNavigator: true)
      .pop();
}