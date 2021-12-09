import 'package:flutter/material.dart';
//import 'package:flutter_geocoder/geocoder.dart';
//import 'package:flutter_geocoder/geocoder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geocoder/geocoder.dart';

import 'constants.dart';

extension ValidationExtentions on String {

  get showToast {
    Fluttertoast.showToast(
        msg: this,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  // Validation for CountryCode
  get checkCountryCode {
    if (this.isEmpty)
      return "Country Code is Required";
    else
      null;
  }

  // Validation for Mobile
  get checkMobile {
    if (this.isEmpty)
      return "Mobile is Required";
    else
      null;
  }

  // Validation for Email
  get checkEmail {
    RegExp regExp = RegExp(Constants.emailPattern);
    if (this.isEmpty)
      return "Email is Required";
    else if (!regExp.hasMatch(this))
      return "Invalid Email";
    else
      null;
  }

  // Validation for Password
  get checkPassword {
    if (this.isEmpty)
      return "Password is Required";
    else if (this.length < 8)
      return "Password Should be 8 characters long,";
    else
      null;
  }
}


/*extension CoordinatesExtentions on  double{

  Future<String?> get getAddress async {
    List<Placemark> placemarks = await placemarkFromCoordinates();
    //await List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);//Geocoder.google(Constants.apiKey).findAddressesFromCoordinates(this);
    var address = placemarks.first;
    return address.name;
  }
  Future<String> get getTitle async {
    var addresses = await Geocoder.google(Constants.apiKey).findAddressesFromCoordinates(this);
    var address = addresses.first;
    return '${address.subLocality}, ${address.locality}';
  }
}*/