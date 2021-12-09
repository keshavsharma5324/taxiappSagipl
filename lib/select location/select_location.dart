/*
import 'dart:html';

//import 'package:booking_package/base/base_state.dart';
//import 'package:booking_package/models/response/master_response.dart';
//import 'package:booking_package/repo/booking_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
//import 'package:customer/utils/Constants.dart';
//import 'package:customer/service/navigation_service.dart';
//import 'package:customer/route/route_constant.dart';
//import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:loader_overlay/loader_overlay.dart';
//import 'package:customer/utils/my_extentions.dart';
import 'package:taxiapp/Model/master_response.dart';
import 'package:taxiapp/base/base/base_state.dart';
import 'package:taxiapp/repo/booking_repo.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/constants.dart';
import 'package:taxiapp/utils/my_error_dialog.dart';
import 'package:taxiapp/utils/my_extentions.dart';
import 'taxi_list_cubit.dart';
//mport 'package:customer/ui/customviews/my_error_dialog.dart';

class SelectLocationScreen extends StatefulWidget {
  final dynamic data;

  SelectLocationScreen({this.data});

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Constants.apiKey);

  TextEditingController _controllerFromLocation = TextEditingController();
  TextEditingController _controllerToLocation = TextEditingController();
  LatLng? _latLngFrom;
  LatLng? _latLngTo;
  BuildContext? _context;
  String? _sourceTitle;
  String? _destTitle;

  @override
  void initState() {
    super.initState();

    _latLngFrom = widget.data['currentLatLng'];

    Coordinates(_latLngFrom!.latitude, _latLngFrom!.longitude).getAddress.then((value) {
      _controllerFromLocation.text = value!;
    });
  }

  _getAddress(Coordinates coordinates) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    _controllerFromLocation.text = first.addressLine!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TaxiListCubit(repo: BookingRepo()),
        child: BlocConsumer<TaxiListCubit, BaseState>(
          builder: (context1, state) {
            _context = context1;
            return _mainUi();
          },
          buildWhen: (previous, current) => previous != current,
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is LoadingState) {
              context.showLoaderOverlay();
            } else if (state is SuccessState<MasterResponse>) {
              context.hideLoaderOverlay();
              NavigationService().pushNamed(bookingScreenRoute, arguments: {
                'latLongFrom': _latLngFrom,
                'latLongTo': _latLngTo,
                'fromAddress': _controllerFromLocation.text,
                'toAddress': _controllerToLocation.text,
                'response': state.response,
                'sourceTitle': _sourceTitle,
                'destTitle': _destTitle,
                'from': 'selectLocation'
              });
            }
          },
        ));
  }

  Widget _mainUi() =>
      Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffF7F7F7),
            child: Column(children: [
              Container(
                height: 244,
                color: Color(0xffFFFFFF),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 52, 0, 0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              size: 23.0,
                              color: Color(0xff202020),
                            ),
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(80, 52, 8, 0),
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xff004238), width: 1),
                            ),
                            child: Icon(
                              Icons.person,
                              color: Color(0xff004238),
                              size: 22,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 52),
                            child: Text('For me',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff004238),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 52, 0, 0),
                          child: Container(
                            height: 32,
                            width: 28,
                            child: Icon(
                              Icons.expand_more,
                              color: Color(0xff004238),
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(22, 35, 0, 10),
                        height: 135,
                        width: 50,
                        child: Column(
                          children: [
                            Container(
                              height: 11,
                              width: 11,
                              decoration: BoxDecoration(
                                color: Color(0xffF9534B),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              height: 67.39,
                              width: 0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff707070), width: 1),
                              ),
                            ),
                            Container(
                              height: 11,
                              width: 11,
                              decoration: BoxDecoration(
                                color: Color(0xff004238),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 12, 20, 0),
                          height: 140,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _openAutoComplete(1);
                                },
                                child: Container(
                                  child: TextField(
                                    controller: _controllerFromLocation,
                                    enabled: false,
                                    readOnly: true,
                                    textAlign: TextAlign.justify,
                                    obscureText: false,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff004238)),
                                    decoration: InputDecoration(
                                      hintText: "Select Source",
                                      hintStyle: TextStyle(
                                        color: Color(0xff004238),
                                        fontFamily: 'Gilroy',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(bottom: -15),
                                      focusedBorder: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _openAutoComplete(2);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  child: TextField(
                                    enabled: false,
                                    readOnly: true,
                                    controller: _controllerToLocation,
                                    textAlign: TextAlign.justify,
                                    obscureText: false,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff004238)),
                                    decoration: InputDecoration(
                                      hintText: "Select Destination",
                                      hintStyle: TextStyle(
                                        color: Color(0xff004238),
                                        fontFamily: 'Gilroy',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(bottom: -15),
                                      focusedBorder: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 147,
                color: Color(0xffFFFFFF),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: ListTile.divideTiles(
                      //
                        context: context,
                        tiles: <Widget>[
                          InkWell(
                            onTap: (){
                              _showDialog();
                            },
                            child: Container(
                              height: 73.5,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.home,
                                    color: Color(0xff004238),
                                  ),
                                  SizedBox(
                                    width: 11.25,
                                  ),
                                  Text("Home Address",
                                      style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff004238),
                                      )),
                                  Expanded(child: Container()),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xff5B5B5B),
                                    size: 13,
                                  ),
                                  SizedBox(width: 20),

                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              _showDialog();
                            },
                            child: Container(
                              height: 73.5,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Icon(
                                      Icons.business_center,
                                      color: Color(0xff004238),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 11.25,
                                  ),
                                  Text("Office Address",
                                      style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff004238),
                                      )),
                                  Expanded(child: Container()),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xff5B5B5B),
                                    size: 13,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]).toList(),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 439,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: ListTile.divideTiles(
                        color: Color(0xFF202020),
                        context: context,
                        tiles: <Widget>[
                          InkWell(
                            onTap: (){
                              _showDialog();
                            },
                            child: Container(
                              height: 74,
                              color: Color(0xffFFFFFF),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xff004238),
                                  ),
                                  SizedBox(
                                    width: 11.25,
                                  ),
                                  Text("Saved Locations",
                                      style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff004238),
                                      )),

                                  Expanded(child: Container()),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xff5B5B5B),
                                    size: 13,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]).toList(),
                  ),
                ),
              )
            ]),
          ),
        ),
      );

  _openAutoComplete(int type) async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constants.apiKey,
        onError: onError,
        mode: Mode.fullscreen);
    displayPredictionSource(p!, type);
  }

  void onError(PlacesAutocompleteResponse response) {
    print('Error => ${response.errorMessage}');
  }

  Future<Null> displayPredictionSource(Prediction p, int type) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId.toString());
      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      type == 1 ? _sourceTitle = detail.result.name : _destTitle =
          detail.result.name;

      type == 1 ? _latLngFrom = LatLng(lat, lng) : _latLngTo = LatLng(lat, lng);

      setState(() {
        type == 1
            ? _controllerFromLocation.text = p.description!
            : _controllerToLocation.text = p.description!;
      });

      if (_latLngFrom != null && _latLngTo != null) {
        _context!.read<TaxiListCubit>().getTaxiList();
      }
    }
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
