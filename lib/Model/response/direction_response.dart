class DirectionResponse {
  List<Routes>? routes;
  String? status;

  DirectionResponse({this.routes, this.status});

  DirectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(new Routes.fromJson(v));
      });
    }
    status = json['status'];
  }
}

class Routes {
  List<Legs>? legs;
  String? points;

  Routes({this.legs, this.points});

  Routes.fromJson(Map<String, dynamic> json) {
    if (json['legs'] != null) {
      legs =  <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(new Legs.fromJson(v));
      });
    }
    points = json['overview_polyline']['points'];
  }
}

class Legs {
  Distance? distance;
  Distance? duration;
  String? endAddress;
  EndLocation? endLocation;
  String? startAddress;
  EndLocation? startLocation;

  Legs(
      {this.distance,
        this.duration,
        this.endAddress,
        this.endLocation,
        this.startAddress,
        this.startLocation});

  Legs.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    endAddress = json['end_address'];
    endLocation = json['end_location'] != null
        ? new EndLocation.fromJson(json['end_location'])
        : null;
    startAddress = json['start_address'];
    startLocation = json['start_location'] != null
        ? new EndLocation.fromJson(json['start_location'])
        : null;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }
}

class EndLocation {
  double? lat;
  double? lng;

  EndLocation({this.lat, this.lng});

  EndLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

