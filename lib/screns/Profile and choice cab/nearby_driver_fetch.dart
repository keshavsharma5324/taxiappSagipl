/*
//import 'package:customer/route/route_constant.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/base/base_state.dart';
//import 'package:customer/ui/customviews/my_error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/Model/response/model/auth/login_response.dart';
import 'package:taxiapp/Model/response/model/profile/profile_response.dart';
//import 'package:flutter_cubit/flutter_cubit.dart';
//import 'package:customer/utils/Constant.dart';
//import 'package:customer/model/auth/register_response.dart';
//import 'package:customer/utils/constants.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/base/base_state.dart';
import 'package:taxiapp/local/preference_key.dart';
import 'package:taxiapp/local/taxi_uk_preference.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/Profile/choicecab.dart';
import 'package:taxiapp/screns/Profile/get_nearby_derivers_cubit.dart';
import 'package:taxiapp/screns/registerUser/personal_details_screen.dart';
import 'package:taxiapp/screns/registerUser/booking_state.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/AppUtils.dart';
import 'package:taxiapp/utils/Constant.dart';
import 'package:taxiapp/utils/constants.dart';
import 'package:taxiapp/utils/shared_preference_utils.dart';

//import '../../ui/login/login_cubit.dart';
import 'Nearby_Response.dart';
//import 'loginPage.dart';
//import 'login_cubit.dart';
//import 'login_ui.dart';

class NearbyScreen extends StatefulWidget {
  final dynamic? data;
  NearbyScreen({this.data});

  @override
  State<StatefulWidget> createState() => NearbyScreenState();
}

class NearbyScreenState extends State<NearbyScreen> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NearbyDetailsCubit(repo: BaseRepo()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        body: BlocConsumer<NearbyDetailsCubit, ProfileState>(
            listener: (context, state) async {
              if (state is LoadingState) {
                print('loading Data');
                // showLoader("Logging In`......");

              }
              if (state is GettingDataState) {
                print('getting Data State');
                //showLoader("Getting data......");
              }

              if (state is GetProfileDataState) {
                //print(loginResponse.success!.token);
                print('successstate');
                /* _globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["errors"][0]["msg"]
                    , "OK", _globalKey));*/

                // print('r54ggg');
                //print("this sample text"+state.response["errors"][0]["msg"]);
               // print(state.reponse);
                // hideLoader();
                 print("Response Value -> ${state.response}");

                NearbyResponse loginResponse = NearbyResponse.fromJson(state.response);}
                // print(state.);
               /* AppUtils.token = loginResponse.success.token!;
                TaxiUKPrefs.instance.saveSecureToken(tokenKey, loginResponse.success.token!);
                print(loginResponse.success);
                if(loginResponse.success != null){
                  var args =await {
                    "from": 'login',
                    "code": 'ffrr',
                    "user_id": loginResponse.success.userId,
                    "token": loginResponse.success.token
                  };
                  // print(loginResponse.success.token);
                  NavigationService().navigationKey.currentState!.pushNamed(personalDetailsRoute, arguments: args);
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

              if (state is ProfileErrorState) {
                print('errorstate');
                print("error => ${state.response}");
                hideLoader();
                NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
                //Navigator.pop(context);
                //FocusScope.of(context).requestFocus(FocusNode());
                /*_globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["errors"][0]["msg"]
                    , "OK", _globalKey));*/
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
                BookRide(latitude: widget.data['latitude'],accesstoken:widget.data['accesstoken'],id:widget.data['id'],longitude:widget.data['longitude'],

                   getnearby: () {
                 // print('${widget.data['latitude']}  ijfoef3ijf');
                          // NavigationService().navigationKey.currentState.pushNamed(login);
                          context.read<NearbyDetailsCubit>().getNearbyDrivers({
                         //   "email": phone,
                          //  "password": password,
                            "user_id": widget.data['id'],
                            "latitude": widget.data['latitude'],//latitude,
                            "longitude": widget.data['longitude']//identifier
                            //"ext": Constants.defaultCountryCode,
                            //"user_type": Constants.userTypePassenger,
                          }, widget.data['token']);//.generateOtpRegisteration(params:);
                        }),
              ],
            )),
      ),
    );
  }
}
*/

//import 'package:customer/route/route_constant.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/base/base_state.dart';
//import 'package:customer/ui/customviews/my_error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:taxiapp/Model/response/model/auth/login_response.dart';
//import 'package:taxiapp/Model/response/model/profile/profile_response.dart';
//import 'package:flutter_cubit/flutter_cubit.dart';
//import 'package:customer/utils/Constant.dart';
//import 'package:customer/model/auth/register_response.dart';
//import 'package:customer/utils/constants.dart';
import 'package:taxiapp/base/base_repo.dart';
//import 'package:taxiapp/base/base_state.dart';
import 'package:taxiapp/local/preference_key.dart';
import 'package:taxiapp/local/taxi_uk_preference.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/Profile%20and%20choice%20cab/Nearby_Response.dart';

import 'package:taxiapp/screns/registerUser/personal_details_screen.dart';
import 'package:taxiapp/screns/registerUser/profile_state.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/AppUtils.dart';
import 'package:taxiapp/utils/Constant.dart';
import 'package:taxiapp/utils/constants.dart';
import 'package:taxiapp/utils/shared_preference_utils.dart';
import 'package:taxiapp/screns/drawer.dart';
//import '../../ui/login/login_cubit.dart';
//import 'loginPage.dart';
//import 'login_cubit.dart';
//import 'login_ui.dart';
import 'choicecab.dart';
import 'get_nearby_derivers_cubit.dart';
import 'personal_details_cubit.dart';

class NearbyScreen extends StatefulWidget {
  final dynamic? data;
  int? id;
  NearbyScreen({this.data,this.id});

  @override
  State<StatefulWidget> createState() => NearbyScreenState();
}

class NearbyScreenState extends State<NearbyScreen> {
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
      create: (context) => NearbyDetailsCubit(repo: BaseRepo()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        body: BlocConsumer<NearbyDetailsCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadingState) {
                //showLoader("Updating profile.......");
              }
              if (state is GetOtpLoadingState) {
                showLoader("Uploading picture.......");
              }
              if (state is GetProfileDataState) {
                //hideLoader();
                // print("Picture updated successfully....");
                FocusScope.of(context).requestFocus(FocusNode());
                _globalKey.currentState!.showSnackBar(getSnackBar(
                    "Picture updated successfully", "OK", _globalKey));
                NearbyResponse profileResponse = NearbyResponse.fromJson(state.response);
                print(state.response);
               // id = profileResponse.success!.users![0].id!;

                distance = profileResponse.success!.users![0].distance!;
                id = profileResponse.success!.users![0].id!;
                latitude = profileResponse.success!.users![0].latitude!;
                longitude = profileResponse.success!.users![0].longitude!;
                /*firstname = profileResponse.success!.users![0].firstName!;
                lastname = profileResponse.success!.users![0].lastName!;
                email = profileResponse.success!.users![0].email!;
                mobile = profileResponse.success!.users![0].mobile!;
                user_name = profileResponse.success!.users![0].username!;
                latitude = profileResponse.success!.users![0].latitude!;
                longitude = profileResponse.success!.users![0].longitude!;*/
                // print('   edewiode m  $firstname + $lastname + $email + $mobile');
              }
              if(state is ProfileSuccessState){
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

              if (state is ProfileErrorState) {
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
                BookRide(distance: distance,latitude: latitude,accesstoken:widget.data['token'],userid: int.parse(widget.data['user_id']),driverid: id,longitude: longitude,

                    getnearby: () {

                      // print('${widget.data['latitude']}  ijfoef3ijf');
                      // NavigationService().navigationKey.currentState.pushNamed(login);
                      context.read<NearbyDetailsCubit>().getNearbyDrivers({
                        //   "email": phone,
                        //  "password": password,
                        "user_id": widget.data['user_id'],
                        "latitude": widget.data['latitude'],//latitude,
                        "longitude": widget.data['longitude']//identifier
                        //"ext": Constants.defaultCountryCode,
                        //"user_type": Constants.userTypePassenger,
                      }, widget.data['token']);//.generateOtpRegisteration(params:);
                    }),
                /*CustomDrawer(fname: firstname,lname: lastname,email: email,number: mobile,latitude: latitude,longitude: longitude,accesstoken: widget.data['token'],id: widget.data['user_id'].toString(),username: user_name,

                    onClick: () {print('${widget.data['token']} ffffffffff');
                    // NavigationService().navigationKey.currentState.pushNamed(login);
                    context.watch<PersonalDetailsCubit>().getPersonalDetails//('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjMyNzE3MzU2LCJleHAiOjE2MzI4MDM3NTZ9.d9F6tTjE_goi8U4fmc_pZ5yDlT1d140Kqc1-4QXBNcY',2);//
                      (widget.data['token'],widget.data['user_id']);//generateOtpRegisteration(params);
                    },onClickUpdate: (Map<String, dynamic> params){
                      // NavigationService().navigationKey.currentState.pushNamed(login);
                      context.read<PersonalDetailsCubit>().updateProfile(params, widget.data['token'], widget.data['user_id']);
                    }),*/

              ],
            )),
      ),
    );
  }
}

