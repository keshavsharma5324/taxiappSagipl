
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiapp/Model/response/model/nearest.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:ui' as ui;

import 'package:taxiapp/utils/imagehelper.dart';

class NearbyScreen extends StatefulWidget {
  Nearest? nearest;
   NearbyScreen({this.nearest});

  @override
  _NearbyScreenState createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  List<Image> checkboxbool =<Image>[Image.asset(bikeride),Image.asset(carride),Image.asset(auto)];
  final List<String> newData =<String>['Motor Bike','Car','Auto Rickha'];
  bool map =true;
  Uint8List? markerIcon;
  final Set<Marker> _markers = {};
  LatLng? _lastMapPosition;
  late LatLng currentlocation;
  Nearest? nearest;

  setlastmapposition(){

    setState(() {
      _lastMapPosition =  LatLng(widget.nearest!.order![0].latitude!, widget.nearest!.order![0].longitude!);//widget.nearest.order[0].latitude
    currentlocation = LatLng(double.parse(widget.nearest!.startlat!),double.parse(widget.nearest!.startlng!));
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();connect();
    //
    Timer(Duration(seconds: 1), () {
      setState(() {
        _lastMapPosition =  LatLng(nearest!.order![2].latitude!, nearest!.order![2].longitude!);
        //setlastmapposition();
        map = false;_onAddMarkerButtonPressed();
      });
    });

  }
  void connect()async{
    // Position position = await _getGeoLocationPosition();
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

      nearest = Nearest.fromJson(data);
      // print(nearest!.startlng.toString());
      //  print(driver!.userName);
    });

    print('check socket connection: ${socket.connected}');


  }


  @override
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  _onAddMarkerButtonPressed()async {
    markerIcon = await getBytesFromAsset(splashLogo, 100);
    setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition!,//draggable: true,
              onDragEnd: ((newPosition) {
                print(newPosition.latitude);
                print(newPosition.longitude);
              }),
              infoWindow: InfoWindow(
                  title: "Pizza Parlour",
                  snippet: "This is a snippet",
                  onTap: (){
                  }
              ),
              onTap: (){
              },

              icon: BitmapDescriptor.fromBytes(markerIcon!)));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(body:
    map?Align(alignment: Alignment.center,child:CircularProgressIndicator()):Stack(
    //검색 예상 결과 리스트를 보여주는부분, 스택과 리스트로 보여줌
    children: [
    Container(
    height: MediaQuery.of(context).size.height-256,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: _markers,//Set<Marker>.of(markers.values),//
        //polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: CameraPosition(
            target: LatLng(
              double.parse(nearest!.startlat!),
              double.parse(nearest!.startlng!)),
            zoom: 15), //서울 : 37.56, 126.97
       /* onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },*/
      ),
    ),
    ],),bottomSheet: map?SizedBox():Container(height: 260,width: MediaQuery.of(context).size.width,child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
      Container(height: 134,child:
      ListView.builder(scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: newData.length,
          itemBuilder: (BuildContext context, int index) {
            //var? iconData;
            return MaterialButton(onPressed: (){

              setState(() {
                //widget.distance =
              });
            },child:Container(height: 157,width: 90,padding:EdgeInsets.only(top:10),child: Column(children: [
              InkWell(onTap: (){
                setState(() {
                  index<1?_lastMapPosition =  LatLng(nearest!.order![0].latitude!, nearest!.order![0].longitude!):index<2?_lastMapPosition =  LatLng(nearest!.order![1].latitude!, nearest!.order![1].longitude!):index<3?_lastMapPosition =  LatLng(nearest!.order![2].latitude!, nearest!.order![2].longitude!):null;
                  //price = true;
                //  distanceInMeters = 0;
                 // distanceInMeters =  calculateDistance(data![0]["lat"], data![0]["lng"], data![0+1]["lat"], data![0+1]["lng"]);

                  //index<1?distanceInMeters=distanceInMeters*2:index<2?distanceInMeters=distanceInMeters*5:index<3?distanceInMeters=distanceInMeters*3:null;
                });print(_lastMapPosition);
              },child:Center(child:Container(width: 70,height: 60,child:checkboxbool[index])),),
              SizedBox(height: 7,),
              Text('${newData[index]}',style: TextStyle(fontSize: 14),),
              SizedBox(height:7),
              InkWell(onTap: (){
                setState(() {
                  //id = null;

                });
              },child: Text('${(index==0?nearest!.order![0].firstName:index==1?nearest!.order![1].firstName:index==2?nearest!.order![2].firstName:null)!} Kms',style: TextStyle(fontSize: 14,color:Colors.grey)),)


            ],),));}),),

      //SizedBox(height: 30,),
      //Text('time ${(widget.distance!=null?widget.distance:0).toString()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.amber),),
      //Text('Distance ${(distanceInMeters!).toString()}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.amber),),

     // price?Text(' Rs ${(distanceInMeters*3).toStringAsFixed(2)}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blue),):Text(''),
      SizedBox(height: 10,),
      Container(color: Colors.amberAccent,height: 50,width: MediaQuery.of(context).size.width,margin: EdgeInsets.symmetric(horizontal: 16),child: InkWell(child: Center(child:Text('Confirm Booking',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: Colors.white),),),onTap: (){
        setState(() {
         /* context.read<BookingCubit>().requestNearbyDrivers({

            "driver_id": id,
            "user_id" : widget.userid,
            "latitude": widget.sourcelatitude,//latitude,
            "longitude": widget.sourcelongitude,//identifier
            "destination_latitude": widget.latitude,//latitude,
            "destination_longitude": widget.longitude,

          }, widget.accesstoken);*/

        });
       // print('XYX test lat ${widget.accesstoken}');
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingConfirmScreen(userid: widget.userid,driverid: widget.driverid,accesstoken: widget.accesstoken!,latitude: widget.latitude,longitude: widget.longitude,sourcelatitude: widget.sourcelatitude,sourcelongitude: widget.sourcelongitude,)),
        );*/
        /* Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingConfirmScreen(latitude: widget.sourcelatitude,longitude: widget.sourcelongitude,userid: widget.userid,driverid: widget.driverid,accesstoken: widget.accesstoken!,)),
        );*/

      }),)



    ],),),);
  }
}
