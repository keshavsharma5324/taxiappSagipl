import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/Model/response/model/start_ride.dart';

import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/base/base_state.dart';

//import 'package:taxiapp/screns/Profile%20and%20choice%20cab/Nearby_Response.dart';
import 'package:taxiapp/screns/booking/booking_cubit.dart';
import 'package:taxiapp/screns/booking/booking_state.dart';
import 'package:taxiapp/screns/booking/endride.dart';
import 'package:taxiapp/screns/booking/navigation_route.dart';

import 'package:taxiapp/screns/registerUser/personal_details_screen.dart';

import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/AppUtils.dart';
import 'package:taxiapp/utils/Constant.dart';
import 'package:taxiapp/utils/constants.dart';
import 'package:taxiapp/utils/shared_preference_utils.dart';
import 'package:taxiapp/screns/drawer.dart';


class EndRideScreen extends StatefulWidget {
  //final dynamic? data;

  int? id;
  String? accesstoken;
  double? latitude,longitude,sourcelatitude,sourcelongitude;
  EndRideScreen({this.latitude,this.longitude,this.sourcelatitude,this.sourcelongitude,this.id,this.accesstoken});

  @override
  State<StatefulWidget> createState() => EndRideScreenState();
}

class EndRideScreenState extends State<EndRideScreen> {
  String? firstname;
  String? lastname;
  String? email;
  String? mobile;
  String? user_name;
  double? distance;
  double? longitude;
  double? latitude;
  int? id,userid;

  //token ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjMyNDg1NTUwLCJleHAiOjE2MzI1NzE5NTB9.Pq1kqi_BeF_IWI_4ZrXhisWXICvYJO5i5fGsDR6oPIw';


  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit(repo: BaseRepo()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        body: BlocConsumer<BookingCubit, BookingState>(
            listener: (context, state) {
              if (state is BookingLoadingState) {
                //showLoader("Updating profile.......");
              }
              if (state is GetOtpLoadingState) {
                showLoader("Uploading picture.......");
              }
              if (state is GetBookingDataState) {
                //hideLoader();
                // print("Picture updated successfully....");
                FocusScope.of(context).requestFocus(FocusNode());
                _globalKey.currentState!.showSnackBar(getSnackBar(
                    "End Ride", "OK", _globalKey));

                /*   NearbyResponse profileResponse = NearbyResponse.fromJson(state.response);
                print(state.response);
                // id = profileResponse.success!.users![0].id!;

                distance = profileResponse.success!.users![0].distance!;
                id = profileResponse.success!.users![0].id!;
                latitude = profileResponse.success!.users![0].latitude!;
                longitude = profileResponse.success!.users![0].longitude!;*/
                /*firstname = profileResponse.success!.users![0].firstName!;
                lastname = profileResponse.success!.users![0].lastName!;
                email = profileResponse.success!.users![0].email!;
                mobile = profileResponse.success!.users![0].mobile!;
                user_name = profileResponse.success!.users![0].username!;
                latitude = profileResponse.success!.users![0].latitude!;
                longitude = profileResponse.success!.users![0].longitude!;*/
                // print('   edewiode m  $firstname + $lastname + $email + $mobile');
              }
              if(state is BookingSuccessState){
                print(state.response);
              }

              /*if (state is SuccessState) {
    print('successstate');
    _globalKey.currentState!.showSnackBar(getSnackBar(
    state.response["errors"][0]["msg"]
    , "OK", _globalKey));

    // print('r54ggg');
    print("this sample text"+state.response["errors"][0]["msg"]);
    //print(${response.state});
    hideLoader();
    //print("Response Value -> ${state.response}");

    ProfileResponse loginResponse = ProfileResponse.fromMap(state.response);
    AppUtils.token = loginResponse.success!.token!;
    TaxiUKPrefs.instance.saveSecureToken(tokenKey, loginResponse.success!.token!);

    if(loginResponse.success != null){
    //NavigationService().navigationKey.currentState!.pushNamed(PersonalDetailsScreen, arguments: );
    }
    else{



    /*if(loginResponse.data!.stage == Constants.passengerStagePersonalDetailCompleted){
                    TaxiUKPrefs.instance.saveLoginStatus(true);
                    SharedPreferenceUtils().saveUserData(loginResponse!.data!);
                    NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(dashboard, (route) => false);

                  }else if(loginResponse.data!.stage == Constants.passengerStagePasswordCreated){
                    _globalKey.currentContext!.read<LoginCubit>().getPersonalDetails(loginResponse.data!.token.toString());
                  }else{

                     }*/
    }
    }*/
              /*RegisterResponse registerResponse = RegisterResponse.fromMap(state.response);
                if(registerResponse.isSuccess){
                  var args = {
                    "from": 'login',
                    "code": '',
                    "mobile": registerResponse.data.phone_number,
                    "ext": registerResponse.data.ext,
                   // "type": Constants.loginTypeRegistration
                  };
                  NavigationService().navigationKey.currentState!.pushNamed(otpRoute, arguments: args);
                }*//*else{
                 if(registerResponse.meta != null){
                   if(!registerResponse.meta.is_user_exist){
                     var args = {
                       "from": 'login',
                       "code": '',
                       "mobile": registerResponse.data.phone_number,
                       "ext": registerResponse.data.ext,
                       //"type": Constants.loginTypeRegistration
                     };
                     NavigationService().navigationKey.currentState!.pushNamed(otpRoute, arguments: args);
                   } else{
                     NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
                   }
                 }
                }
              }*/
              /* if(state is UserDataSuccessState){
                hideLoader();
                ProfileResponse profileResponse = ProfileResponse.fromMap(state.response);
                AppUtils.userData = profileResponse.data;
                AppUtils.fname = (AppUtils.userData!.fname == null ? "" : AppUtils.userData!.fname)!;
                var data = {"fromPage": "register"};
                NavigationService().navigationKey.currentState!.pushNamed(personalDetailsRoute, arguments: data);
              }*/

              if (state is BookingErrorState) {
                print("error => ${state.response}");
                hideLoader();
                FocusScope.of(context).requestFocus(FocusNode());
                _globalKey.currentState!.showSnackBar(
                    getSnackBar(state.response["message"], "OK", _globalKey));
              }

              /*if (state is AuthErrorState) {
                print("error => ${state.response}");
                hideLoader();
                FocusScope.of(context).requestFocus(FocusNode());
                if(state.response["is_user_exist"]){
                  NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
                }
                _globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["message"], "OK", _globalKey));
              }*/
            },
            listenWhen: (previous, current) => previous != current,
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => Stack(
              children: [
                EndRide(accesstoken: widget.accesstoken!,id: widget.id!,latitude: widget.latitude,longitude: widget.longitude,sourcelatitude: widget.sourcelatitude,sourcelongitude: widget.sourcelongitude,droplatitude: latitude,droplongitude: longitude)


              ],
            )),
      ),
    );
  }
}