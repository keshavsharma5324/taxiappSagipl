import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;

import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/google%20map/models/Search_places.dart';
import 'package:taxiapp/google%20map/models/place.dart';
import 'package:taxiapp/google%20map/models/place_search.dart';
import 'package:taxiapp/screns/booking/booking_state.dart';
//import 'package:taxiapp/screns/registerUser/Booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit({this.repo})
      : super(BookingInitialState());

  final BaseRepo? repo;

  void startRideDrivers(params, token) async {
    try {

      final result = await repo!.startRideRequest(params, token); //doLogin(params);
      emit(GetBookingDataState<dynamic>(result));
    } catch (e) {
      emit(BookingErrorState(e.toString()));
    }
  }

  void endRideDrivers(params, token) async {
    try {

      final result = await repo!.startEndRequest(params, token); //doLogin(params);
      emit(GetBookingDataState<dynamic>(result));
    } catch (e) {
      emit(BookingErrorState(e.toString()));
    }
  }







  Future<List<PlaceSearch>> getAutoCompletePlaces(String placesearch)async{
    final result;

    result = await repo!.getAutocomplete(placesearch) ;

    return result;
  }
  Future<Place> placeSearchDetails(String placesearch)async{

    final result= await repo!.getPlace(placesearch);

    return result;
  }


  updateBooking(params, String accessToken, int id) async {
    try {
      emit(BookingLoadingState());
      final result = await repo!.updateProfile(params, accessToken, id);
      emit(BookingSuccessState<dynamic>(result));
    } catch (e) {
      emit(BookingErrorState(e.toString()));
    }
  }
  /*_checkLocationService() async {
    var isServiceEnabled = await Location().serviceEnabled();
    if (isServiceEnabled) {
      getCurrentLocation();
    }
    emit(BookingSuccessState<bool>(isServiceEnabled));
  }*/

  Future<geo.Position> getCurrentLocation() async {
    return await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
  }

 /* _getLocationData() async {
    var locationData = await Location().getLocation();
    print('####====>${locationData.toString()}');
    if (locationData != null) {
      emit(BookingSuccessState<LocationData>(locationData));
    } else {
      emit(BookingSuccessState<String>('unable to get current location'));
    }
  }*/

}