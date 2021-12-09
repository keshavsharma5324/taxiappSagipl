class PlaceSearch {
  final String? description;
  final String? placeId;

  PlaceSearch({this.description, this.placeId});

  //API로 받아온 json값을 dart로 바꾸는 부분
  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
        description: json['description'], placeId: json['place_id']);
    //API에서 'description'부분과 'place_id'라고 되어있는 부분을 클래스의 변수로 가져옴
  }
}
