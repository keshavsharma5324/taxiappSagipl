import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/google%20map/models/Search_places.dart';
import 'package:taxiapp/google%20map/models/place.dart';
import 'package:taxiapp/google%20map/models/place_search.dart';
import 'package:taxiapp/screns/booking/booking_state.dart';
//import 'package:taxiapp/screns/registerUser/Booking_state.dart';

class BookingConfirmCubit extends Cubit<BookingState> {
  BookingConfirmCubit({this.repo})
      : super(BookingInitialState());

  final BaseRepo? repo;

  void getDriverDetails(token)async{
    try{
      final result = await repo!.getBookedCab(token);
      emit(GetBookingDataState<dynamic>(result));
    }catch(e){
      emit(BookingErrorState(e.toString()));
    }
  }




 /* void getNearbyDrivers(params, token) async {
    try {

      final result = await repo!.doFindCab(params, token); //doLogin(params);
      emit(GetBookingDataState<dynamic>(result));
    } catch (e) {
      emit(BookingErrorState(e.toString()));
    }
  }



  void requestNearbyDrivers(params, token) async {
    try {

      final result = await repo!.requestNearCab(params, token); //doLogin(params);
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
  _checkLocationService() async {
    var isServiceEnabled = await Location().serviceEnabled();
    if (isServiceEnabled) {
      getCurrentLocation();
    }
    emit(BookingSuccessState<bool>(isServiceEnabled));
  }

  Future<geo.Position> getCurrentLocation() async {
    return await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
  }

  _getLocationData() async {
    var locationData = await Location().getLocation();
    print('####====>${locationData.toString()}');
    if (locationData != null) {
      emit(BookingSuccessState<LocationData>(locationData));
    } else {
      emit(BookingSuccessState<String>('unable to get current location'));
    }
  }*/

}