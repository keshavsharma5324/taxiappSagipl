import 'dart:async';
import 'dart:typed_data';

//import 'package:booking_package/base/base_state.dart';
//import 'package:booking_package/models/response/driver_location_response.dart';
//import 'package:booking_package/models/response/location_bean.dart';
//import 'package:booking_package/models/response/ride_bean.dart';
//import 'package:booking_package/notification/my_notification_stream.dart';
//import 'package:booking_package/repo/booking_repo.dart';
//import 'package:booking_package/ui/my_google_map/location_cubit.dart';
//import 'package:booking_package/utils/permission_utils.dart';
//import 'package:customer/route/route_constant.dart';
//import 'package:customer/service/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:geocoding/geocoding.dart' as locationcheck;
//import 'package:flutter_geocoder/geocoder.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:taxiapp/base/base_repo.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/Profile%20and%20choice%20cab/Nearby_Response.dart';

import 'package:taxiapp/screns/my_google_map/location_cubit.dart';
import 'package:taxiapp/screns/registerUser/profile_state.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/CustomViews/custom_views/my_text.dart';
import 'package:taxiapp/utils/app_colors.dart';
import 'package:taxiapp/utils/constants.dart';
import 'package:taxiapp/utils/my_error_dialog.dart';
import 'package:taxiapp/utils/permission_utils.dart';

//import '../../booking_package.dart';
//import '../../custom_views/my_text.dart';
import '../../utils/location_utils.dart';
//import 'package:customer/utils/constants.dart';
//import 'package:customer/utils/app_colors.dart';
//import 'package:customer/utils/my_extentions.dart';
import 'dart:ui' as ui;

//import 'package:customer/ui/customviews/my_error_dialog.dart';

class MyGoogleMap extends StatefulWidget {
  final Function? currentLocation;

  MyGoogleMap({this.currentLocation});

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = Set();
  LatLng? _currentLatLong;
  LatLng? _sourceLatLong;
  String _sourceAddress = "";
  var cp = CameraPosition(target: LatLng(0.0, 0.0));

  BitmapDescriptor? _markerIconDriver;

  BuildContext? _context;
  bool _isLocationServiceEnabled = false;

  @override
  void initState() {
    super.initState();

    print('###===> initState() Called');

    _getPermission();
    _getMarkers();


   // _listenStream();
  }

  /*_listenStream() {
    MyNotificationStream().listenStream.listen((snapshot) {

      if (snapshot != null) {
        var bean = snapshot as RideBean;

        if (bean.bookingType == Constants.bookingTypePreBook) {
          NavigationService()
              .pushNamedAndRemoveUntil(bookingScreenRoute, arguments: {
            'from': 'notification',
            'latLongFrom': LatLng(double.parse(bean.locationPickup.latitude),
                double.parse(bean.locationPickup.longitude)),
            'latLongTo': LatLng(double.parse(bean.locationDrop.latitude),
                double.parse(bean.locationDrop.longitude)),
            'fromAddress': bean.locationPickup.address,
            'toAddress': bean.locationDrop.address,
            'response': bean,
            'sourceTitle': bean.locationPickup.addressLabel,
            'destTitle': bean.locationDrop.addressLabel
          });
        }
      }
    });

  }*/

  _getMarkers() async {

    final Uint8List markerIconDriver = await getBytesFromAsset(
        'assets/png/car.png',
        20);
    _markerIconDriver = BitmapDescriptor.fromBytes(markerIconDriver);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _getPermission() async {

    PermissionUtils().askForPermission(Permission.location, onGranted: (){
      LocationUtils().checkLocationService1(onGranted: () {
        _getLocationUpdates();
      });
    });

    // await LocationUtils().checkPermission(Permission.location, context, 'Location');
  }
  Future<String?> getAddress(double lat,double long) async {
    List<locationcheck.Placemark> placemarks = await locationcheck.placemarkFromCoordinates(lat,long);
    //await List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);//Geocoder.google(Constants.apiKey).findAddressesFromCoordinates(this);
    var address = placemarks.first;
    return address.name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LocationCubit(repo: BaseRepo()),
        child: BlocConsumer<LocationCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccessState) {
                if (state.response is LocationData) {
                  _currentLatLong =
                      LatLng(state.response.latitude, state.response.longitude);
                  widget.currentLocation!(_currentLatLong);
                  _animateCameraToCenter();
                  setState(() {
                    _isLocationServiceEnabled = true;
                  });

                  /*_context!.cubit<LocationCubit>().getNearByDrivers({
                    'lat': _currentLatLong.latitude,
                    'lng': _currentLatLong.longitude
                  });*/
                } /*else if (state.response is NearbyResponse) {
                  _setMarkers((state.response as NearbyResponse)success!.users![0].);*/
                } else if ((state is ProfileSuccessState<bool>) && !(state.response)) {
                  setState(() {
                    _isLocationServiceEnabled = false;
                  });
                }
              },
           // },
            listenWhen: (previous, current) => previous != current,
            buildWhen: (previous, current) => previous != current,
            builder: (context1, state) {
              _context = context1;
              return Scaffold(body: _mainUi());
            }));
  }

  _mainUi() => Stack(children: [
        GoogleMap(
          markers: _markers,
          onMapCreated: (controller) {
            _mapController = controller;
            _animateCameraToCenter();
          },
          initialCameraPosition: cp,
          zoomControlsEnabled: false,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          onCameraIdle: () {
            if (_isLocationServiceEnabled != null &&
                _isLocationServiceEnabled) {
              if (_sourceLatLong != null) {
              //  Coordinates(_sourceLatLong!.latitude, _sourceLatLong!.longitude)
                    getAddress(_sourceLatLong!.latitude,_sourceLatLong!.longitude)
                    .then((value) {
                  setState(() {
                    _sourceAddress = value!;
                  });
                });
              }
            }
          },
          onCameraMove: (CameraPosition position) {
            if (_isLocationServiceEnabled != null &&
                _isLocationServiceEnabled) {
              _sourceLatLong =
                  LatLng(position.target.latitude, position.target.longitude);
            }
          },
        ),
        Visibility(
          visible:
              (_isLocationServiceEnabled != null && _isLocationServiceEnabled),
          child: Center(
            child: Image.asset(
              "${Constants.baseAssetPathBookingPng}a_pin.png",
              width: 64,
              height: 64,
            ),
          ),
        ),
        Positioned(
            top: 84,
            left: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 10,
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          text: "Your Location",
                          maxLines: 1,
                          color: AppColors.themeGreenColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 5,
                      ),
                      MyText(
                          text: _sourceAddress,
                          maxLines: 1,
                          color: AppColors.themeGreenColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              ),
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                            ),
                          ],
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.location_searching_rounded,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_currentLatLong == null) {
                        _getPermission();
                        // _context.cubit<LocationCubit>().getCurrentLocation();
                      } else {
                        _animateCameraToCenter();
                      }
                    }),
                SizedBox(height: 20),
                _isLocationServiceEnabled == null
                    ? Container()
                    : _isLocationServiceEnabled
                        ? _bookingWidget()
                        : _locationServiceWidget()
              ],
            ))
      ]);

  Widget _bookingWidget() => Container(
        height: 151,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 27, 0, 0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                            alignment: Alignment.topLeft,
                            height: 55,
                            child: Material(
                              elevation: 2.0,
                              shadowColor: Color(0xffF5F5F5),
                              child: InkWell(
                                onTap: () {
                                  if (_sourceLatLong != null) {
                                    NavigationService().pushNamed(
                                        selectLocationRoute,
                                        arguments: {
                                          'currentLatLng': _sourceLatLong
                                        });
                                  }
                                },
                                child: TextFormField(
                                  enabled: false,
                                  readOnly: true,
                                  obscureText: true,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 5, 0),
                                        child: Icon(
                                          Icons.room,
                                          color: Color(0xff004238),
                                          size: 18,
                                        ),
                                      ),
                                      fillColor: Color(0xffF5F5F5),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 20.0, 10.0),
                                      hintText: 'Where to?',
                                      hintStyle: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff202020)),
                                      // fillColor: Color(0xffF5F5F5),
                                      filled: true,
                                      //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff00000029),
                                              width: 2.0))),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 19, 0, 0),
                    //alignment: Alignment.center,
                    width: 68,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        //side: BorderSide(color: Colors.red)
                      ),
                      padding: EdgeInsets.only(top: 1, bottom: 1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: InkWell(
                        onTap: () {
                          _showDialog();
                        },
                        child: Container(
                          child: Column(children: <Widget>[
                            SizedBox(height: 3),
                            Image.asset(
                                '${Constants.baseAssetPathBookingPng}one_tap_booking.png'),
                            Text(
                              "One Tap Booking",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 8.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            SizedBox(height: 3),
                          ]),
                        ),
                      ),
                      colorBrightness: Brightness.dark,
                      onPressed: () {},
                      color: Color(0xff004238),
                    ),
                  ),
                  SizedBox(width: 20.0)
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _showDialog();
              },
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                            alignment: Alignment.topLeft,
                            width: 315,
                            height: 55,
                            child: Row(children: [
                              Container(
                                  height: 55,
                                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  child: Icon(Icons.star,
                                      size: 18, color: Color(0xff004238))),
                              Text('Choose a Saved Location',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff202020),
                                  ))
                            ])),
                      ),
                    ),
                    Container(
                        height: 55,
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(Icons.arrow_forward_ios,
                            size: 18, color: Color(0xff004238))),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      );

  Widget _locationServiceWidget() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        SizedBox(height: 15),
        Row(
          children: [
            SizedBox(width: 20),
            Image.asset('${Constants.baseAssetPathBookingPng}gps_red.png',
                width: 40, height: 40),
            SizedBox(width: 20),
            Expanded(
              child: MyText(
                  text:
                      'Turn On Location Services to Allow "Google Maps" to Determine your Pickup Location Automatically.',
                  color: AppColors.themeGreenColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 40)
          ],
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              _getPermission();
              // _context.cubit<LocationCubit>().getCurrentLocation();
            },
            child: MyText(
                text: 'Turn On Location Service',
                color: AppColors.themeGreenColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                textDecoration: TextDecoration.underline),
          ),
        ),
        SizedBox(height: 20)
      ]));

  _animateCameraToCenter() {
    print('####====>_animateCameraToCenter() Called');
    if (_currentLatLong != null && _mapController != null) {
      _mapController!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: _currentLatLong!,
        zoom: 15.5,
      )));
    }
  }

  _setMarkers(List<NearbyResponse> data) {
    _markers.clear();
    data.forEach((element) {
      Marker marker = Marker(
          icon: _markerIconDriver!,
          markerId: MarkerId(element.success!.users![0].id.toString()),
          position: LatLng(//25.1239014, 75.8603001));
              double.parse(element.success!.users![0].latitude.toString()), double.parse(element.success!.users![0].longitude.toString())));

      _markers.add(marker);
    });

    print('====>>>>${_markers.length}');

    setState(() {
      _markers = _markers;
    });
  }

  void _showDialog() => showDialog(
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

  StreamSubscription<LocationData>? _locationSubscription;
  String? _error;
  final Location location = Location();

  _getLocationUpdates() async {
    if (_locationSubscription != null) await _locationSubscription!.cancel();


    location.changeSettings(distanceFilter: 50, interval: 5000);
    _locationSubscription =
        location.onLocationChanged.handleError((dynamic err) {
      _error = err.code;
      _locationSubscription!.cancel();
    }).listen((LocationData currentLocation) async {
      _error = null;

      if (!_isLocationServiceEnabled) {
        setState(() {
          _isLocationServiceEnabled = true;
        });
      }

      _currentLatLong =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      _sourceLatLong = _currentLatLong;

      _animateCameraToCenter();

      //Coordinates(_sourceLatLong!.latitude, _sourceLatLong!.longitude)
          getAddress(_sourceLatLong!.latitude,_sourceLatLong!.longitude)
          .then((value) {
        setState(() {
          _sourceAddress = value!;
        });
      });


    });
  }

  @override
  void dispose() {
    if (_locationSubscription != null) _locationSubscription!.cancel();
    super.dispose();
  }
}
