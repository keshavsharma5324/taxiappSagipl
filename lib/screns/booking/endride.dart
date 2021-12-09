import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/screns/booking/booking_cubit.dart';


void main() {

  runApp (MyApp(),);
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'uber clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EndRide(),//MyHomePage(title: 'Uber clone'),
    );
  }
}
const LatLng SOURCE_LOCATION = LatLng(28.624363599725164, 77.20657210920679);
const LatLng DEST_LOCATION = LatLng(28.53853225321175, 77.39480307139767);

class EndRide extends StatefulWidget {

  final dynamic? data;
  int? id;
  String? accesstoken;
  double? latitude,longitude,sourcelatitude,sourcelongitude,droplatitude,droplongitude;
  EndRide({this.data,this.latitude,this.longitude,this.sourcelatitude,this.sourcelongitude,this.id,this.accesstoken,this.droplatitude,this.droplongitude});
  @override
  _EndRideState createState() => _EndRideState();
}

class _EndRideState extends State<EndRide> {
  bool ride = true;
  bool app = false;
  Completer<GoogleMapController> mapController = Completer();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  Set<Marker> _markers = Set<Marker>();
  LatLng? currentLocation;
  LatLng? destinationLocation;
  double? distanceInMeters = 0;
  late Position currentLocation1;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  var fare; //= distanceInMeters! * 0.020;
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  List<dynamic> data = [
  ];
  double totalDistance = 0;

  /*for(var i = 0; i < data.length-1; i++){
  totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);
  }
  print(totalDistance);*/


  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    this.setCurrentLocation();
    Timer.periodic(new Duration(seconds: 10), (timer) {
      this.setCurrentLocation();
    });


    //Timer(Duration(seconds: 3), () {

    //this.distance();
    Timer(Duration(seconds: 3), () {
      this.setInitialLocation();
      setState(() {
        app = true;
      });
    });
    Timer.periodic(new Duration(seconds: 10), (timer) {
      this.setInitialLocation();
    });
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
        "AIzaSyAvFh2R7W_4hVBK_UAo5B64iriZLsyaqRo",
        PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
        PointLatLng(
            destinationLocation!.latitude, destinationLocation!.longitude));

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });

      //fare = distanceInMeters! * 0.020;
    }
  }

  void showMarker() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: currentLocation!,
        icon: BitmapDescriptor.defaultMarker,
      ));

      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(90),
      ));
    });
  }

  setCurrentLocation() async {
    currentLocation1 = await BlocProvider.of<BookingCubit>(context)
        .getCurrentLocation(); //geoLocatorService.getCurrentLocation();
    print(currentLocation);
    setState(() {
      currentLocation;
      currentLocation =
          LatLng(currentLocation1.latitude, currentLocation1.longitude);
      //_originLatitude = currentLocation.latitude;
      //_originLongitude = currentLocation.longitude;

    });}

  void setInitialLocation() {
    setState(() {
      currentLocation =
          LatLng(currentLocation1.latitude, currentLocation1.longitude);
      destinationLocation =
          LatLng(widget.latitude!, widget.longitude!);
      List<dynamic> data = [
        {
          "lat": currentLocation!.latitude,
          "lng": currentLocation!.longitude,
        }, {
          "lat": destinationLocation!.latitude,
          "lng": destinationLocation!.longitude
        },
      ];
      /*  for (var i = 0; i < data.length - 1; i++) {
          setState(() {
            distanceInMeters = distanceInMeters! + calculateDistance(
                data[i]["lat"], data[i]["lng"], data[i + 1]["lat"],
                data[i + 1]["lng"])!;
          });*/
      //     }


      // print(totalDistance);

    });
  }

  void setInitialLocation1() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Direction"),
      ),
      body: app ? GoogleMap(
        myLocationEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        polylines: _polylines,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);

          showMarker();
          setPolylines();
        },
        initialCameraPosition: CameraPosition(
          //target: LatLng(widget.sourcelatitude!,widget.sourcelongitude!),
          target: LatLng(
              currentLocation!.latitude, currentLocation!.longitude),
          zoom: 13,
        ),
      ) : Text(''), bottomSheet: Container(height: 200,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 30,),
        //  Text('Distance ${(distanceInMeters!).toString()}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.amber),),
        SizedBox(height: 20,),
        //   Text(' Rs ${(distanceInMeters!*20).toString()}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blue),),
        SizedBox(height: 20,),
        Container(color: Colors.amberAccent,
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(child: Center(child: Text('End Ride',
            style: TextStyle(fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.white),),), onTap: () {

            print('XYX test lat ${widget.accesstoken}');
            print('XYX test lat ${widget.droplatitude}');
            var data = {
              "req_id": widget.id,
            };
            BlocProvider.of<BookingCubit>(context).endRideDrivers(data, widget.accesstoken);

          }),)


      ],),), //bottomSheet: Container,
    );
  }

}
