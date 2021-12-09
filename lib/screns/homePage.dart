//import 'package:cabbooking/my_google_map/my_google_map.dart';
/*import 'package:flutter/material.dart';
import 'package:taxiapp/screns/drawer.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geocoder/model.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:intl/intl.dart';
//import 'package:location/location.dart';


class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key, String? title}):super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getLoc();

  }

  /*void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _controller;
    location.onLocationChanged().listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
        ),
      );
    });
  }*/
  /*getLoc() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition!.latitude,_currentPosition!.longitude);
    location.onLocationChanged().listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition!.latitude,_currentPosition!.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition!.latitude, _currentPosition!.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });
      });
    });
  }


  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }*/


  int time=20;
  int distance=5;
  @override
  Widget build(BuildContext context) {
   // statusBarColor: Colors.transparent;
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.reorder,color: Colors.black,),actions: [],backgroundColor: Colors.white,),
     drawer: CustomDrawer(),
     body: Stack(
       children: [
         Container(padding: EdgeInsets.symmetric(vertical:20),child:
       Column(children: <Widget>[
         Padding(padding: EdgeInsets.symmetric(horizontal:20),child:TextField(decoration: InputDecoration(
             border: OutlineInputBorder(
               //color:,
               borderRadius: BorderRadius.circular(30.0),
             ),
             filled: true,
             hintStyle: TextStyle(color: Colors.grey[800]),
             hintText: "     Location 1",
             suffixIcon: Icon(Icons.location_on),
             fillColor: Colors.white70),),),
         SizedBox(height: 20,),
         Padding(padding: EdgeInsets.symmetric(horizontal:20),child:TextField(decoration: InputDecoration(
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(30.0),
             ),
             filled: true,
             hintStyle: TextStyle(color: Colors.grey[800]),
             hintText: "     Location 2",
             suffixIcon: Icon(Icons.location_on),
             fillColor: Colors.white70),),),
         SizedBox(height: 20,),
         Container(height: 250,),
         Container(width:MediaQuery. of(context). size. width,decoration: BoxDecoration(
           shape: BoxShape.rectangle,
          // border:
           border: Border(
             bottom: BorderSide(width:2, color:Colors.black54)
             //color: Colors.blue,
           ),
          // borderRadius: BorderRadius.circular(10.0),
         ), child:Column(children: <Widget>[
           Text("Travel Time - $time mins"),
           Text("Travel Distance - $distance kms")
         ],)),
         SizedBox(height: 70,),
         CircularProgressIndicator(),
         Text('Searching for drivers')
       ])


       )
     ]),
    );
  }
}*/
