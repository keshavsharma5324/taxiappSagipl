//import 'package:pubspec/models/location.dart';
import 'package:taxiapp/google%20map/models/location.dart';

class Geometry {
  final Location? location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Geometry(location: Location.fromMap(parsedJson['location']));
  }
}
