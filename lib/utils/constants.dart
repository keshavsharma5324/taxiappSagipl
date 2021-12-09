class Constants {
  //late String id;

  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static String monthPattern = r'^(0?[13-9]|1[012])$';


  static String baseUrl = 'http://192.168.0.105:30011/';//'http://198.211.55.134:8080/api/v1/';
  static String baseUrlImage = 'https://uat.taxiapp.uk.com/storage/';
  static String baseUrlPdf = 'https://uat.taxiapp.uk.com/pdfview/';


  // static String baseUrl = 'https://dev.taxiapp.uk.com/api/';
  // static String baseUrlImage = 'https://dev.taxiapp.uk.com/storage/';
  // static String baseUrlPdf = 'https://dev.taxiapp.uk.com/pdfview/';
  static int passengerStagePersonalDetailCompleted = 3;
  static int passengerStagePasswordCreated = 2;
  static int paymentMethodCash =0;
  static int bookingTypeInstant =0;
  static int bookingTypePreBook =1;
  static int notificationTypeAccepted =0;
  static int notificationTypeDriverArrived =1;
  static int notificationTypeRideStarted =2;
  static int notificationTypeRideCompleted =3;


  static String defaultCountryCode = '+44';

  static String baseAssetPathBooking = 'packages/booking_package/images/svgs/';
  static String baseAssetPathBookingPng = 'packages/booking_package/images/pngs/';

  // Socket Stuff
  static String socketBaseUrl = 'http://dev.taxiapp.uk.com:3200/';


  static String apiKey = 'AIzaSyAUTcxq_15HxdIoMK4N1f3LljTDUoTDr-A';

  static String generateOtp = 'generate-otp';
  static String checkOtp = 'check-otp';
  static String register = 'register';

  static String uploadProfilePic = 'update-profile-picture';
  static String updateProfile = 'auth/user-register';
  static String getProfile = 'profile?user_id=';
  static String profileDetail = getProfile;
  static String profileUpdate = 'profile-update?user_id=';

  static String changePassword = 'add-password';

  static String getTaxiList = 'taxi-type-list';

  static String login = 'login';
  static String logout = 'logout';

  static String bookNow = 'search-for-driver';
  static String cancelRide = 'ride-cancel';
  static String getCancelReasons = 'cancel-reason-list';

  static String preBookRide = 'pre-book-ride';
  static String doPayment = 'passenger-payment-status-update';
  static String rateYourRide = 'add-rating';

  static String getNearByDrivers = 'findcab';
  static String getFindCab = 'searchcab';
  static String requestCab = 'request-cab';
  static String acceptCab = 'accept-cab';
  static String declinedCab = 'declined-cab';

  static String getInstantRidesList = 'instant-ride-history-passenger';
  static String getPreBookRidesList = 'prebook-ride-history-passenger';
  static String getPreBookJobs = 'prebook-rides';

  static String getMyAddress = 'my-address';
  static String deleteAddress = 'delete-address';
  static String addAddress = 'add-my-address';


  static String addCard = 'temp-stripe-customer-create';
  static String getCards = 'stripe-account';
  static String deleteCard = 'card-delete';
  static String setDefaultPaymentMethod = 'setup-default-payment';
  static double kmToMiles = 0.621371;

  static String googleDirectionsApi = 'https://maps.googleapis.com/maps/api/directions/json?travelMode=transit&avoidHighways=false&avoidFerries=true&avoidTolls=false';
}