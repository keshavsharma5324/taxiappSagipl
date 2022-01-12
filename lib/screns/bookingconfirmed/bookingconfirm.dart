
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiapp/Model/response/model/driversocket.dart';
import 'package:taxiapp/Model/response/model/profile/bookedride.dart';
import 'package:taxiapp/screns/bookingconfirmed/booking_cubit.dart';
import 'package:taxiapp/screns/bookingconfirmed/booking_screen.dart';
import 'package:taxiapp/utils/ColorHelper.dart';
import 'package:taxiapp/utils/imagehelper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
//import 'package:google_maps_flutter/google_maps_flutter.dart';

/*class Bookingconfirm extends StatefulWidget {
  Function? getbookingconfirmed;
  Ridebooked? ridebooked;
  double? latitude,longitude;
  Bookingconfirm({this.getbookingconfirmed,this.ridebooked,this.latitude,this.longitude});

  @override
  _BookingconfirmState createState() => _BookingconfirmState();
}

class _BookingconfirmState extends State<Bookingconfirm> {
  List<Image> checkboxbool =<Image>[Image.asset(bikeride),Image.asset(carride),Image.asset(auto)];
  final List<String> newData =<String>['Motor Bike','Car','Auto Rickha'];
  List<double>? newDistance;
  bool app  = false;int? id;
  Completer<GoogleMapController> mapController = Completer();

  Set<Marker> _markers = Set<Marker>();
  LatLng? currentLocation;
  LatLng? destinationLocation;
  double distanceInMeters = 0;
  List<dynamic>? data;
  bool price= false;//car=false,bike=false,auto=false;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  var fare; //= distanceInMeters! * 0.020;
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  double totalDistance = 0;
  /*for(var i = 0; i < data.length-1; i++){
  totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);
  }
  print(totalDistance);*/
  String name = 'xyz';
  String cab_number = 'NYK 1';
  double distance = 40;
  double rating=4.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.getbookingconfirmed!();
    polylinePoints = PolylinePoints();

    this.setInitialLocation();
    //Timer(Duration(seconds: 3), () {

    //this.distance();

    Timer(Duration(seconds: 3), () {
      setState(() {
        app=true;
      });
    });
  }

  void setInitialLocation() {
    setState(() {
      // newDistance =<double>[widget.distancebike!,widget.distancecar!,widget.distanceauto!];
      currentLocation =
          LatLng(widget.latitude!, widget.longitude!);
      destinationLocation =
          LatLng(widget.ridebooked!.success!.driverDetails![0].latitude!, widget.ridebooked!.success!.driverDetails![0].latitude!);
      data = [
        {
          "lat": currentLocation!.latitude,
          "lng": currentLocation!.longitude,
        },{
          "lat": destinationLocation!.latitude,
          "lng": destinationLocation!.longitude
        },
      ];
      for(var i = 0; i < data!.length-1; i++){
        setState(() {
          distanceInMeters = distanceInMeters! + calculateDistance(data![i]["lat"], data![i]["lng"], data![i+1]["lat"], data![i+1]["lng"])!;
        });}


      // print(totalDistance);

    });


  }

  //Timer? time= StackTrace.curren;

/*  var cp = CameraPosition(
    target: LatLng(51.52782851262915, -0.10701929241472438),
    zoom: 15.5,
    tilt: 0,
  );*/
  @override
  Widget build(BuildContext context) {

    return Scaffold(body:Stack(children:[
      app?GoogleMap(
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
          target: LatLng(currentLocation!.latitude,currentLocation!.longitude),
          zoom: 13,
        ),
      ):Text(''),


      Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
        SizedBox(height: 50,),
        Row(children:[SizedBox(width: 20,),
          SizedBox(height: 50,),
          Container(height:20,child:Image.asset(menu))
          //Icon(Icons.reorder),
        ]),
        //GoogleMap(initialCameraPosition: cp, mapType: MapType.normal),
        Container(padding: EdgeInsets.symmetric(horizontal:20,vertical: 0),
            width: MediaQuery. of(context). size. width ,
            height: 100,
            color: Colors.grey,//(0xffFFFFFF),
            child:Column(
              children: [

                Row(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          //topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(5),
                          //bottomRight: Radius.circular(20),
                        ),
                        border: Border.all(
                            width:1,
                            color:Colors.white
                        )
                    ),
                    //color: Colors.white,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    //  height: 105,
                    width: 50,

                    child: Column(
                      children: [
                        Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            //borderRadius: BorderRadius.circular(2),
                            // color: Color(0xffF9534B),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 37.39,
                          width: 0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff707070), width: 1),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right:0),
                          child: Icon(Icons.location_on,color: Colors.red,),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            // color: Color(0xff004238),
                            // shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.white,

                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height:  95,
                    width: 270,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1,color: Colors.white),
                      borderRadius: BorderRadius.only(
                        //topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        //bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      children: [
                        //SizedBox(height: 10,),
                        Container(
                           height:45,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextField(
                            textAlign: TextAlign.justify,
                            obscureText: false,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff004238)),
                            decoration: InputDecoration(

                              //isDense: true,
                              hintText: "933 Colin gateway Suite 973",
                              hintStyle: TextStyle(

                                color: Colors.black,
                                fontFamily: 'Gilroy',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.only(bottom: -15),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextField(

                            textAlign: TextAlign.justify,
                            obscureText: false,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff004238)),
                            decoration: InputDecoration(
                              //isDense: true,
                              hintText: "5342 Mauricio Walks",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gilroy',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.only(bottom: -15),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        //SizedBox(height:10)
                      ],
                    ),
                  ),
                  /* Container(
                          padding: EdgeInsets.fromLTRB(14, 110, 23.91, 0.91),
                          child: Icon(
                            Icons.add,
                            color: Color(0xff004238),
                          ))*/
                ]),

              ],
            )),

        Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [



          SizedBox(height: 50,),
          // Center(child:),
        ],



        )])
    ]),
      bottomSheet: Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(width: 1.0, color: Colors.grey),)),
          height:231,child:Column(children: [
        //SizedBox(height:20),
        //Center(child:Text('')),
        Container(height: 130,child:Row(children: [
          Container(margin: EdgeInsets.fromLTRB(10,70,10,0),width: 80,decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                fit: BoxFit.fill
            ),),),
          Container(width: MediaQuery.of(context).size.width-120,child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 20,),
              Text('Booking Confirmed',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text('${widget.ridebooked!.success!.driverDetails![0].firstName}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),),
              SizedBox(height: 5,),
              Container(height:20,child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                Icon(Icons.star_rounded,size: 18,color: Colors.orange),
                SizedBox(width: 5,),
                Text('$rating'),
                SizedBox(width: 10,),
                Text('|'),
                SizedBox(width: 10,),
                Text('1 MIN')

              ],)),
              SizedBox(height: 8,),
              Container(height:20,child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                Icon(Icons.directions_car,size: 18,),
                SizedBox(width: 5,),
                Text('${widget.ridebooked!.success!.driverDetails![0].taxiNo}'),
                SizedBox(width: 10,),
                Text('|'),
                SizedBox(width: 10,),
                Text('${widget.ridebooked!.success!.driverDetails![0].mobile}')

              ],)),


          ],))
        ],)),
        SizedBox(height: 20,),
        //Container(height: 20,child:TextField()),
        MaterialButton(onPressed: () {  },child: Container(padding: EdgeInsets.symmetric(horizontal:20),height: 50,width:MediaQuery.of(context).size.width,color: kPrimaryColor,child: Center(child:Text('CANCEL RIDE',style: TextStyle(fontSize: 17,color: Colors.white),)),),),
      SizedBox(height: 30,)
      ],))
      ,
    );
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

}*/
class StreamSocket {
  final _socketResponse = StreamController<Map<String, dynamic>>();

  void Function(Map<String, dynamic> data) get addResponse =>
      _socketResponse.sink.add;

  Stream<Map<String, dynamic>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class BookedRoute extends StatefulWidget {
  final dynamic? data;
  int? userid,driverid,idcar,idbike,idauto;
  String? accesstoken;
  Function? getbookingconfirmed;
  Ridebooked? bookedride;
  double? latitude,longitude,sourcelatitude,sourcelongitude,distancecar,distancebike,distanceauto;
  BookedRoute({this.bookedride,this.idauto,this.idbike,this.idcar,this.distancecar,this.distancebike,this.distanceauto,this.getbookingconfirmed,this.data,this.latitude,this.longitude,this.sourcelatitude,this.sourcelongitude,this.driverid,this.accesstoken,this.userid});
  @override
  _BookedRouteState createState() => _BookedRouteState();
}

class _BookedRouteState extends State<BookedRoute> {
  List<Image> checkboxbool =<Image>[Image.asset(bikeride),Image.asset(carride),Image.asset(auto)];
  final List<String> newData =<String>['Motor Bike','Car','Auto Rickha'];
  List<double>? newDistance;
  bool app  = false;int? id;
  Completer<GoogleMapController> mapController = Completer();
  StreamSocket? streamSocket = StreamSocket();
  Driver? driver;

  Set<Marker> _markers = Set<Marker>();
  LatLng? currentLocation;
  LatLng? destinationLocation;
  double distanceInMeters = 0;
  List<dynamic>? data;
  bool price= false;//car=false,bike=false,auto=false;
  late IO.Socket socket;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  var fare; //= distanceInMeters! * 0.020;
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  double totalDistance = 0;
  /*for(var i = 0; i < data.length-1; i++){
  totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);
  }
  print(totalDistance);*/
  void connect(){
    IO.Socket socket = IO.io('http://192.168.0.105:30011',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM

            .disableAutoConnect()  // disable auto-connection
            //.setExtraHeaders({'foo': 'bar'}) // optional
            .build()
    );
    socket.connected?null:socket.connect();
    socket.emit('msg', 'test');
    socket.on('on_connect', (data) {
      driver = Driver.fromJson(data);
      print(driver!.userName);
    });
    print(streamSocket!.getResponse);
   /* socket = IO.io("http://192.168.0.105:30011");
    //socket!.connect();
    socket.onConnect((data){print('Connected');});*/
    print('check socket connection: ${socket.connected}');


  }


  @override
  void initState() {
    super.initState();


    widget.getbookingconfirmed!();
    //connect();
    Timer(Duration(seconds: 3), () {
      polylinePoints = PolylinePoints();
      this.setInitialLocation();
    });

    //this.distance();

    Timer(Duration(seconds: 3), () {
      setState(() {
        app=true;
      });connect();
    });

  }

  void setInitialLocation() {
    setState(() {
      // newDistance =<double>[widget.distancebike!,widget.distancecar!,widget.distanceauto!];
      currentLocation =
          LatLng(widget.sourcelatitude!, widget.sourcelongitude!);
      destinationLocation =
     // LatLng(widget.latitude!,widget.longitude!);
          LatLng(widget.bookedride!.success!.driverDetails![0].latitude!, widget.bookedride!.success!.driverDetails![0].latitude!);
      data = [
        {
          "lat": currentLocation!.latitude,
          "lng": currentLocation!.longitude,
        },{
          "lat": destinationLocation!.latitude,
          "lng": destinationLocation!.longitude
        },
      ];
      for(var i = 0; i < data!.length-1; i++){
        setState(() {
          distanceInMeters = distanceInMeters + calculateDistance(data![i]["lat"], data![i]["lng"], data![i+1]["lat"], data![i+1]["lng"]);
        });}


      // print(totalDistance);

    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direction"),
      ),
      body: app?GoogleMap(
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
          target: LatLng(currentLocation!.latitude,currentLocation!.longitude),
          zoom: 13,
        ),
      ):Text(''),bottomSheet: app?Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(width: 1.0, color: Colors.grey),)),
        height:231,child:Column(children: [
      //SizedBox(height:20),
      //Center(child:Text('')),
      Container(height: 130,child:Row(children: [
        Container(margin: EdgeInsets.fromLTRB(10,70,10,0),width: 80,decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
              fit: BoxFit.fill
          ),),),
        Container(width: MediaQuery.of(context).size.width-120,child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('Booking Confirmed',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text('${widget.bookedride!.success!.driverDetails![0].firstName}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),),
            SizedBox(height: 5,),
            Container(height:20,child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
              Icon(Icons.star_rounded,size: 18,color: Colors.orange),
              SizedBox(width: 5,),
              Text('${widget.bookedride!.success!.driverDetails![0].taxiNo}'),
              SizedBox(width: 10,),
              Text('|'),
              SizedBox(width: 10,),
              Text('${widget.bookedride!.success!.driverDetails![0].mobile}')

            ],)),
            SizedBox(height: 8,),
            Container(height:20,child:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
              Icon(Icons.directions_car,size: 18,),
              SizedBox(width: 5,),
              Text('flflfl'),
              SizedBox(width: 10,),
              Text('|'),
              SizedBox(width: 10,),
              Text('flllllss')

            ],)),


          ],))
      ],)),
      SizedBox(height: 20,),
      //Container(height: 20,child:TextField()),
      MaterialButton(onPressed: () {  },child: Container(padding: EdgeInsets.symmetric(horizontal:20),height: 50,width:MediaQuery.of(context).size.width,color: kPrimaryColor,child: Center(child:Text('CANCEL RIDE',style: TextStyle(fontSize: 17,color: Colors.white),)),),),
      SizedBox(height: 30,)
    ],)):Center(child:CircularProgressIndicator())/*Container(height: 260,width: MediaQuery.of(context).size.width,child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
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
                  index<1?id=widget.idbike:index<2?id=widget.idcar:index<3?id=widget.idauto:null;
                  price = true;
                  distanceInMeters = 0;
                  distanceInMeters =  calculateDistance(data![0]["lat"], data![0]["lng"], data![0+1]["lat"], data![0+1]["lng"])!;

                  index<1?distanceInMeters=distanceInMeters*2:index<2?distanceInMeters=distanceInMeters*5:index<3?distanceInMeters=distanceInMeters*3:null;
                });
              },child:Center(child:Container(width: 70,height: 60,child:checkboxbool[index])),),
              SizedBox(height: 7,),
              Text('${newData[index]}',style: TextStyle(fontSize: 14),),
              SizedBox(height:7),
              InkWell(onTap: (){
                setState(() {
                  //id = null;

                });
              },child: Text('${(index==0?widget.distancebike:index==1?widget.distancecar:index==2?widget.distanceauto:null)!.toStringAsFixed(3)} Kms',style: TextStyle(fontSize: 14,color:Colors.grey)),)


            ],),));}),),

      //SizedBox(height: 30,),
      //Text('time ${(widget.distance!=null?widget.distance:0).toString()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.amber),),
      //Text('Distance ${(distanceInMeters!).toString()}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.amber),),

      price?Text(' Rs ${(distanceInMeters!*3)!.toStringAsFixed(2)}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blue),):Text(''),
      SizedBox(height: 10,),




    ],),),*///bottomSheet: Container,
    );
  }

  /*void distance()async{
    distanceInMeters = await (Geolocator.bearingBetween(
      currentLocation!.latitude,
      currentLocation!.longitude,
      destinationLocation!.latitude,
      destinationLocation!.longitude,
    )).abs();
    print(distanceInMeters);
    setState(() {
      fare = distanceInMeters! * 20;
    });}*/

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

  /*double distanceInMeters = await Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      destinationLatitude,
      destinationLongitude,
      );*/

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
}


