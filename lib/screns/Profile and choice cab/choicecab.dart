
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' ;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:taxiapp/google%20map/models/location.dart';
import 'package:taxiapp/google%20map/models/place.dart';
import 'package:taxiapp/google%20map/models/place_search.dart';
import 'package:taxiapp/route/route_constant.dart';
import 'package:taxiapp/screns/booking/booking_screen.dart';
//import 'package:taxiapp/google%20map/services/geolocator_service.dart';

import 'package:taxiapp/service/navigation_service.dart';
import 'package:taxiapp/utils/ColorHelper.dart';
import 'package:taxiapp/utils/imagehelper.dart';

import 'get_nearby_derivers_cubit.dart';
import '../booking/navigation_route.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookRide extends StatefulWidget {
 // const BookRide({Key? key}) : super(key: key);

  double? distance;
  double? latitude,longitude;
  String? accesstoken;
  int? userid,driverid;
  Function? getnearby;
  BookRide({this.longitude,this.latitude,this.accesstoken,this.userid,this.driverid,this.getnearby,this.distance});


  @override
  _BookRideState createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  GoogleMapController? mapController;
  LatLng? dest;
  double _originLatitude = 26.48424, _originLongitude = 50.04551;
  double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAvFh2R7W_4hVBK_UAo5B64iriZLsyaqRo";
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription? locationSubscription;
  bool map = true;
  var _controller = TextEditingController();
  String? getplaceid;
  late String autcomplete;
  final Set<Marker> _markers = {};
  List<Location>? locations;

  Location? loc;

  var timeout = Duration(seconds: 3);
 // var _scaffoldKey;
  List<Image> checkboxbool =<Image>[Image.asset(bikeride),Image.asset(carride),Image.asset(auto)];
  //final List<String>  =<String>['Motor Bike','Car','Auto Rickha'];
  final List<int> newTime =<int>[2,5,7];
  String name = 'xyz';
  String cab_number = 'NYK 1';
  double distance = 40;
  double rating=4.0;
  late Position currentLocation1;
  //Timer? time= StackTrace.curren;

/*  var cp = CameraPosition(
    target: LatLng(51.52782851262915, -0.10701929241472438),
    zoom: 15.5,
    tilt: 0,
  );*/
  late Completer<GoogleMapController> controller1;

  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  late  LatLng _initialPosition=LatLng(5.4444,3.0012);
  //final Set<Marker> _markers = {};
  late LatLng _lastMapPosition = LatLng(currentLocation.longitude,currentLocation.latitude);
  bool map1 = false;

  @override
  void initState() {
    // final applicationBloc =
    //   Provider.of<ApplicationBloc>(context, listen: false);
    setCurrentLocation();
    widget.getnearby!();
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    Timer(Duration(seconds: 3), () {

    });

    //super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        map = false;
      });
    });
    setState(() {
      locationSubscription =
          selectedLocation.stream.listen((place) {
            if (place != null) {
              _goToPlace(place);
            }
          });

    });


    /*_controller.addListener(() {
       _onChanged();
     });*/
    Timer.periodic(Duration(seconds: 5), (timer) {
      _onAddMarkerButtonPressed();
    });

    /*Timer(Duration(seconds: 3), () {
      setState(() {
        setCurrentLocation();

      });
    });*/
    //_destLatitude = widget!.latitude!;
    //_destLongitude = widget!.longitude!;
    //

   // BlocProvider.of<NearbyDetailsCubit>(context).getAutoCompletePlaces(autcomplete);
   // BlocProvider.of<NearbyDetailsCubit>(context).placeSearchDetails(getplaceid);

    super.initState();
    Timer(Duration(seconds: 3),(){
      setState(() {


      });
    });
  }

  /*_onChanged() {

    searchPlaces(_controller.text);
  }*/

 /* @override
  void dispose() {
    //to make sure that all streams get disposed
    // final applicationBloc =
    //     Provider.of<ApplicationBloc>(context, listen: false);
    //  applicationBloc.dispose();
    locationSubscription!.cancel();
    super.dispose();
  }*/

  //final geoLocatorService = GeolocatorService();
  //final placesService = PlacesService();

  //Variables
  late Position currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();

  /*ApplicationBloc() {
    setCurrentLocation();
  }*/
  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude,_destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    //polylines.clear();
    _addPolyLine();
  }

  setCurrentLocation() async {
    currentLocation = await BlocProvider.of<NearbyDetailsCubit>(context).getCurrentLocation();//geoLocatorService.getCurrentLocation();
    print(currentLocation);
    setState(() {
      currentLocation;
      _lastMapPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
      // LatLng(_destLatitude, _destLongitude);
      //_originLatitude = currentLocation.latitude;
      //_originLongitude = currentLocation.longitude;

    });

    //notifyListeners();
  }
  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
        LatLng(place.geometry!.location!.lat!.toDouble(), place.geometry!.location!.lng!.toDouble()),
        zoom: 14.0)));
  }

  searchPlaces(String searchTerm) async {

    searchResults = await BlocProvider.of<NearbyDetailsCubit>(context).getAutoCompletePlaces(searchTerm);//placesService.getAutocomplete(autcomplete);
    setState(() {
      searchResults;
    });


    // notifyListeners();
  }

  //call from the view that will trigger the ,, get the place id, and pass it back and upadate the stream etc,,
  setSelectedLocation(String placeId) async {

    selectedLocation.add(await BlocProvider.of<NearbyDetailsCubit>(context).placeSearchDetails(placeId));//placesService.getPlace(getplaceid));
    searchResults = null;
    setState(() {
      searchResults;
    });
    //notifyListeners();
  }


  /*@override
  void initState() {

    super.initState();
    _getUserLocation();
    widget.getnearby!();
    Timer(Duration(seconds: 3), () {
      setState(() {
        map = true;
      });
    });

    //timer
  }*/
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition =LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
   });


  }


  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  /*_onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }*/

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition,draggable: true,
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

              icon: BitmapDescriptor.defaultMarker));
    });
  }
  void _onMap1Created(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(body:

    map//(currentLocation == null)
        ? Center(
      child: CircularProgressIndicator(),
    )
        : SafeArea(child: Stack(children:[Column(
      children: [

    Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
    Container(height: 92.4,
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
            height: 20,
            width: 22,
            decoration: BoxDecoration(
              // color: Color(0xff004238),
              // shape: BoxShape.rectangle,
            ),
          ),
        ],
      ),
    ),
Container(color: Color(0xffFFFFFF),width: MediaQuery.of(context).size.width-50,child:Column(children:[
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
      onChanged: (value) =>

          searchPlaces(value),
    decoration: InputDecoration(
      hintText: 'Search Location',
      suffixIcon: Icon(Icons.search),
    //isDense: true,
   // hintText: "5342 Mauricio Walks",
    hintStyle: TextStyle(height: 2,
    color: Colors.black,
    fontFamily: 'Gilroy',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    ),
    contentPadding: EdgeInsets.only(bottom: -15),
    focusedBorder: UnderlineInputBorder(),
    ),
    ),
    ),]),)]),
    //SizedBox(height:10)

        /*Padding(
          //검색창에 margin
          padding: const EdgeInsets.all(8.0),
          child: Container(child:TextField(
            decoration: InputDecoration(
                hintText: 'Search Location',
                suffixIcon: Icon(Icons.search)),
            //controller: _controller,
            onChanged: (value) =>

                searchPlaces(value),
          ),
          ),),*/
        Stack(
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
                        currentLocation.latitude,
                        currentLocation.longitude),
                    zoom: 15), //서울 : 37.56, 126.97
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
              ),
            ),
            if (searchResults != null &&
                searchResults!.length != 0)
              Container(
                height: 300.0, //검색어 리스트도 맵이랑 같은height
                width: double.infinity, //리스트 아래로 무한대
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    backgroundBlendMode: BlendMode.darken),
              ),
            if (searchResults != null &&
                searchResults!.length != 0)
              Container(
                height: 300.0,
                child: ListView.builder(
                    itemCount: searchResults!.length,
                    itemBuilder: (contex, index) {
                      return ListTile(
                        title: Text(
                          searchResults![index].description.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async{
                          setSelectedLocation(
                              searchResults![index].placeId.toString());
                          locations = (await locationFromAddress(searchResults![index].description.toString())).cast<Location>() ;
                         // print('heren  is code $locations');
                          setState(() {

                            _destLatitude = locations![0].latitude;
                            _destLongitude = locations![0].longitude;
                            _lastMapPosition = LatLng(_destLatitude, _destLongitude);
                           // _onAddMarkerButtonPressed();
                          });
                          print(locations);
                        },
                      );
                    }),
              )
          ],
        )
      ],
    ),])),


      bottomSheet: map?SizedBox(height: 0,):Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.0, color: Colors.grey),)),
          height:111,child:Column(children: [
        SizedBox(height:20),
        //Center(child:Text('')),
       /* Container(height: 130,child:
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
    },child:Container(height: 140,width: 90,padding:EdgeInsets.only(top:10),child: Column(children: [
      Center(child:Container(width: 70,height: 60,child:checkboxbool[index])),
      SizedBox(height: 7,),
      Text('${newData[index]}',style: TextStyle(fontSize: 14),),
      SizedBox(height:7),
     // Text('${widget.distance!.toStringAsPrecision(3)} Kms',style: TextStyle(fontSize: 10,color:Colors.grey))


    ],),));}),),
        SizedBox(height: 10,),*/
        //Container(height: 20,child:TextField()),
        MaterialButton(onPressed: ()async {
          final distanceInMeters = await Geolocator.bearingBetween(
            currentLocation!.latitude,
            currentLocation!.longitude,
            _destLatitude,
            _destLongitude
          );/*setState(() {
          context.read<NearbyDetailsCubit>().requestNearbyDrivers({
            //   "email": phone,
            //  "password": password,
            "driver_id": widget.driverid,
            "user_id" : widget.userid,
            "latitude": widget.latitude,//latitude,
            "longitude": widget.longitude,//identifier
            "destination_latitude": _destLatitude,//latitude,
            "destination_longitude": _destLongitude,
            //"ext": Constants.defaultCountryCode,
            //"user_type": Constants.userTypePassenger,
          }, widget.accesstoken);
          //print('${widget.id} fkfkkkgk' );
          var args = {
            "latitude": widget.latitude,
            "longitude": widget.longitude,
            //"type": Constants.loginTypeRegistration
          };*/
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingScreen(userid: widget.userid,driverid: widget.driverid,accesstoken: widget.accesstoken!,latitude: _destLatitude,longitude: _destLongitude,sourcelatitude: currentLocation.latitude,sourcelongitude: currentLocation.longitude,)),
          );
          //NavigationService().navigationKey.currentState!.pushNamed(navigationroute, arguments: args);



 //       );
        print('check latitude ${widget.accesstoken}');
        },child: Container(padding: EdgeInsets.symmetric(horizontal:20),height: 50,width:MediaQuery.of(context).size.width,color: kPrimaryColor,child: Center(child:Text('CONTINUE GET RIDES',style: TextStyle(fontSize: 17,color: Colors.white),)),),),
        SizedBox(height: 30,)
      ],))
      ,
    );
  }
 /* void _updatePosition(CameraPosition _position) {
    Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    Marker marker = markers["1"]!;

    setState(() {
      markers['${1}'] = marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    });
  }*/

}
