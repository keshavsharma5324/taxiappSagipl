class MasterResponse {
  String? message;
  List<MasterBean>? data;
  late bool isSuccess;

  MasterResponse({this.message, this.data,required this.isSuccess});

  MasterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <MasterBean>[];
      json['data'].forEach((v) {
        data!.add(new MasterBean.fromJson(v));
      });
    }
    isSuccess = json['is_success'];
  }
}

class MasterBean {
  String? id;
  String? name;
  String? image;
  String? model;
  String? noOfPassenger;
  late bool isSelected = false;

  MasterBean({this.id, this.name, this.image, this.model, this.noOfPassenger});

  MasterBean.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    image = json['image'].toString();
    model = json['model'].toString();
    noOfPassenger = json['no_of_passenger'].toString();
  }
}