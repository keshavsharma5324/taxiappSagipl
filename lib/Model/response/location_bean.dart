class LocationBean {
  String? address;
  String? latitude;
  String? longitude;
  int? id;
  String? addressLabel;
  String? distance;

  LocationBean({this.address, this.latitude, this.longitude,/* this.id, */this.distance});

  LocationBean.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'] != null
        ? json['latitude']
        : json['lat'] != null
            ? json['lat']
            : null;
    longitude = json['longitude'] != null
        ? json['longitude']
        : json['lng'] != null
            ? json['lng']
            : null;

    id = json['id'];
    distance = json['distance'].toString();
    addressLabel = json['address_label'].toString();
  }
}
