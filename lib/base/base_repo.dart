/*import 'dart:io';

//import 'package:customer/utils/constants.dart';
import 'package:dio/dio.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/utils/constants.dart';
//import '../../service/navigation_service.dart';
import '../../utils/my_extentions.dart';
//import '../../route/route_constant.dart';

class BaseRepo {
  static final BaseRepo _baseRepo = BaseRepo._internal();

  Dio? _dio;

  factory BaseRepo() {
    return _baseRepo;
  }

  BaseRepo._internal();
  dynamic hitApi(String api,
      {dynamic params, String? accessToken, Options? options, bool? isDelete}) async {
    if (_dio == null) {
      _dio = Dio();
      // Add options
      _dio!
        ..options.baseUrl = Constants.baseUrl
        ..options.connectTimeout = Duration.millisecondsPerMinute
        ..options.receiveTimeout = Duration.millisecondsPerMinute;
    }
    _dio!.interceptors.clear();
    _dio!.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        requestBody: true));

   // if (accessToken != null) {
      //print(accessToken);
   // _dio!.interceptors.clear();
      _dio!.interceptors.add(
          InterceptorsWrapper(
              onRequest: (RequestOptions options,handler) async {
                if(accessToken != null ){
                  //options.headers['content-Type'] = 'application/x'
                  options.headers['content-Type'] = 'application/x-www-form-urlencoded';
                  options.headers['x-access-token'] = '$accessToken';
                  return handler.next(options);
                }
                /*if (accessToken != null && id==null)
                  options.headers['content-Type'] = 'application/x-www-form-urlencoded';
                  options.headers['x-access-token'] = '$accessToken';
                  options.headers['user_id'] = '$id';
                  //if(id != null)
                   // options.
                return handler.next(options);*/

              },));
      // Add Authorization
      /*_dio!.interceptors.add(
          InterceptorsWrapper(
          onRequest: (Options options, handler) async{
        if (accessToken != null)
          print(accessToken);
          request.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(request);
      },));*/
   /*   _dio.interceptors
          .add(InterceptorsWrapper(
              onRequest: (RequestOptions options) async {
        var customHeaders = {'Authorization': 'Bearer $accessToken'};
        options.headers.addAll(customHeaders);
        return options;
      }//));
    }*/

    try {
      if (params != null) {
        // Post Api
        final response = await _dio!.post(api, data: params, options: options);
        return response.data;
      } else if (isDelete != null && isDelete == true) {
        // Delete Api
        final response = await _dio!.delete(api);
        return response.data;
      } else {
        // Get Apix
        final response = await _dio!.get(api);
        return response.data;
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on DioError catch (e) {
      var msg = "";
      bool isUserExist = false;
      int status_code = 0;
      switch (e.type) {
        case DioErrorType.cancel:
          msg = 'Request Cancelled';
          status_code = 0;
          break;
        case DioErrorType.connectTimeout:
          msg = 'Connection Timeout';
          status_code = 0;
          break;
        case DioErrorType.connectTimeout:
          msg = 'Connection Timeout';
          status_code = 0;
          break;
        case DioErrorType.sendTimeout:
          msg = 'Connection Timeout';
          status_code = 0;
          break;
        case DioErrorType.other:
          msg = 'No Internet Connection';
          status_code = 0;
          break;
        case DioErrorType.response:
          switch (e.response!.statusCode) {
            case 201:
              msg = e.response!.data["errors"][0]["msg"];
              break;
            case 302:
            // Bearer Token Missing
              msg = 'Invalid Request';
              status_code = 302;
              break;
            case 400:
            // Bad Request
              msg = e.response!.data['message'];
              print("400 Bad Request => ${(e.response!.data as Map<String, dynamic>).containsKey("meta") ? e.response!.data["meta"]["is_user_exist"] : false}");
              isUserExist = (e.response!.data as Map<String, dynamic>).containsKey("meta") ? e.response!.data["meta"]["is_user_exist"] : false;
              status_code = 400;
              break;
            case 401:
            // Un Authorized
              'Your Session has been Expired, Please Login Again.'.showToast;
              _logoutUser();
              msg = e.response!.data['message'];
              status_code = 401;
              break;
            case 403:
            // Forbidden
              msg = 'Forbidden Error';
              print(msg);
              status_code = 403;
             /* _dio!.interceptors.requestLock.lock();
              _dio!.interceptors.responseLock.lock();
              RequestOptions requestOptions = e.requestOptions;
              final opts = new Options(method: requestOptions.method);
              _dio!.options.headers["x-access-token"] = accessToken!;
              _dio!.options.headers["content-type"] = "application/x-www-form-urlencoded";
              _dio!.interceptors.requestLock.unlock();
              _dio!.interceptors.responseLock.unlock();
              final response = await _dio!.request(requestOptions.path,
                  options: opts,
                  cancelToken: requestOptions.cancelToken,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters);
              if (response != null) {
                handler.resolve(response);
              } else {
                return null;
              }*/
              break;
            case 404:
            // Not Found
              msg = 'Api Not Found';
              status_code = 404;
              break;
            case 500:
            // Internal Server Error
              msg = 'Server Error';
              status_code = 500;
              break;
            case 503:
            // Service Unavailable
              msg = 'Service Unavailable';
              status_code = 503;
              break;
            default:
              msg = 'Something went wrong';
              status_code = 600;
              break;
          }
          break;
        default:
          msg = 'Something went wrong';
          status_code = 601;
          break;
      }
      var dataToString = {
        "message": msg,
        "status_code": status_code,
        "is_user_exist": isUserExist
      };
      throw Exception(dataToString);
    } catch (e) {
      throw Exception('${e.toString()}');
    }
  }

  dynamic generateOtpForgotPass(params) async {
    try {
      var data = await hitApi(Constants.generateOtp,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }
  dynamic Registration(params) async {
    try {
      var data = await hitApi(Constants.register,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }

  dynamic generateOtpRegistration(params) async {
    try {
      var data = await hitApi(Constants.generateOtp,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }

  dynamic generateOtp(params, {accessToken}) async {
    try {
      var data = await hitApi(Constants.generateOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic checkOtp(params, {String? accessToken}) async {
    try {
      var data = await hitApi(Constants.checkOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic changePassword(params, accessToken) async {
    try {
      final data = await hitApi(Constants.changePassword,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());//
    }
  }

  dynamic doLogin(params) async {
    try {
     /* var deviceToken = await FirebaseMessaging.instance.getToken();
      params['device_token'] = (deviceToken != null && deviceToken.isNotEmpty) ? deviceToken : '';
      print('DeviceToken => ${params['device_token']}');*/

      var data = await hitApi(Constants.login,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getDetails(String token,int Id) async {
    try {
      var data = await hitApi(Constants.getProfile+Id.toString(), accessToken: token, isDelete: false);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic userLogout(String token,) async {
    try {
      var data = await hitApi(Constants.logout, accessToken: token, isDelete: true);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /*dynamic updateProfile(params, accessToken) async {
    try {
      final data = await hitApi(Constants.updateProfile,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }*/

  dynamic updateProfile(params,String token,int Id) async {
    try {
      var data = await hitApi(Constants.profileUpdate+Id.toString(),params: params, accessToken: token, isDelete: false);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic updateEmail(params, accessToken) async {
    try {
      final data = await hitApi(Constants.generateOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic updatePhone(params, accessToken) async {
    try {
      final data = await hitApi(Constants.generateOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic updateProfilePic(FormData params, String accessToken) async {
    try {
      final data = await hitApi(Constants.uploadProfilePic,
          params: params,
          accessToken: accessToken,
          options: Options(contentType: 'multipart/form-data'));
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic verifyOtp(params, accessToken) async {
    try {
      var data = await hitApi(Constants.checkOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  _logoutUser() async {
    var result = await SharedPreferences.getInstance();
    await result.clear();
   // NavigationService().pushNamedAndRemoveUntil(login);
  }
}*/


//import 'package:customer/utils/constants.dart';
import 'dart:collection';
import 'dart:io';

//import 'package:customer/utils/constants.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/google%20map/models/Search_places.dart';
import 'package:taxiapp/google%20map/models/place.dart';
import 'package:taxiapp/google%20map/models/place_search.dart';
import 'package:taxiapp/utils/constants.dart';
//import '../../service/navigation_service.dart';
import '../../utils/my_extentions.dart';
//import '../../route/route_constant.dart';

class BaseRepo {
  static final BaseRepo _baseRepo = BaseRepo._internal();
    final key = 'AIzaSyAvFh2R7W_4hVBK_UAo5B64iriZLsyaqRo';

  Dio? _dio;

  factory BaseRepo() {
    return _baseRepo;
  }
  int? status;

  BaseRepo._internal();
  dynamic hitApi(String api,
      {dynamic params, String? accessToken, Options? options
        , bool? isDelete,int? id}) async {
    if (_dio == null) {
      _dio = Dio();
      // Add options
     // var status;
      _dio!
        ..options.baseUrl = Constants.baseUrl
        ..options.connectTimeout = Duration.millisecondsPerMinute
        ..options.receiveTimeout = Duration.millisecondsPerMinute
      ..options.followRedirects= false
      ..options.validateStatus=(status) { return status! < 500; };
      //..options.
     // ..options.receiveDataWhenStatusError =true;
    //.toInt() as ValidateStatus;

    }
    _dio!.interceptors.clear();
    _dio!.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        requestBody: true));

    if (accessToken != null ) {
      print(accessToken);
       _dio!.interceptors.add(
          InterceptorsWrapper(
              onRequest: (RequestOptions options,handler) async {
                if (accessToken != null && accessToken != '')
                  options.headers['content-Type'] = 'application/x-www-form-urlencoded';
                  options.headers['x-access-token'] = accessToken;
                return handler.next(options);
              },));
      // Add Authorization
     /* _dio!.interceptors
          .add(InterceptorsWrapper(
          onRequest: (RequestOptions options,handler) async {
            var customHeaders = {'x-access-token':accessToken};
            options.headers.addAll(customHeaders);
            return handler.next(options);
          }));*/
          }

          try {
      if (params != null) {
      // Post Api
      final response = await _dio!.post(api, data: params, options: options/*new Options(followRedirects: false,
          validateStatus: (status) { return status! < 500; })*/);
      return response.data;
      } else if (isDelete != null && isDelete == true) {
      // Delete Api
      final response = await _dio!.delete(api);
      return response.data;
      } else {
      // Get Api
      final response = await _dio!.get(api);
      return response.data;
      }
      } /*on SocketException {
      throw Exception('No Internet connection');
      } */on DioError catch (e) {
      var msg = "";
      bool isUserExist = false;
      int status_code = 0;
      switch (e.type) {
      case DioErrorType.cancel:
      msg = 'Request Cancelled';
      status_code = 0;
      break;
      case DioErrorType.connectTimeout:
      msg = 'Connection Timeout';
      status_code = 0;
      break;
      case DioErrorType.connectTimeout:
      msg = 'Connection Timeout';
      status_code = 0;
      break;
      case DioErrorType.sendTimeout:
      msg = 'Connection Timeout';
      status_code = 0;
      break;
      case DioErrorType.other:
      msg = 'No Internet Connection';
      status_code = 0;
      break;
      case DioErrorType.response:
     // int? status;
      switch (e.response!.statusCode) {
      case 202:
      msg = 'non authoritive request';
      status_code = 202;
      break;
      case 203:
        msg = 'non authoritive request';
        status_code = 203;
        break;
      case 302:
      // Bearer Token Missing
      msg = 'Invalid Request';
      status_code = 302;
      break;
      case 400:
      // Bad Request
      msg = e.response!.data['message'];
      print("400 Bad Request => ${(e.response!.data as Map<String, dynamic>).containsKey("meta") ? e.response!.data["meta"]["is_user_exist"] : false}");
      isUserExist = (e.response!.data as Map<String, dynamic>).containsKey("meta") ? e.response!.data["meta"]["is_user_exist"] : false;
      status_code = 400;
      break;
      case 401:
      // Un Authorized
      'Your Session has been Expired, Please Login Again.'.showToast;
      _logoutUser();
      msg = e.response!.data['message'];
      status_code = 401;
      break;
      case 403:
      // Forbidden
      msg = 'Forbidden Error';
      status_code = 403;
      break;
      case 404:
      // Not Found
      msg = 'Api Not Found';
      status_code = 404;
      break;
      case 500:
      // Internal Server Error
      msg = 'Server Error';
      status_code = 500;
      break;
      case 503:
      // Service Unavailable
      msg = 'Service Unavailable';
      status_code = 503;
      break;
      default:
      msg = 'Something went wrong';
      status_code = 600;
      break;
      }
      break;
      default:
      msg = 'Something went wrong';
      status_code = 601;
      break;
      }
      /*var dataToString = {
      "message": msg,
      "status_code": status_code,
      "is_user_exist": isUserExist
      };*/
      throw Exception(msg);
      } catch (e) {
        throw Exception('${e.toString()}');
      }
    }

  dynamic generateOtpForgotPass(params) async {
    try {
      var data = await hitApi(Constants.generateOtp,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }
  dynamic Registration(params) async {
    try {
      var data = await hitApi(Constants.register,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }



  dynamic generateOtpRegistration(params) async {
    try {
      var data = await hitApi(Constants.generateOtp,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }

  dynamic generateOtp(params, {accessToken}) async {
    try {
      var data = await hitApi(Constants.generateOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic checkOtp(params, {String? accessToken}) async {
    try {
      var data = await hitApi(Constants.checkOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    //search 가 쿼리, 즉 서치 파라미터
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${search.toString()}&country=(IN)&key=${key.toString()}';
    var json = await hitApi(url);
   // var json = convert.jsonDecode(response.body);
    var jsonResults =
    json['predictions'] as List; //API의 predictions object를 list로 가져옴
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
       // .get(Uri.parse(url)); //url 그냥 넣으면 오류 나서 Uri.parse 안에 넣음, 에러 나면 확인하기
    /*var json = convert.jsonDecode(response.body);
    var jsonResults =
    json['predictions'] as List; //API의 predictions object를 list로 가져옴
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();*/
  }

  Future<Place> getPlace(String placeId) async {
    //search 가 쿼리, 즉 서치 파라미터
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId';
    var json = await hitApi(url);
   // var json = convert.jsonDecode(response.r);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
       /* .get(Uri.parse(url)); //url 그냥 넣으면 오류 나서 Uri.parse 안에 넣음, 에러 나면 확인하기
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);*/
  }

  dynamic changePassword(params, accessToken) async {
    try {
      final data = await hitApi(Constants.changePassword,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());//
    }
  }



  dynamic doLogin(params) async {
    try {
      /* var deviceToken = await FirebaseMessaging.instance.getToken();
      params['device_token'] = (deviceToken != null && deviceToken.isNotEmpty) ? deviceToken : '';
      print('DeviceToken => ${params['device_token']}');*/

      var data = await hitApi(Constants.login,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getDetails(String token,int Id) async {
    try {
      var data = await hitApi(Constants.getProfile+Id.toString(), accessToken: token//, isDelete: false
      );
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  dynamic getBookedCab(String token) async {
    try {
      var data = await hitApi(Constants.getBookedCab, accessToken: token//, isDelete: false
      );
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic updateProfile(params,String token,int Id) async {
    try {
      var data = await hitApi(Constants.profileUpdate+Id.toString(),params: params, accessToken: token, isDelete: false);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic doNear(params,String token) async {
    try {
      /* var deviceToken = await FirebaseMessaging.instance.getToken();
      params['device_token'] = (deviceToken != null && deviceToken.isNotEmpty) ? deviceToken : '';
      print('DeviceToken => ${params['device_token']}');*/

      var data = await hitApi(Constants.getNearByDrivers,accessToken: token,isDelete: false,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic doFindCab(params,String token) async {
    try {
      /* var deviceToken = await FirebaseMessaging.instance.getToken();
      params['device_token'] = (deviceToken != null && deviceToken.isNotEmpty) ? deviceToken : '';
      print('DeviceToken => ${params['device_token']}');*/

      var data = await hitApi(Constants.getFindCab,accessToken: token,isDelete: false,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic requestNearCab(params,String token) async {
    try {
      var data = await hitApi(Constants.requestCab,accessToken: token,isDelete: false,
          params: params);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  dynamic userLogout(String token,) async {
    try {
      var data = await hitApi(Constants.logout, accessToken: token, isDelete: true);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /*dynamic updateProfile(params, accessToken) async {
    try {
      final data = await hitApi(Constants.updateProfile,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString().showToast);
    }
  }*/

  dynamic updateEmail(params, accessToken) async {
    try {
      final data = await hitApi(Constants.generateOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic updatePhone(params, accessToken) async {
    try {
      final data = await hitApi(Constants.generateOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic updateProfilePic(FormData params, String accessToken) async {
    try {
      final data = await hitApi(Constants.uploadProfilePic,
          params: params,
          accessToken: accessToken,
          options: Options(contentType: 'multipart/form-data'));
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic verifyOtp(params, accessToken) async {
    try {
      var data = await hitApi(Constants.checkOtp,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  _logoutUser() async {
    var result = await SharedPreferences.getInstance();
    await result.clear();
    // NavigationService().pushNamedAndRemoveUntil(login);
  }
}
