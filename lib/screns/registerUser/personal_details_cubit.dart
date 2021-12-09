//import 'package:cubit/cubit.dart';
import 'package:bloc/bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/personal_details/profile_state.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/screns/registerUser/profile_state.dart';


class PersonalDetailsCubit extends Cubit<ProfileState> {
  PersonalDetailsCubit( {this.repo, this.accessToken}) : super(ProfileInitialState());

  final BaseRepo? repo;
  final String? accessToken;
  //final result;

  /*void getPersonalDetails() async {
    try {
      // emit(GetOtpLoadingState());
      final result = await repo!.getDetails(accessToken);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.message));
    }
  }

  updateProfilePic(params) async {
    try {
      emit(GetOtpLoadingState());
      final result = await repo.updateProfilePic(params, accessToken);
      emit(GetProfileDataState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.message));
    }
  }*/

  /*updateProfile(params) async {
    try {
      emit(ProfileLoadingState());
      final result = await repo!.updateProfile(params, accessToken);

      emit(ProfileSuccessState<dynamic>(result));
      //print(result.body);
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }*/

  /*updateEmail(params) async {
    try {
      emit(ProfileLoadingState());
      final result = await repo.updateEmail(params, accessToken);
      emit(ProfileSuccessState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.message));
    }
  }*/

 /* updatePhone(params) async {
    try {
      emit(ProfileLoadingState());
      final result = await repo.updatePhone(params, accessToken);
      emit(ProfileSuccessState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.message));
    }
  }

  verifyOtp(params) async {
    try {
      emit(GetOtpLoadingState());
      final result = await repo.verifyOtp(params, accessToken);
      emit(ProfileUpdateVerifyState<dynamic>(result));
    } catch (e) {
      emit(ProfileErrorState(e.message));
    }
  }*/
}
