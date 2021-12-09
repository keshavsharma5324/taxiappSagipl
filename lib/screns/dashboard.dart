import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class AskForPermission extends StatefulWidget {
  @override
  _AskForPermissionState createState() => _AskForPermissionState();
}

class _AskForPermissionState extends State<AskForPermission> {

 /* var cp = CameraPosition(
    target: LatLng(51.52782851262915, -0.10701929241472438),
    zoom: 15.5,
    tilt: 0,
  );*/

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Text('check this page after some time')//GoogleMap(initialCameraPosition: cp, mapType: MapType.normal)
  );
}
