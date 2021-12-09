/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/route/route_generator.dart';
import 'package:taxiapp/screns/PaymentUI.dart';
import 'package:taxiapp/screns/Profile/profile_data_fetch.dart';
import 'package:taxiapp/screns/SignIn/login_screen.dart';
import 'package:taxiapp/screns/SignIn/register_screen.dart';
import 'package:taxiapp/screns/bookingconfirm.dart';
import 'package:taxiapp/screns/choicecab.dart';
import 'package:taxiapp/screns/homePage.dart';
import 'package:taxiapp/screns/SignIn/loginPage.dart';
import 'package:taxiapp/screns/home_screen.dart';
import 'package:taxiapp/screns/paymentScreen.dart';
import 'package:taxiapp/screns/SignIn/register.dart';
import 'package:taxiapp/screns/registerUser/personal_details_screen.dart';
import 'package:taxiapp/screns/searchcab.dart';
import 'package:taxiapp/screns/splashScreen.dart';
import 'package:taxiapp/screns/verifyOtp.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/ColorHelper.dart';
import 'package:taxiapp/utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: kPrimaryColor,
      //set Status bar color in Android devices.

      statusBarIconBrightness: Brightness.light,
      //set Status bar icons color in Android devices.

      statusBarBrightness:
      Brightness.dark) //set Status bar icon color in iOS.
  );
  runApp(MyApp());
}

//class MyApp extends StatelessWidget {
  class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  }

  class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.white12,
        overlayOpacity: 1,
        overlayWidget: Center(
        child: CircularProgressIndicator(
        valueColor:
        AlwaysStoppedAnimation<Color>(AppColors.themeLightGreen)),
    ),child:MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService().navigationKey,
      title: 'Taxi App',
      theme: ThemeData(
        fontFamily: 'Gilroy',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // initialRoute: login,
     // onGenerateRoute: RouteGenerator.generateRoute,
      /*debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),*/
      home: home_screen()///ProfileScreen()//MyHomePage(title: 'homepage'),
    )
    );
  }
}*/
import 'dart:async';

//import 'package:customer/route/route_constant.dart';
//import 'package:customer/route/route_generator.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/utils/AppUtils.dart';
//import 'package:customer/utils/ColorHelper.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:taxiapp/route/route_constant.dart';
//import 'package:socket_io_client/socket_io_client.dart';
import 'package:taxiapp/route/route_generator.dart';
import 'package:taxiapp/screns/Bitcoin_converter.dart';

import 'package:taxiapp/screns/google_map.dart';
import 'package:taxiapp/screns/map_page.dart';
import 'package:taxiapp/screns/splashScreen.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/ColorHelper.dart';

import 'local/preference_key.dart';
import 'local/taxi_uk_preference.dart';
import 'utils/app_colors.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: kPrimaryColor,
      //set Status bar color in Android devices.

      statusBarIconBrightness: Brightness.light,
      //set Status bar icons color in Android devices.

      statusBarBrightness:
      Brightness.dark) //set Status bar icon color in iOS.
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //
  //   getLoginStatus();
  // }
  //
  // Future<Null> getLoginStatus() async {
  //   var isLogin = await TaxiUKPrefs.instance.getLoginStatus();
  //   if (isLogin != null) {
  //     if (isLogin) {
  //       AppUtils.token = await TaxiUKPrefs.instance.getToken(tokenKey);
  //       NavigationService()
  //           .navigationKey
  //           .currentState
  //           .pushNamedAndRemoveUntil(dashboard, (route) => false);
  //     } else {
  //       NavigationService()
  //           .navigationKey
  //           .currentState
  //           .pushNamedAndRemoveUntil(login, (route) => false);
  //     }
  //   } else {
  //     NavigationService()
  //         .navigationKey
  //         .currentState
  //         .pushNamedAndRemoveUntil(registrationRoute, (route) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.white12,
        overlayOpacity: 1,
        overlayWidget: Center(
          child: CircularProgressIndicator(
              valueColor:
              AlwaysStoppedAnimation<Color>(AppColors.themeLightGreen)),
        ),
        child:MaterialApp(
         // home: BookRide(),
          debugShowCheckedModeBanner: false,
         navigatorKey: NavigationService().navigationKey,
          title: 'Taxi App',
          theme: ThemeData(
            fontFamily: 'Gilroy',
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),//home: KeyboardDemo(),
          initialRoute: login,
          onGenerateRoute: RouteGenerator.generateRoute,
        ));//);
  }
}


