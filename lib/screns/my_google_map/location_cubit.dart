//import 'package:booking_package/base/base_state.dart';
//import 'package:booking_package/models/response/cancel_reason_list_response.dart';
//import 'package:booking_package/models/response/direction_response.dart';
//import 'package:booking_package/models/response/driver_location_response.dart';
//import 'package:booking_package/models/response/location_bean.dart';
//import 'package:booking_package/models/response/ride_bean.dart';
//import 'package:booking_package/models/response/ride_response.dart';
//import 'package:booking_package/repo/booking_repo.dart';
//import 'package:booking_package/utils/shared_preference_utils.dart';
//import 'package:cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:taxiapp/base/base/base_state.dart';
import 'package:taxiapp/base/base_repo.dart';

import 'package:taxiapp/screns/registerUser/profile_state.dart';
import 'package:taxiapp/utils/shared_preference_utils.dart';

class LocationCubit extends Cubit<ProfileState> {
  LocationCubit({this.repo})
      : super(ProfileInitialState());
  final BaseRepo? repo;

  /*LocationCubit({this.repo, int? type}) : super(InitialState()) {
    if (type ==1) {
      print('####====>LocationCubit Called');
      _checkLocationService();
    } else if (type == 3) {
      getCancelReasons();
    }
  }*/

  /*void getNearByDrivers(Map<String, dynamic> params) async {
    try {
      emit(ProfileLoadingState());
      var accessToken = await SharedPreferenceUtils().getAccessToken();
      final result = await repo!.getNearByDrivers(params, accessToken);
      emit(SuccessState<DriverLocationResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.message.toString()));
    }
  }*/

  _checkLocationService() async {
    var isServiceEnabled = await Location().serviceEnabled();
    if (isServiceEnabled) {
      getCurrentLocation();
    }
    emit(ProfileSuccessState<bool>(isServiceEnabled));
  }

  void getCurrentLocation() async {
    try {
      var isServiceEnabled = await Location().serviceEnabled();
      if (!isServiceEnabled) {
        isServiceEnabled = await Location().requestService();
        if (isServiceEnabled) {
          _getLocationData();
        }
      } else {
        _getLocationData();
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  _getLocationData() async {
    var locationData = await Location().getLocation();
    print('####====>${locationData.toString()}');
    if (locationData != null) {
      emit(ProfileSuccessState<LocationData>(locationData));
    } else {
      emit(ProfileSuccessState<String>('unable to get current location'));
    }
  }

  /*void bookNow(Map<String, dynamic> params, LocationBean fromLocation,
      LocationBean toLocation) async {
    try {
      emit(LoadingState());
      var accessToken = await SharedPreferenceUtils().getAccessToken();
      final result =
      await repo.bookNow(accessToken, params, fromLocation, toLocation);
      emit(SuccessState<RideResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  void preBookRide(Map<String, dynamic> params, LocationBean fromLocation,
      LocationBean toLocation) async {
    try {
      emit(LoadingState());
      var accessToken = await SharedPreferenceUtils().getAccessToken();
      final result =
      await repo.preBookRide(accessToken, params, fromLocation, toLocation);
      emit(SuccessState<RideResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  void getRideDetails(Map<String, dynamic> map) {
    // Confirmed
    var result = RideBean.fromJson(map);
    emit(SuccessState<RideBean>(response: result));
  }

  void cancelRide(String rideId, int reasonId, {String from}) async {
    try {
      emit(LoadingState());
      var accessToken = await SharedPreferenceUtils().getAccessToken();
      final result = await repo.cancelRide(rideId, reasonId, accessToken, from: from);
      emit(SuccessState<RideResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  void getCancelReasons() async {
    try {
      emit(LoadingState());
      var accessToken = await SharedPreferenceUtils().getAccessToken();
      final result = await repo.getCancelReasons(accessToken);
      emit(SuccessState<CancelReasonListResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  void hitDirectionsApi(LatLng source, LatLng dest) async {
    try {
      // emit(LoadingState());
      final result = await repo.hitDirectionApi(source, dest);
      emit(SuccessState<DirectionResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  void doPayment(Map<String, dynamic> params) async {
    try {
      emit(LoadingState());
      var accessToken = await SharedPreferenceUtils().getAccessToken();
      final result = await repo.doPayment(accessToken, params);
      emit(SuccessState<RideResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }*/


}