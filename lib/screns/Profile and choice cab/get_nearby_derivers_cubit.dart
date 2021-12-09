import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/google%20map/models/Search_places.dart';
import 'package:taxiapp/google%20map/models/place.dart';
import 'package:taxiapp/google%20map/models/place_search.dart';
import 'package:taxiapp/screns/registerUser/profile_state.dart';

class NearbyDetailsCubit extends Cubit<ProfileState> {
  NearbyDetailsCubit({this.repo})
      : super(ProfileInitialState());

  final BaseRepo? repo;




  void getNearbyDrivers(params, token) async {
    try {

      final result = await repo!.doNear(params, token); //doLogin(params);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  void requestNearbyDrivers(params, token) async {
    try {

      final result = await repo!.requestNearCab(params, token); //doLogin(params);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
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


  updateProfile(params, String accessToken, int id) async {
    try {
      emit(ProfileLoadingState());
      final result = await repo!.updateProfile(params, accessToken, id);
      emit(ProfileSuccessState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
  _checkLocationService() async {
    var isServiceEnabled = await Location().serviceEnabled();
    if (isServiceEnabled) {
      getCurrentLocation();
    }
    emit(ProfileSuccessState<bool>(isServiceEnabled));
  }

  Future<geo.Position> getCurrentLocation() async {
    return await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
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

}