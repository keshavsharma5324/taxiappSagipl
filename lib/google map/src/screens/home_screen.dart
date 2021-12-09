/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:pubspec/blocs/application_bloc.dart';
//import 'package:pubspec/models/place.dart';
import 'package:taxiapp/google%20map/blocs/application_bloc.dart';
import 'package:taxiapp/google%20map/models/place.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;

  @override
  void initState() {
    final applicationBloc =
        BlocProvider.of<ApplicationBloc>(context, listen: false);

    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    //to make sure that all streams get disposed
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  //검색창에 margin
                  padding: const EdgeInsets.all(8.0),
                  child: Container(child:TextField(
                    decoration: InputDecoration(
                        hintText: 'Search Location',
                        suffixIcon: Icon(Icons.search)),
                    onChanged: (value) => applicationBloc.searchPlaces(value),
                  ),
                ),),
                Stack(
                  //검색 예상 결과 리스트를 보여주는부분, 스택과 리스트로 보여줌
                  children: [
                    Container(
                      height: 300.0,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBloc.currentLocation.latitude,
                                applicationBloc.currentLocation.longitude),
                            zoom: 14), //서울 : 37.56, 126.97
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                      ),
                    ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300.0, //검색어 리스트도 맵이랑 같은height
                        width: double.infinity, //리스트 아래로 무한대
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.6),
                            backgroundBlendMode: BlendMode.darken),
                      ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300.0,
                        child: ListView.builder(
                            itemCount: applicationBloc.searchResults.length,
                            itemBuilder: (contex, index) {
                              return ListTile(
                                title: Text(
                                  applicationBloc
                                      .searchResults[index].description.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  applicationBloc.setSelectedLocation(
                                      applicationBloc
                                          .searchResults[index].placeId.toString());
                                },
                              );
                            }),
                      )
                  ],
                )
              ],
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry!.location!.lat!, place.geometry!.location!.lng!),
        zoom: 14.0)));
  }
}*/
