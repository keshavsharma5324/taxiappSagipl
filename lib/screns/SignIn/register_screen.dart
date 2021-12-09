
//import 'package:customer/route/route_constant.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/base/base_state.dart';
//import 'package:customer/ui/customviews/my_error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:customer/utils/Constant.dart';
//import 'package:customer/model/auth/register_response.dart';
//import 'package:customer/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/Model/response/model/auth/register_response.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/base/base_state.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/SignIn/register.dart';
//import 'package:taxiapp/screns/SignIn/register.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/Constant.dart';

//import '../../ui/login/login_cubit.dart';
import 'login_cubit.dart';
//import 'login_ui.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(repo: BaseRepo()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        body: BlocConsumer<LoginCubit, BaseState>(
            listener: (context, state) {
              if (state is LoadingState) {
                //showLoader("Checking user......");
              }

              if (state is SuccessState){

                //hideLoader();
                print('successstate');
             //   ScaffoldMessenger.of(context).showMaterialBanner(
                    /*MaterialBanner(
                      content: Text(state.response["errors"][0]["msg"].toString()),
                      leading: const Icon(Icons.info),
                      backgroundColor: Colors.yellow,
                      actions: [
                        TextButton(
                          child: const Text('Dismiss'),
                          onPressed: () =>
                              Navigator.of(context).pop()//ScaffoldMessenger.of(context)
                              //hideCurrentMaterialBanner(),
                        ),
                      ],
                    );*/
              /* if(state.response["errors"][0]["msg"]!=null){
                _globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["errors"][0]["msg"]!=null?state.response["errors"][0]["msg"]:state.response["success"]["msg"]
                    , "OK", _globalKey));}
               else{
                 NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
               }*/


                print("Response Value -> ${state.response}");
                RegisterResponse registerResponse = RegisterResponse.fromJson(state.response);


                /*_globalKey.currentState!.showSnackBar(getSnackBar(
                    registerResponse.success!.msg.toString()//["success"][0]["msg"]
                    , "OK", _globalKey)):print('fff');*/
                //hideLoader()

    //if(registerResponse.success!.msg==null){
     /* _globalKey.currentState!.showSnackBar(getSnackBar(
          state.response["errors"][0]["msg"]
          , "OK", _globalKey));*/
    //}
                //else{
            /*      _globalKey.currentState!.showSnackBar(getSnackBar(
                      state.response["errors"][0]["msg"]
                      , "OK", _globalKey));//}*/
                /*if(registerResponse.success != null){
                  var args = {
                    "from": 'login',
                    "code": '',
                    "mobile": registerResponse.data.phone_number,
                    "ext": registerResponse.data.ext,
                    "type": Constants.loginTypeRegistration
                  };
                  NavigationService().navigationKey.currentState!.pushNamed(otpRoute, arguments: args);
                }else{
                  if(registerResponse.meta != null){
                    if(!registerResponse.meta.is_user_exist){
                      var args = {
                        "from": 'login',
                        "code": '',
                        "mobile": registerResponse.data.phone_number,
                        "ext": registerResponse.data.ext,
                        "type": Constants.loginTypeRegistration
                      };
                      NavigationService().navigationKey.currentState.pushNamed(otpRoute, arguments: args);
                    } else{
                      NavigationService().navigationKey.currentState.pushNamedAndRemoveUntil(login, (Route route) => false);
                    }
                  }
                }*/
              }

              if (state is AuthErrorState) {
                print("error => ${state.response}");
                //hideLoader();
               /* _globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["errors"][0]["msg"]
                    , "OK", _globalKey));*/
               /* FocusScope.of(context).requestFocus(FocusNode());
                if(state.response["is_user_exist"]){
                  NavigationService().navigationKey.currentState.pushNamedAndRemoveUntil(login, (Route route) => false);
                }
                _globalKey.currentState.showSnackBar(getSnackBar(
                    state.response["message"], "OK", _globalKey));*/
              }
            },
            listenWhen: (previous, current) => previous != current,
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => Stack(
              children: [
                Register(
                    onClick: (Map<String, dynamic> params){
                      // NavigationService().navigationKey.currentState.pushNamed(login);
                      context.read<LoginCubit>().Registeration(params);
                    }),
              ],
            )),
      ),
    );
  }
}
