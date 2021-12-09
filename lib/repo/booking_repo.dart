import 'dart:io';

//import 'package:booking_package/models/response/cancel_reason_list_response.dart';
//import 'package:booking_package/models/response/direction_response.dart';
//import 'package:booking_package/models/response/driver_location_response.dart';
//import 'package:booking_package/models/response/location_bean.dart';
//import 'package:booking_package/models/response/master_response.dart';
//import 'package:booking_package/models/response/ride_response.dart';
//import 'package:booking_package/ui/my_address/my_address_response.dart';
//import 'package:booking_package/ui/my_journey/my_journey_response.dart';
//import 'package:booking_package/ui/pre_book/pre_book_response.dart';
//import 'package:customer/utils/constants.dart';
import 'package:dio/dio.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:customer/utils/my_extentions.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:customer/route/route_constant.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/ui/manage_cards/manage_cards_response.dart';
import 'package:taxiapp/Model/master_response.dart';
import 'package:taxiapp/Model/response/cancel_reason_list_response.dart';
import 'package:taxiapp/Model/response/direction_response.dart';
import 'package:taxiapp/Model/response/driver_location_response.dart';
import 'package:taxiapp/Model/response/location_bean.dart';
import 'package:taxiapp/Model/response/manage_cards_response.dart';
import 'package:taxiapp/Model/response/my_address_response.dart';
import 'package:taxiapp/Model/response/my_journey_response.dart';
import 'package:taxiapp/Model/response/pre_book_response.dart';
import 'package:taxiapp/Model/response/ride_response.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/constants.dart';
import 'package:taxiapp/utils/my_extentions.dart';


class BookingRepo {
  static final BookingRepo _baseRepo = BookingRepo._internal();

  Dio? _dio;

  factory BookingRepo() => _baseRepo;

  BookingRepo._internal();

  dynamic hitApi(String api,
      {dynamic params,
      String? accessToken,
      Options? options,
      bool? isDelete,
      dynamic? queryParameters,
      bool? isDirectionApi}) async {
    if (_dio == null) {
      _dio = Dio();
    }
    var url = isDirectionApi == null
        ? Constants.baseUrl
        : Constants.googleDirectionsApi;

    // Add options
    _dio!
      ..options.baseUrl = url
      ..options.connectTimeout = Duration.millisecondsPerMinute
      ..options.receiveTimeout = Duration.millisecondsPerMinute;

    _dio!.interceptors.clear();
    _dio!.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        requestBody: true));


    _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,handler) async {
            if (accessToken != null )
              options.headers['content-Type'] = 'application/x-www-form-urlencoded';
            options.headers['x-access-token'] = '$accessToken';
            return handler.next(options);
          },));

   /* if (accessToken != null) {
      // Add Authorization
      _dio!.interceptors
          .add(InterceptorsWrapper
        (onRequest: (request, handler) {
        //if (token != null && token != '')
         var customHeaders= request.headers['Authorization'] = 'Bearer $accessToken';
         options!.headers!.addAll(customHeaders as Map<String,dynamic>);
        return handler.next(request);
      },/*(onRequest: (RequestOptions options) async {
        var customHeaders = {'Authorization': 'Bearer $accessToken'};
        options.headers.addAll(customHeaders);
        return options;
      }*/));
    }*/

    try {
      if (params != null) {
        // Post Api
        final response = await _dio!.post(api, data: params, options: options);
        return response.data;
      } else if (isDelete != null) {
        // Delete Api
        final response = await _dio!.delete(api);
        return response.data;
      } else if (queryParameters != null) {
        // Get Api using Query Parameters
        final response = await _dio!.get(api, queryParameters: queryParameters);
        return response.data;
      } else {
        // Get Api
        final response = await _dio!.get(api);
        return response.data;
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on DioError catch (e) {
      var msg = '';
      switch (e.type) {
        case DioErrorType.cancel:
          msg = 'Request Cancelled';
          break;
        case DioErrorType.connectTimeout:
          msg = 'Connection Timeout';
          break;
        case DioErrorType.receiveTimeout:
          msg = 'Connection Timeout';
          break;
        case DioErrorType.sendTimeout:
          msg = 'Connection Timeout';
          break;
        case DioErrorType.other:
          msg = 'No Internet Connection';
          break;
        case DioErrorType.response:
          switch (e.response!.statusCode) {
            case 302:
              // Bearer Token Missing
              'Your Session has been Expired, Please Login Again.'.showToast;
              _logoutUser();
              msg = 'Invalid Request';
              break;
            case 400:
              // Bad Request
              msg = e.response!.data['message'];
              break;
            case 401:
              // Un Authorized
              'Your Session has been Expired, Please Login Again.'.showToast;
              _logoutUser();
              msg = e.response!.data['message'];
              break;
            case 403:
              // Forbidden
              msg = 'Forbidden Error';
              break;
            case 404:
              // Not Found
              msg = 'Api Not Found';
              break;
            case 500:
              // Internal Server Error
              msg = 'Server Error';
              break;
            case 503:
              // Service Unavailable
              msg = 'Service Unavailable';
              break;
            default:
              msg = 'Something went wrong';
              break;
          }
          break;
        default:
          msg = 'Something went wrong';
          break;
      }
      throw Exception(msg);
    } catch (e) {
      throw Exception('${e.toString()}');
    }
  }

  Future<MasterResponse> getTaxiList(String accessToken) async {
    try {
      var data = await hitApi(Constants.getTaxiList, accessToken: accessToken);
      return MasterResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic bookNow(String accessToken, Map<String, dynamic> params,
      LocationBean fromLocation, LocationBean toLocation) async {
    try {
      var result = await hitApi(
          '&origin=${fromLocation.latitude},${fromLocation.longitude}&destination=${toLocation.latitude},${toLocation.longitude}&key=${Constants.apiKey}',
          isDirectionApi: true);
      var res = DirectionResponse.fromJson(result);

      params['distance'] = ((res.routes![0].legs![0].distance!.value!/1000) * Constants.kmToMiles).toString();
      params['time'] = res.routes![0].legs![0].duration!.text;

      var data = await hitApi(Constants.bookNow,
          params: params, accessToken: accessToken);
      return RideResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getCancelReasons(accessToken) async {
    try {
      var data =
          await hitApi(Constants.getCancelReasons, accessToken: accessToken);
      return CancelReasonListResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic cancelRide(String rideId, int reasonId,  String accessToken, {String? from}) async {
    try {
      Map<String, dynamic> params = {"reason_id": reasonId};
      if (from!= null) params['type'] = from;

      var data = await hitApi('${Constants.cancelRide}/$rideId',
          accessToken: accessToken,
          params: params
          );
      return RideResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic preBookRide(String accessToken, Map<String, dynamic> params,
      LocationBean fromLocation, LocationBean toLocation) async {
    try {
      var result = await hitApi(
          '&origin=${fromLocation.latitude},${fromLocation.longitude}&destination=${toLocation.latitude},${toLocation.longitude}&key=${Constants.apiKey}',
          isDirectionApi: true);
      var res = DirectionResponse.fromJson(result);

      params['distance'] = res.routes![0].legs![0].distance!.value.toString();
      params['time'] = res.routes![0].legs![0].duration!.value.toString();

      var data = await hitApi(Constants.preBookRide,
          params: params, accessToken: accessToken);
      return RideResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

 /* dynamic hitDirectionApi(LatLng source, LatLng dest) async {
    try {
      var result = await hitApi(
          '&origin=${source.latitude},${source.longitude}&destination=${dest.latitude},${dest.longitude}&key=${Constants.apiKey}',
          isDirectionApi: true);
      return DirectionResponse.fromJson(result);
    } catch (e) {
      throw Exception(e.toString());
    }
  }*/

  dynamic doPayment(String accessToken, Map<String, dynamic> params) async {
    try {
      var data = await hitApi(Constants.doPayment,
          params: params, accessToken: accessToken);
      return RideResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic rateYourRide(String accessToken, Map<String, dynamic> params) async {
    try {
      var data = await hitApi(Constants.rateYourRide,
          params: params, accessToken: accessToken);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getNearByDrivers(Map<String, dynamic> params, accessToken) async {
    try {
      var data = await hitApi(Constants.getNearByDrivers, params: params, accessToken: accessToken);
      return DriverLocationResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getPreBookJobs(String accessToken) async {
    try {
      var data = await hitApi(Constants.getPreBookJobs, accessToken: accessToken);
      return PreBookResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

dynamic getInstantRidesList(String accessToken) async {
    try {
      var data = await hitApi(Constants.getInstantRidesList, accessToken: accessToken);
      var res = MyJourneyResponse.fromJson(data);
      res.isInstant = true;
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getPreBookRidesList(String accessToken) async {
    try {
      var data = await hitApi(Constants.getPreBookRidesList, accessToken: accessToken);
      var res = MyJourneyResponse.fromJson(data);
      res.isInstant = false;
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic getMyAddress(String accessToken) async {
    try {
      var data = await hitApi(Constants.getMyAddress, accessToken: accessToken);
      var res = MyAddressResponse.fromJson(data);
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic deleteAddress(String accessToken, String id) async {
    try {
      var data = await hitApi('${Constants.deleteAddress}/$id', isDelete: true,accessToken: accessToken);
      var res = data;
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic addAddress(String accessToken, params) async {
    try {
      var data = await hitApi(Constants.addAddress, accessToken: accessToken, params: params);
      var res = data;
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  dynamic addCard(String accessToken, params) async {
    try {
      var data = await hitApi(Constants.addCard, accessToken: accessToken, params: params);
      var res = data;
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

 dynamic getCards(String accessToken) async {
    try {
      var data = await hitApi(Constants.getCards, accessToken: accessToken);
      return ManageCardResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic deleteCard(String accessToken, params) async {
    try {
      var data = await hitApi(Constants.deleteCard, accessToken: accessToken, params: params);
      return ManageCardResponse.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic setDefaultPaymentMethod(String accessToken, params) async {
    try {
      var data = await hitApi(Constants.setDefaultPaymentMethod, accessToken: accessToken, params: params);

      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  _logoutUser() async {
    var result = await SharedPreferences.getInstance();
    await result.clear();
    NavigationService().pushNamedAndRemoveUntil(login);
  }

}
