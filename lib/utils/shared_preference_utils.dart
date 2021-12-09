//import 'package:customer/model/auth/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/Model/response/model/auth/login_response.dart';

class SharedPreferenceUtils {
  static final SharedPreferenceUtils _instance = SharedPreferenceUtils._internal();

  factory SharedPreferenceUtils() => _instance;

  SharedPreferenceUtils._internal();

  saveUserData(Success data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', data.token.toString());
    prefs.setString('mobileNumber', data.token.toString());
    prefs.setString('accessToken', data.token.toString());
    // prefs.setString('userId', data.id);
  }

  saveAccessToken(String data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', data);
    // prefs.setString('userId', data.id);
  }

  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}