class UserBean {
  String? name;
  String? status;
  String? email;
  String? code;
  String? phoneNumber;
  String? ext;
  String? address;
  String? picUrl;

  UserBean({this.name, this.status, this.email, this.code, this.phoneNumber, this.ext, this.address, this.picUrl});

  UserBean.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    code = json['code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    ext = json['ext'];
    address = json['address'];
    picUrl = json['pic_url'];
    if(json['picUrl'] !=null) picUrl = json['picUrl'];
  }
}