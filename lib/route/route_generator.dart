/*import 'package:booking_package/booking_package.dart';
import 'package:booking_package/ui/booking/booking_screen.dart';
import 'package:booking_package/ui/my_address/search_location_screen.dart';
import 'package:booking_package/ui/rating/rate_trip_screen.dart';
import 'package:customer/route/route_constant.dart';
import 'package:booking_package/ui/booking/cancel_booking_screen.dart';
import 'package:customer/ui/DestSuggestion.dart';
import 'package:customer/ui/forgot/forgot_pass_otp_screen.dart';
import 'package:customer/ui/forgot/forgot_password.dart';
import 'package:customer/ui/help_support/help_support_screen.dart';
import 'package:customer/ui/home/home_screen.dart';
import 'package:customer/ui/manage_cards/add_card_screen.dart';
import 'package:customer/ui/manage_cards/manage_card_screen.dart';
import 'package:flutter/material.dart';

import '../ui/login/login_screen.dart';
import '../ui/splash/splash_screen.dart';
import '../ui/otp/otp_screen.dart';
import '../ui/login email/login_screen.dart';
import '../ui/Signin_screen.dart';
import '../ui/otp email/otp_screen.dart';
import '../ui/change_password/change_password_screen.dart';
import '../ui/personal_details/personal_details_screen.dart';
import '../ui/personal_details/frag/verify_otp_update_page.dart';
import '../ui/personal_details/frag/update_email_and_mobile_page.dart';
import '../ui/forgot/create_new_password_screen.dart';
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/Profile/profile_data_fetch.dart';
import 'package:taxiapp/screns/SignIn/login_screen.dart';
import 'package:taxiapp/screns/SignIn/register_screen.dart';
import 'package:taxiapp/screns/booking/navigation_route.dart';
import 'package:taxiapp/screns/bookingRequest/myaddresses.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    /*case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
*/


      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case registrationRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case personalDetailsRoute:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(builder: (_) => ProfileScreen(data: argument));

      case bookingrequest:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(builder: (_) => MyAddresses(data: argument));

      case navigation:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(builder: (_) => NavigationRoute(data: argument,));


    /* case emailRoute:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => LoginScreenEmail(data: argument));

      case otpEmailRoute:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => OtpScreenEmail(data: argument));

      case createPasswordRoute:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen(data: argument));

      case personalDetailsRoute:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => PersonalDetailsScreen(data: argument));

      case dashboard:
        // LocationUtils().d
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case selectLocationRoute:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => SelectLocationScreen(data: argument));

      case changeLocationRoute:
        var argument = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => ChangeLocationScreen(data: argument));

      case bookingScreenRoute:
        return MaterialPageRoute(builder: (_) {
          return BookingScreen(args: settings.arguments);
        });

      case cancelBookingScreenRoute:
        return MaterialPageRoute(
            builder: (_) => CancelBookingScreen(args: settings.arguments));
      case rateTripScreenRoute:
        return MaterialPageRoute(
            builder: (_) => RateTripScreen(args: settings.arguments));

      case destinationSugg:
        return MaterialPageRoute(builder: (_) => DestinationSugg());

      case UpdateEmailMobilePage:
        var argument = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => UpdateEmailAndMobilePage(data: argument));

      case otpVerifyUpdate:
        var argument = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => VerifyOtpUpdatePage(argument));

      case otpForgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());

      case verifyOtpForgotPassword:
        var argument = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ForgotPassOtpScreen(data: argument));

      case createNewPassword:
        var argument = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => CreateNewPasswordScreen(data: argument));

      case helpSupportRoute:
        return MaterialPageRoute(builder: (_) => HelpSupportScreen());

      case preBookJobsRoute:
        return MaterialPageRoute(builder: (_) => PreBookJobsScreen());
      case myJourneyRoute:
        return MaterialPageRoute(builder: (_) => MyJourneyScreen());
      case myAddressRoute:
        return MaterialPageRoute(
            builder: (_) => MyAddressScreen(args: settings.arguments));

      case searchLocationRoute:
        return MaterialPageRoute(
            builder: (_) => SearchLocationScreen(args: settings.arguments));
      case myReceiptRoute:
        return MaterialPageRoute(
            builder: (_) => MyReceiptScreen(args: settings.arguments));

      case addCardRoute:
        return MaterialPageRoute(builder: (_) => AddCardScreen());
      case manageCardRoute:
        return MaterialPageRoute(builder: (_) => ManageCardScreen());*/

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}


