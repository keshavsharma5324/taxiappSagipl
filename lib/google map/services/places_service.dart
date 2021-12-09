import 'package:http/http.dart' as http;
//import 'package:pubspec/models/place.dart';
import 'dart:convert' as convert;

//import 'package:pubspec/models/place_search.dart';
import 'package:taxiapp/google%20map/models/place.dart';
import 'package:taxiapp/google%20map/models/place_search.dart';

class PlacesService {
  final key = 'AIzaSyAvFh2R7W_4hVBK_UAo5B64iriZLsyaqRo';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    //search 가 쿼리, 즉 서치 파라미터
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
    var response = await http
        .get(Uri.parse(url)); //url 그냥 넣으면 오류 나서 Uri.parse 안에 넣음, 에러 나면 확인하기
    var json = convert.jsonDecode(response.body);
    var jsonResults =
        json['predictions'] as List; //API의 predictions object를 list로 가져옴
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    //search 가 쿼리, 즉 서치 파라미터
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId';
    var response = await http
        .get(Uri.parse(url)); //url 그냥 넣으면 오류 나서 Uri.parse 안에 넣음, 에러 나면 확인하기
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }
}
