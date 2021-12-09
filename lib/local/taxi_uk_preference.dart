import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaxiUKPrefs{

  TaxiUKPrefs._privateConstructor();

  static final TaxiUKPrefs _instance = TaxiUKPrefs._privateConstructor();

  static TaxiUKPrefs get instance { return _instance;}

  saveUser(String key, String userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, userData);
  }

  deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<Map> getLoggedUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key).toString()) ?? "jbjb";
  }

  deleteUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  //Secure storage user for storing token.....
  saveSecureToken(String key, String token) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: key, value: token);
  }

  deleteToken(String key) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

  Future<String> getToken(String key) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    if (await storage.containsKey(key: key)) {
      return await storage.read(key: key).toString();
    }
    return "";
  }



  // Save & Get FCM Token from preference Manager
  saveFBToken(String fbToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('FCMToken', fbToken);
  }

  Future<String?> getFBToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('FCMToken')) {
      return prefs.getString('FCMToken').toString();
    }

    return null;
  }

// Save & Get User current location from preference Manager
  saveCurrentLocationLatitude(double locLatitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('CurrentLocationLatitude', locLatitude);
  }

  Future<double?> getCurrentLocationLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('CurrentLocationLatitude')) {
      return prefs.getDouble('CurrentLocationLatitude')!.toDouble();
    }

    return null;
  }

  saveCurrentLocationLongitude(double locLongitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('CurrentLocationLongitude', locLongitude);
  }

  Future<double?> getCurrentLocationLongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('CurrentLocationLongitude')) {
      return prefs.getDouble('CurrentLocationLongitude')!.toDouble();
    }

    return null;
  }

  saveLanguageSelection(int selectedValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('SelectedLanguage', selectedValue);
  }

  Future<int> getLanguageSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('SelectedLanguage')) {
      return prefs.getInt('SelectedLanguage') ?? 0;
    }
    return 0;
  }

  saveLoginStatus(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('LoginStatus', isLogin);
  }

  Future<bool?> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('LoginStatus')) {
      return prefs.getBool('LoginStatus') ?? false;
    }
    return null;
  }

  saveLanguageStatus(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('LanguageStatus', isLogin);
  }

  Future<bool> getLanguageStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('LanguageStatus')) {
      return prefs.getBool('LanguageStatus') ?? false;
    }
    return false;
  }

  saveFCMToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', token);
  }

  Future<String> getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('fcmToken')) {
      return prefs.getString('fcmToken') ?? "";
    }
    return "";
  }

  saveLanguageCode(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language_code', langCode);
  }

  Future<String> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('language_code')) {
      return prefs.getString('language_code') ?? "";
    }
    return "";
  }

  saveCountryCode(String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('countryCode', countryCode);
  }

  Future<String> getCountryCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('countryCode')) {
      return prefs.getString('countryCode') ?? "";
    }
    return "";
  }
}