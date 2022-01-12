//import 'package:cubit/cubit.dart';
//import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/personal_details/nearby_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/screns/registerUser/profile_state.dart';

class PersonalDetailsCubit extends Cubit<ProfileState> {
  PersonalDetailsCubit({this.repo ,this.accessToken}) : super(ProfileInitialState());

  final BaseRepo? repo;
  final String? accessToken;
  //final int? id;

  void getPersonalDetails(String accessTokenlogin,int id) async {
    try {
      // emit(GetOtpLoadingState());
      final result = await repo!.getDetails(accessTokenlogin,id);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
  void getNearbyDrivers(params,token) async {
    try {
      //emit(LoadingState());
      /* var deviceToken = '';
      FirebaseMessaging.instance.getToken().then((value) {
        deviceToken = value!;} ).catchError((onError){
      });params['device_token'] = (deviceToken != null && deviceToken.isNotEmpty) ? deviceToken : '';
      print('DeviceToken => ${params['device_token']}');
      */

      final result = await repo!.doNear(params,token);//doLogin(params);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

/*  updateProfilePic(params) async {
    try {
      emit(GetOtpLoadingState());
      final result = await repo!.updateProfilePic(params, accessToken!);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }*/

  updateProfile(params,String accessToken,int id) async {
    try {
      emit(ProfileLoadingState());
      final result = await repo!.updateProfile(params, accessToken,id);
      emit(ProfileSuccessState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

 /* updateEmail(params) async {
    try {
      emit(ProfileLoadingState());
      final result = await repo!.updateEmail(params, accessToken);
      emit(ProfileSuccessState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  updatePhone(params) async {
    try {
      emit(ProfileLoadingState());
      final result = await repo!.updatePhone(params, accessToken);
      emit(ProfileSuccessState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  verifyOtp(params) async {
    try {
      emit(GetOtpLoadingState());
      final result = await repo!.verifyOtp(params, accessToken);
      emit(ProfileUpdateVerifyState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }*/
}