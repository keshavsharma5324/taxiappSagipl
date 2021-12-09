/*import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// const apiKey = "AIzaSyC_9yGoi8lwRjmUm2ey-vEI8ZvHbNoOA6Y";
const apiKey = "AIzaSyBj2HQeHqv0yHX07at8g4xTrE9C52-Hb_A";

class GoogleMapsServices{
  final Set<Polyline> _polyLines = {};
  Set<Polyline> get polyLines => _polyLines;

  final Dio _dioClient = Dio(BaseOptions(
      baseUrl: 'https://projects.adsandurl.com/nitiya/api/',
      connectTimeout: 1000,
      receiveTimeout: 1000,
      headers: {
        'Appversion': '1.0',
        'Ostype': Platform.isAndroid ? 'android' : 'ios'
      }));

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    print('route url -> $url');
    Response response = await _dioClient.get(url);
    print('Map response -> $response');
    Map values = response.data;
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Set<Polyline> createRoute(String encondedPoly, LatLng latLng) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 5,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
    return _polyLines;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      }
      while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++)
      lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }
}*/