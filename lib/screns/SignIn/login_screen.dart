
//import 'package:customer/route/route_constant.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/base/base_state.dart';
//import 'package:customer/ui/customviews/my_error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:taxiapp/screns/registerUser/personal_details_screen.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/AppUtils.dart';
import 'package:taxiapp/utils/Constant.dart';
import 'package:taxiapp/utils/constants.dart';
import 'package:taxiapp/utils/shared_preference_utils.dart';

//import '../../ui/login/login_cubit.dart';
import 'loginPage.dart';
import 'login_cubit.dart';
//import 'login_ui.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(repo: BaseRepo()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        body: BlocConsumer<LoginCubit, BaseState>(
            listener: (context, state) async {
              if (state is LoadingState) {
                print('loading Data');
               // showLoader("Logging In`......");

              }
              if (state is GettingDataState) {
                print('getting Data State');
                //showLoader("Getting data......");
              }

              if (state is SuccessState) {
                //print(loginResponse.success!.token);
                print('successstate');
               /* _globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["errors"][0]["msg"]
                    , "OK", _globalKey));*/

               // print('r54ggg');
                //print("this sample text"+state.response["errors"][0]["msg"]);
               // print(${state.reponse});
               // hideLoader();
               // print("Response Value -> ${state.response}");

                LoginResponse loginResponse = LoginResponse.fromJson(state.response);
              //  print(loginResponse.success.token);
                AppUtils.token = loginResponse.success.token!;
                TaxiUKPrefs.instance.saveSecureToken(tokenKey, loginResponse.success.token!);
               print(loginResponse.success);
                if(loginResponse.success != null){
                  var args =await {
                    "from": 'login',
                    "code": 'ffrr',
                    "user_id": loginResponse.success.userId,
                    "token": loginResponse.success.token
                  };
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('tokenValue',loginResponse.success.token!.toString().trim() );
                  prefs.setString('user_id',loginResponse.success.userId!.toString().trim() );
                  String stringValue = prefs.getString('tokenValue')!;
                  print('stringvalue  ${stringValue}');

                    print(prefs.getBool('newLaunch'));
                    if (prefs.containsKey("newLaunch")) {
                      prefs.setBool('newLaunch', false);
                    } else {
                      prefs.setBool('newLaunch', false);
                    }
                  NavigationService().navigationKey.currentState!.pushNamed(personalDetailsRoute, arguments: args);
                 // print(loginResponse.success.token);
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
                }
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
              if (state is AuthErrorState) {
                print('errorstate');
                //print("error => ${state.response}");
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
                    LoginPage(

                       /* onClick: (Map<String, dynamic> params) {
                          // NavigationService().navigationKey.currentState.pushNamed(login);
                          context.read<LoginCubit>().generateOtpRegisteration(params);
                        }*/),
                  ],
                )),
      ),
    );
  }
}
