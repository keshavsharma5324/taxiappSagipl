/*import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:pubspec/models/place.dart';
//import 'package:pubspec/models/place_search.dart';
//import 'package:pubspec/services/geolocator_service.dart';
// import 'package:pubspec/services/places_service.dart';
import 'package:taxiapp/google%20map/models/place.dart';
import 'package:taxiapp/google%20map/models/place_search.dart';
import 'package:taxiapp/google%20map/services/geolocator_service.dart';
import 'package:taxiapp/google%20map/services/places_service.dart';
import 'package:taxiapp/screns/registerUser/nearby_state.dart';

class ApplicationBloc extends Cubit<ProfileState> {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

  //Variables
  late Position currentLocation;
  late List<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();

  ApplicationBloc(ProfileState initialState) : super(ProfileInitialState());

  /*ApplicationBloc() {
    setCurrentLocation();
  }*/

  void getNearbyDrivers(params, token) async {
    try {
      //emit(LoadingState());
      /* var deviceToken = '';
      FirebaseMessaging.instance.getToken().then((value) {
        deviceToken = value!;} ).catchError((onError){
      });params['device_token'] = (deviceToken != null && deviceToken.isNotEmpty) ? deviceToken : '';
      print('DeviceToken => ${params['device_token']}');
      */

      final result = await repo!.doNear(params, token); //doLogin(params);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  void setCurrentLocation() async {
    try{
    currentLocation = await geoLocatorService.getCurrentLocation();
    emit(GetProfileDataState(currentLocation));}
    catch(e){
      emit(ProfileErrorState(e.toString()));
//    notifyListeners();
  }}

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm) as List<PlaceSearch>;
//    notifyListeners();
  }

  //call from the view that will trigger the ,, get the place id, and pass it back and upadate the stream etc,,
  setSelectedLocation(String placeId) async {
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults = null as List<PlaceSearch>;
//    notifyListeners();
  }

  //@override
 /* void dispose() {
    selectedLocation.close();
    super.dispose();
  }*/
}*/
