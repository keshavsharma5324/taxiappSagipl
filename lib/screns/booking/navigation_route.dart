/*import 'package:flutter/material.dart';
import 'package:flutter_maps/map.dart';
import 'package:flutter_maps/map_page.dart';
import 'package:flutter_maps/secrets.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' show cos, sqrt, asin;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapPage()//MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  late Position _currentPosition;
  String _currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Map View
            GoogleMap(
              markers: Set<Marker>.from(markers),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show the place input fields & button for
            // showing the route
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Places',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Start',
                              hint: 'Choose starting point',
                              prefixIcon: Icon(Icons.looks_one),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  startAddressController.text = _currentAddress;
                                  _startAddress = _currentAddress;
                                },
                              ),
                              controller: startAddressController,
                              focusNode: startAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _startAddress = value;
                                });
                              }),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Destination',
                              hint: 'Choose destination',
                              prefixIcon: Icon(Icons.looks_two),
                              controller: destinationAddressController,
                              focusNode: desrinationAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _destinationAddress = value;
                                });
                              }),
                          SizedBox(height: 10),
                          Visibility(
                            visible: _placeDistance == null ? false : true,
                            child: Text(
                              'DISTANCE: $_placeDistance km',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: (_startAddress != '' &&
                                    _destinationAddress != '')
                                ? () async {
                                    startAddressFocusNode.unfocus();
                                    desrinationAddressFocusNode.unfocus();
                                    setState(() {
                                      if (markers.isNotEmpty) markers.clear();
                                      if (polylines.isNotEmpty)
                                        polylines.clear();
                                      if (polylineCoordinates.isNotEmpty)
                                        polylineCoordinates.clear();
                                      _placeDistance = null;
                                    });

                                    _calculateDistance().then((isCalculated) {
                                      if (isCalculated) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Distance Calculated Sucessfully'),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Error Calculating Distance'),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Show Route'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*import 'dart:async';
import 'dart:math';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/abc.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "API_KEY";

main() {
  runApp(RoutesWidget());
}

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

class RoutesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "My App",
    theme: customTheme,
    routes: {
      "/": (_) => MyApp(),
      "/search": (_) => CustomSearchScaffold(),
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _MyAppState extends State<MyApp> {
  Object _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDropdownMenu(),
              ElevatedButton(
                onPressed: _handlePressButton,
                child: Text("Search places"),
              ),
              ElevatedButton(
                child: Text("Custom"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/search");
                },
              ),
            ],
          )),
    );
  }

  Widget _buildDropdownMenu() => DropdownButton(
    value: _mode,
    items: <DropdownMenuItem<Mode>>[
      DropdownMenuItem<Mode>(
        child: Text("Overlay"),
        value: Mode.overlay,
      ),
      DropdownMenuItem<Mode>(
        child: Text("Fullscreen"),
        value: Mode.fullscreen,
      ),
    ],
    onChanged: (m) {
      setState(() {
        _mode = m.toString();
      });
    },
  );

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage.toString())),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode as Mode,
      language: "fr",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "fr")],
    );

    displayPrediction(p!, homeScaffoldKey.currentState!);
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}

// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
    language: "en",
    components: [Component(Component.country, "uk")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState!);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(response.errorMessage.toString())),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse? response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState!.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}*/
/*import 'package:flutter/material.dart';
//import 'package:flutter_maps/map_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:testapp/map_page.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

// Your api key storage.
//import 'keys.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Light Theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Place Picker Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: Mapa(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickResult? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map Place Picer Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text("Load Google Map"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        var apiKey='AIzaSyA3T0PxYDdhaXFY_MD-tPodFI-V6cesl0I';
                        return PlacePicker(
                          apiKey: apiKey,
                          initialPosition: HomePage.kInitialPosition,
                          useCurrentLocation: true,
                          selectInitialPosition: true,

                          //usePlaceDetailSearch: true,
                          onPlacePicked: (result) {
                            selectedPlace = result;
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          //forceSearchOnZoomChanged: true,
                          //automaticallyImplyAppBarLeading: false,
                          //autocompleteLanguage: "ko",
                          //region: 'au',
                          //selectInitialPosition: true,
                          // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                          //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                          //   return isSearchBarFocused
                          //       ? Container()
                          //       : FloatingCard(
                          //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                          //           leftPosition: 0.0,
                          //           rightPosition: 0.0,
                          //           width: 500,
                          //           borderRadius: BorderRadius.circular(12.0),
                          //           child: state == SearchingState.Searching
                          //               ? Center(child: CircularProgressIndicator())
                          //               : RaisedButton(
                          //                   child: Text("Pick Here"),
                          //                   onPressed: () {
                          //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                          //                     //            this will override default 'Select here' Button.
                          //                     print("do something with [selectedPlace] data");
                          //                     Navigator.of(context).pop();
                          //                   },
                          //                 ),
                          //         );
                          // },
                          // pinBuilder: (context, state) {
                          //   if (state == PinState.Idle) {
                          //     return Icon(Icons.favorite_border);
                          //   } else {
                          //     return Icon(Icons.favorite);
                          //   }
                          // },
                        );
                      },
                    ),
                  );
                },
              ),
              selectedPlace == null ? Container() : Text(selectedPlace!.formattedAddress ?? ""),
            ],
          ),
        ));
  }
}*/
//import 'dart:html';
//comment for uberclone app project test
/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testapp/places_google.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()//(title: 'Flutter Demo Home Page'),
    );
  }
}
const apiKey="AIzaSyAvFh2R7W_4hVBK_UAo5B64iriZLsyaqRo";
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Completer<GoogleMapController> controller1;
  //late Completer<GoogleMapController> controller1;

  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  late  LatLng _initialPosition;
  final Set<Marker> _markers = {};
  late LatLng _lastMapPosition = _initialPosition;
  bool map = false;
  double? lat1;
  double? lng1;

  @override
  void initState() {

    super.initState();
    _getUserLocation();
   // widget.getnearby!();
    Timer(Duration(seconds: 3), () {
      setState(() {
       // map = true;
      });
    });
    _controller.addListener(() {
      _onChanged();
    });

    //timer
  }

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

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition,
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
  TextEditingController _controllerFromLocation = TextEditingController();
  TextEditingController _controllerToLocation = TextEditingController();
  LatLng? _latLngFrom;
  LatLng? _latLngTo;
  BuildContext? _context;
  String? _sourceTitle;
  String? _destTitle;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiKey);
  _openAutoComplete(int type) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
        radius: 1000,
        types: [],
        strictbounds: false,
        region: "in",
        context: context,
        apiKey: apiKey,
        onError: onError,
        language: "es",
        components: [Component(Component.country, "in")],
        mode: Mode.fullscreen);
    displayPredictionSource(p, type);
  }

  void onError(PlacesAutocompleteResponse response) {
    print('Error => ${response.errorMessage}');
  }

  Future<Null> displayPredictionSource(Prediction? p, int type) async {
    if (p != null) {

      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId.toString());
      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      //type == 1 ?
      //_sourceTitle = detail.result.name; //:
       _destTitle =
          detail.result.name;

      //type == 1 ?
      _latLngTo = LatLng(lat, lng);// : _latLngTo = LatLng(lat, lng);

      setState(() {
        lat1 =lat;
        lng1 = lng;
        map = true;
        _initialPosition =LatLng(lat1!, lng1!);
        /*controller1.animateCamera(
          CameraUpdate.newCameraPosition(
            const CameraPosition(
              bearing: 270.0,
              target: LatLng(51.5160895, -0.1294527),
              tilt: 30.0,
              zoom: 17.0,
            ),
          ),
        );*/

       /* controller1.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(37.4219999, -122.0862462), zoom: 20.0),
          ),
        );*/
      });


     /* if (_latLngFrom != null && _latLngTo != null) {
        _context.cubit<TaxiListCubit>().getTaxiList();
      }*/
    }
  }


  var _controller = TextEditingController();
  var uuid = new Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];



  _getAddress(LatLng coordinates) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(coordinates.latitude,coordinates.longitude);
   /* var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);*/
    var first = placemarks.first;
    _controllerFromLocation.text = first.toString();
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAvFh2R7W_4hVBK_UAo5B64iriZLsyaqRo";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }
  /*Future<void> _goToTheLake() async {
    //var future;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/

  @override
  Widget build(BuildContext context) {
    var _controllerToLocation;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
              map?Container(height:MediaQuery.of(context).size.height-430,child: GoogleMap(

                // myLocationEnabled: true,
                //compassEnabled: false,
                tiltGesturesEnabled: false,
                markers: _markers,
                // polylines: _polylines,
                // mapType: MapType.normal,
                //initialCameraPosition: initialLocation,
                //onMapCreated: onMapCreated
                //markers: _markers,

                mapType: _currentMapType,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 14.4746,
                ),
                onMapCreated:(controller) {controller1.complete(controller);},
                zoomGesturesEnabled: true,
                onCameraMove: _onCameraMove,
                myLocationEnabled: true,
                compassEnabled: true,
                myLocationButtonEnabled: false,

              ),):Text('')



              // SizedBox(height: 50,),
              // Center(child:),
            ],



            )
          ],
        ),
      ),
    );
  }

}*/
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/screns/booking/booking_cubit.dart';
import 'package:taxiapp/screns/booking/endride.dart';
import 'package:taxiapp/screns/booking/endride_screen.dart';


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
      home: NavigationRoute(),//MyHomePage(title: 'Uber clone'),
    );
  }
}
const LatLng SOURCE_LOCATION = LatLng(28.624363599725164, 77.20657210920679);
const LatLng DEST_LOCATION = LatLng(28.53853225321175, 77.39480307139767);

class NavigationRoute extends StatefulWidget {

  final dynamic? data;
  int? id;
  String? accesstoken;
  double? latitude,longitude,sourcelatitude,sourcelongitude,droplatitude,droplongitude;
  NavigationRoute({this.data,this.latitude,this.longitude,this.sourcelatitude,this.sourcelongitude,this.id,this.accesstoken,this.droplatitude,this.droplongitude});
  @override
  _NavigationRouteState createState() => _NavigationRouteState();
}

class _NavigationRouteState extends State<NavigationRoute> {
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
      print('cab lat ${widget.droplongitude}');
      this.setCurrentLocation();


    });


    //Timer(Duration(seconds: 3), () {

    //this.distance();
    Timer(Duration(seconds: 3), () {
      this.setInitialLocation();
      setState(() {
        app= true;
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
            ride?LatLng(widget.latitude!, widget.longitude!):LatLng(widget.droplatitude!, widget.droplongitude!);
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
          ride?Container(color: Colors.amberAccent,
            height: 50,
            width: MediaQuery
                .of(context)
                .size
                .width,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(child: Center(child: Text('Confirm Booking',
              style: TextStyle(fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white),),), onTap: () {
              print('XYX test lat ${widget.accesstoken}');
              print('XYX test lat ${widget.id}');
              var data = {
                "req_id": widget.id
                //"ext": Constants.defaultCountryCode,
                //  "user_type": Constants.userTypePassenger,
              };
              _globalKey.currentContext!.read<BookingCubit>().startRideDrivers(data, widget.accesstoken);
             /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EndRide(id:widget.id,accesstoken: widget.accesstoken,droplatitude: widget.droplatitude,droplongitude: widget.droplatitude,)),
              );*/
              setState(() {
                ride =! ride;
              });


            }),):Container(color: Colors.amberAccent,
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
              print('XYX test lat ${widget.id}');
              var data = {
                "req_id": widget.id,
              };
              _globalKey.currentContext!.read<BookingCubit>().endRideDrivers(data, widget.accesstoken);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EndRideScreen(id:widget.id,accesstoken: widget.accesstoken,latitude: widget.droplatitude,longitude: widget.droplongitude,)),
              );

            }),)


        ],),), //bottomSheet: Container,
      );
    }

  }




