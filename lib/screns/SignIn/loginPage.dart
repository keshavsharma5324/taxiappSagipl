
//import 'dart:html';

import 'dart:async';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/Model/response/model/driversocket.dart';
import 'package:taxiapp/Model/response/model/nearest.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/ColorHelper.dart';
import 'package:taxiapp/utils/Constant.dart';
import 'package:taxiapp/utils/Validator.dart';
import 'package:taxiapp/utils/constants.dart';

import 'login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/device_info.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key}) : super(key: key);
  final Function? onClick;
  // final dynamic args;

  LoginPage({this.onClick});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true,auto =false;
  bool? isEmail;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  bool isEditing = false;
  SharedPreferences? logindata;
  String? token;
  var stringValue;
  var args;
  var newLaunch;
  Driver? driver;
  void initState() {
    super.initState();
    connect();
    _getGeoLocationPosition();
    loadNewLaunch();
    Timer(Duration(seconds: 2), () {
      setState(() {
        auto = true;
      });
    });

   // initPlatformState();
   //` getDeviceDetails();
  }
  void connect()async{
    Position position = await _getGeoLocationPosition();
    //var data={'user_id':'3','lat':currentLocation!.latitude,'long':currentLocation!.longitude,'user_name':'babulal','driver_id':'3'};
    IO.Socket socket = IO.io('http://192.168.0.105:30011',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM

            .disableAutoConnect()  // disable auto-connection
        //.setExtraHeaders({'foo': 'bar'}) // optional
            .build()
    );
    socket.connected?null:socket.connect();
    var data={'user_id':'3','startlat': '26.8611','startlng': '75.7953'};
    socket.emit('send_nearest_driver', data);

    socket.on('get_nearest_driver_3', (data) {
      // driver = Driver.fromJson(data);

      Nearest nearest = Nearest.fromJson(data);
      print(nearest.startlng.toString());
      //  print(driver!.userName);
    });

    print('check socket connection: ${socket.connected}');


  }
  loadNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    args=await {
      "from": 'login',
      "code": 'ffrr',
      "user_id": prefs.getString('user_id'),//Response.success.userId,
      "token": prefs.getString('tokenValue'),
      "latitude": prefs.getString('latitude'),
      "longitude": prefs.getString('longitude')
    };
    setState(() {
      bool _newLaunch = ((prefs.getBool('newLaunch') ?? true));
      print('latude ${prefs.getString('latitude')}');
      print(_newLaunch);
      newLaunch = _newLaunch;

    });
    newLaunch?null:NavigationService().navigationKey.currentState!.pushNamed(nearby, arguments: args);
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    final coordinates = new Coordinates(position.latitude,position.longitude);
   // List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(addresses);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    //Placemark place = placemarks[0];
    //Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }


      @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_globalKey,
        appBar: auto?AppBar(title:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text('Welcome back',textAlign: TextAlign.start,style: TextStyle(color: Colors.black),),
        Text('Login to Your Account',style: TextStyle(fontSize: 10,color: Colors.grey),)]),backgroundColor: Colors.white,):null,
        body:auto?SingleChildScrollView(child:Stack(

            children:[
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                     /* Align(alignment: Alignment.center,child:Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.25), // border color
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2), // border width
                          child: Container( // or ClipRRect if you need to clip the content
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey, // inner circle color
                            ),
                            child: Icon(Icons.account_box_rounded,size:50), // inner content
                          ),
                        ),
                      ),),*/
                      SizedBox(height: 30,),

                      Text('E-mail OR Phone Number',style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 10,),
                      Material(
                        elevation: 5,
                        shadowColor: Color(0xffF5F5F5),
                        child: TextFormField(
                          controller: _controllerUsername,
                          //obscureText: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                              hintText: 'Enter User Name',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Colors.white, width: 1.0))
                          ),
                          onChanged: (value){
                            if(value.length>0){
                              setState(() {
                                isEmail = !Validator().isNumeric(value);
                              });
                            }else{
                              setState(() {
                                isEmail = false;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 30,),

                      Text('Password',style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 10,),
                      Material(
                        elevation: 5,
                        shadowColor: Color(0xffF5F5F5),
                        child: TextFormField(
                          obscureText: _isObscure,
                          controller: _controllerPassword,
                          //obscureText: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            //icon: new Icon(Icons.lock, color: Color(0xff224597)),
                              hintText: 'Enter password',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(2.0),
                                  borderSide: BorderSide(color: Colors.white, width: 1.0))
                          ),

                        ),
                      ),
                     // SizedBox(height: 20,),




                      SizedBox(height: 50,),
                      Container(height: 55,width:MediaQuery. of(context). size. width ,color:kPrimaryColor,child:FlatButton(onPressed: (){if (isValidate())
                      {
                        // widget.onClick({'password': _controllerPassword.text});
                      }},child: Text('SUBMIT',style: TextStyle(color: Colors.white),),)),
                      SizedBox(height:20),
                      Align(alignment: Alignment.topRight,child:Text('Forgot Password',style:TextStyle(color: Colors.amber,decoration: TextDecoration.underline))),
                      SizedBox(height: 180,),
                      Align(alignment: Alignment.center,child:Text('Are you a New User',style:TextStyle(color: Colors.black))),
                      SizedBox(height: 20,),
                      Container(height: 55,width:MediaQuery. of(context). size. width ,color:LoginBottomColor,child:FlatButton(onPressed: (){NavigationService().navigationKey.currentState!.pushNamed(registrationRoute);},child: Text('CREATE ACCOUNT',style: TextStyle(color: Colors.white),),)),



                    ],
                  ))])
    ):CircularProgressIndicator());
  }
  bool isValidate() {
    var phone = _controllerUsername.text.toString().trim();
    var password = _controllerPassword.text.toString().trim();

    if(isEmail!){
      if(phone.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter Email ID or Phone number",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(!Validator().validateEmail(phone)){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter a valid Email ID",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(password.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter Password",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(password.length<1){//!Validator().validatePassword(password)){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please Enter 8 letters of combination of One Capital, Lower and Numeric characters",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else{
        FocusScope.of(context).unfocus();
        check().then((internet) async {
          if (internet != null && internet) {
            Position position = await _getGeoLocationPosition();
            String deviceId = await _getId();
            String latitude = await position.latitude.toString();
            String longitude = await position.longitude.toString();
            GetAddressFromLatLong(position);
            var data = {
              "email": phone,
              "password": password,
              "device_id": deviceId,
              "latitude": latitude,
              "longitude": longitude//identifier
              //"ext": Constants.defaultCountryCode,
              //"user_type": Constants.userTypePassenger,
            };
            _globalKey.currentContext!.read<LoginCubit>().doLogin(data);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('latitude',latitude.toString().trim());
            prefs.setString('longitude',longitude.toString().trim());
          }else{
            _globalKey.currentState!.showSnackBar(getSnackBar(
                "Please check your internet connection.",
                "OK", _globalKey));
          }
        });
        return true;
      }
    } else{
      if(phone.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter Email ID or Phone number",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(phone.length<9){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter a valid Phone Number",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else if(password.isEmpty){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "Please enter password",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      } else if(password.length<1){//!Validator().validatePassword(password)){
        _globalKey.currentState!.showSnackBar(getSnackBar(
            "eefde",//"Please Enter 8 letters of combination of One Capital, Lower and Numeric characters",
            "OK", _globalKey));
        FocusScope.of(context).unfocus();
        return false;
      }else{
        check().then((internet) async{
          if (internet != null && internet) {
            Position position = await _getGeoLocationPosition();
            String deviceId = await _getId();
            String latitude = await position.latitude.toString();
            String longitude = await position.longitude.toString();
            GetAddressFromLatLong(position);
            var data = {
              "email": phone,
              "password": password,
              "device_id": deviceId,
              "latitude": latitude,
              "longitude": longitude
              //"ext": Constants.defaultCountryCode,
            //  "user_type": Constants.userTypePassenger,
            };
            _globalKey.currentContext!.read<LoginCubit>().doLogin(data);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('latitude',latitude);
            prefs.setString('longitude',longitude);
          }else{
            _globalKey.currentState!.showSnackBar(getSnackBar(
                "Please check your internet connection.",
                "OK", _globalKey));
          }
        });
        FocusScope.of(context).unfocus();
        return true;
      }
    }
  }
}
