//import 'package:booking_package/notification/push_notification_manager.dart';
/*import 'package:customer/lifecycle/lifecycle_watcher.dart';
import 'package:customer/local/preference_key.dart';
import 'package:customer/local/taxi_uk_preference.dart';
import 'package:customer/model/auth/User.dart';
import 'package:customer/model/profile/profile_response.dart';
import 'package:customer/route/route_constant.dart';
import 'package:customer/service/navigation_service.dart';
import 'package:customer/ui/base/base_repo.dart';
//import 'package:customer/ui/customviews/my_error_dialog.dart';
//import 'package:customer/ui/dialog/logout_dialog.dart';
import 'package:customer/utils/constants.dart';
import 'package:customer/utils/AppUtils.dart';
import 'package:customer/utils/ColorHelper.dart';
import 'package:customer/utils/Constant.dart';
//import 'package:customer/utils/Gap.dart';
//import 'package:customer/utils/ImageHelper.dart';
import 'package:customer/utils/shared_preference_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:customer/ui/personal_details/frag/dashboard_cubit.dart';
import 'package:customer/ui/personal_details/booking_state.dart';
import 'package:booking_package/booking_package.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends LifecycleWatcherState<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  UserData userData;

  LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
   // PushNotificationsManager().init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return CubitProvider(
      create: (context) =>
          DashboardCubit(repo: BaseRepo(), accessToken: AppUtils.token),
      child: Scaffold(
        key: _globalKey,
        drawerScrimColor: drawerScreamColor.withOpacity(0.2),
        /*drawer: SafeArea(
          top: false,
          child: Drawer(
            child: Container(
              color: whiteColor,
              child: ListView(
                children: [
                  createHeader(context, userData, () {
                    NavigationService()
                        .navigationKey
                        .currentState
                        .pop();
                    var data = {
                      "fromPage": "dashboard",
                      "isUpdated": false
                    };
                    NavigationService()
                        .navigationKey
                        .currentState
                        .pushNamed(personalDetailsRoute,
                        arguments: data)
                        .then((value) {
                      _globalKey.currentContext
                          .cubit<DashboardCubit>()
                          .getPersonalDetails();
                    });
                  }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  // createDrawerItems("Pre-Booked Jobs", myTripIcon, () {
                  //   NavigationService().pushNamed(preBookJobsRoute);
                  // }),
                  // LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems("My Journeys", myTripIcon, () {
                    NavigationService().pushNamed(myJourneyRoute);
                  }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems1(
                      "One Tap Booking", oneTapBookingIcon, () {

                    _showDialog();
                  }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems("Addresses", addressIcon, () {
                    NavigationService().pushNamed(myAddressRoute, arguments: {
                      'currentLocation': _currentLocation
                    });
                  }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems("Manage Cards", manageCardIcon,
                          () {
                    NavigationService().pushNamed(manageCardRoute);
                            // _showDialog();
                      }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems("Profile", profileIcon, () {
                    NavigationService()
                        .navigationKey
                        .currentState
                        .pop();
                    var data = {
                      "fromPage": "dashboard",
                      "isUpdated": false
                    };
                    NavigationService()
                        .navigationKey
                        .currentState
                        .pushNamed(personalDetailsRoute,
                        arguments: data)
                        .then((value) {
                      _globalKey.currentContext
                          .cubit<DashboardCubit>()
                          .getPersonalDetails();
                    });
                  }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems(
                      "Help & Support", helpSupportIcon, () {
                    NavigationService().pushNamed(helpSupportRoute);
                    // NavigationService().navigationKey.currentState.pushNamed(chooseLang, arguments: false);
                  }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems(
                      "Notification", notificationIcon, () {
                    _showDialog();
                  }),
                  LineBg(strokeWidth: 1, color: hintColor),
                  createDrawerItems1("Logout", logoutDrawerIcon, () async {
                    NavigationService()
                        .navigationKey
                        .currentState
                        .pop();
                    String returnVal = await showDialog(
                        builder: (BuildContext bc) =>
                            LogoutDialog(),
                        context: context,
                        // child: LogoutDialog(),
                        barrierDismissible: false);
                    if (returnVal == 'logout') {
                      check().then((internet) {
                        if (internet != null && internet) {
                          _globalKey.currentContext
                              .cubit<DashboardCubit>()
                              .doLogout(AppUtils.token);
                        } else {
                          _globalKey.currentState.showSnackBar(
                              getSnackBar(
                                  "Please check your Internet Connection",
                                  "OK",
                                  _globalKey));
                        }
                      });
                    }
                  }),
                  VerticalGap(gap: 50),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Legal",
                          style: TextStyle(
                              fontFamily: "Gilroy",
                              fontSize: 20.0,
                              color: gpsIconColor,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "0.0.0-SprrelPass (${Constants.versionNumber})",
                          style: TextStyle(
                              fontFamily: "Gilroy",
                              fontSize: 16.0,
                              color: gpsIconColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),*/
        body: CubitConsumer<DashboardCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadingState) {
                showLoader("Logging out......");
              }
              if (state is SignOutSuccessState) {
                hideLoader();
                print("LogoutResponse -> ${state.isLogout}");
                TaxiUKPrefs.instance.saveLoginStatus(false);
                TaxiUKPrefs.instance.deleteToken(tokenKey);
                SharedPreferenceUtils().clearUserData();
                TaxiUKPrefs.instance.deleteUserData();
                NavigationService()
                    .navigationKey
                    .currentState
                    .pushNamedAndRemoveUntil(login, (route) => false);
              }

              if (state is GetProfileDataState) {
                // _hideLoader();
                ProfileResponse profileResponse =
                ProfileResponse.fromMap(state.response);
                print(
                    "Response Value -> ${profileResponse.data.fname} :: "
                        "${profileResponse.data.lname} :: ${profileResponse.data.phone_number}");
                setState(() {
                  userData = profileResponse.data;
                  AppUtils.userData = userData;
                });
              }

              if (state is ProfileErrorState) {
                hideLoader();
                FocusScope.of(context).requestFocus(FocusNode());
                _globalKey.currentState.showSnackBar(getSnackBar(
                    state.response["message"], "OK", _globalKey));
              }
            },
            listenWhen: (previous, current) => current != previous,
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => buildHomeUI()),
      ),
    );
  }

  Widget buildHomeUI() => Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: //MyApp(),
            MyGoogleMap(currentLocation: (LatLng currentLocation){
              setState(() {
                _currentLocation = currentLocation;
              });
            }),
          ),
          Positioned(
              top: 36,
              left: 20,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: kPrimaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              menuLogo,
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () => _globalKey.currentState.openDrawer(),
                      )
                    ],
                  ),
                ],
              ))],
      );

  @override
  void onDetached() {
    print("DashboardPage: => onDetached()");
  }

  @override
  void onInactive() {
    print("DashboardPage: => onInactive()");
  }

  @override
  void onPaused() {
    print("DashboardPage: => onPaused()");
  }

  @override
  void onResumed() {
    print("DashboardPage: => onResumed()");
  }

  Widget createDrawerItems(String title, String assetName,
      GestureTapCallback onTap){
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -1),
          title: Text(title,
            style: TextStyle(
                fontFamily: "Gilroy",
                fontSize: 16.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.w600
            ),),
          leading: SvgPicture.asset(assetName, color: kPrimaryColor, width: 20, height: 20, fit: BoxFit.fill,),
          onTap: onTap
      ),
    );
  }

  Widget createDrawerItems1(String title, String assetName,
      GestureTapCallback onTap){
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -1),
          title: Text(title,
            style: TextStyle(
                fontFamily: "Gilroy",
                fontSize: 16.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.w600
            ),),
          leading: Image.asset(assetName, width: 24, height: 24, fit: BoxFit.fill,),
          // trailing: Icon(Icons.arrow_forward_ios_rounded, color: whiteColor,),
          onTap: onTap
      ),
    );
  }

  Widget createHeader(BuildContext context, UserData userData, GestureTapCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        padding: EdgeInsets.only(left: 15, right: 15),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userData == null ? ClipOval(
              child: Container(
                height: 76,
                width: 76,
                color: hintColor,
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: SvgPicture.asset(userDefaultIcon, color: textColor,),
                ),
              ),
            ) : userData.picUrl == null ? ClipOval(
              child: Container(
                height: 76,
                width: 76,
                color: hintColor,
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: SvgPicture.asset(userDefaultIcon, color: textColor,),
                ),
              ),
            ) : ClipOval(
              child: Container(
                height: 76,
                width: 76,
                color: hintColor,
                child: Image.network(
                  "${Constants.baseUrlImage}${userData.picUrl}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            HorizontalGap(gap: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userData == null ? "Username"
                      : userData?.fname == null ?
                  "Username" :
                  userData.fname,
                    style: TextStyle(
                        fontFamily: "Gilroy",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor
                    ),),
                  VerticalGap(gap: 8,),
                  Text(userData == null ? "+44-9876543210"
                      : "${userData.ext}-${userData.phone_number}",
                    style: TextStyle(
                        fontFamily: "Gilroy",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor
                    ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog() =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                contentPadding: EdgeInsets.all(0.0),
                content: MyErrorDialog(
                  str: 'This Section is under Development',
                  onClick: () {
                    Navigator.of(context).pop();
                    FocusScope.of(context).requestFocus(FocusNode());

                  },
                ));
          });

}*/
