//import 'package:cubit/cubit.dart';
//import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/base/base_state.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/base/base_state.dart';

class LoginCubit extends Cubit<BaseState> {
  LoginCubit({this.repo}) : super(InitialState());
  final BaseRepo? repo;
  //final ApiClient? repo;

  /*void generateOtp(params, {accessToken}) async {
    try {
      emit(LoadingState());
      final result = await repo!.generateOtp(params, accessToken: accessToken);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }

  void generateOtpRegisteration(params) async {
    try {
      emit(LoadingState());
      final result = await repo!.generateOtpRegistration(params);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }*/
  void Registeration(params) async {
    try {
      emit(LoadingState());
      final result = await repo!.Registration(params);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }
  void doLogin(params) async {
    try {
      emit(LoadingState());
     /* var deviceToken = '';
      FirebaseMessaging.instance.getToken().then((value) {
        deviceToken = value!;} ).catchError((onError){
      });params['device_token'] = (deviceToken != null && deviceToken.isNotEmpty) ? deviceToken : '';
      print('DeviceToken => ${params['device_token']}');
      */

      final result = await repo!.doLogin(params);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }


  void getPersonalDetails(String token,int id) async {
    try {
      emit(GettingDataState());
      final result = await repo!.getDetails(token,id);
      //print('${result.}');
      emit(UserDataSuccessState<dynamic>(response: result));
    //  print('${response.toString()}');
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }

  void doLogout(String token) async {
    try {
      emit(LoadingState());
      final result = await repo!.userLogout(token);
      emit(SignOutSuccessState(true));
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }
}
