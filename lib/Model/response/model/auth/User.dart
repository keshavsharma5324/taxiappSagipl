
class UserData {
  UserData({
    this.fname, this.lname,
    this.phone_number, this.email,
    this.status, this.ext, this.locale,
    this.picUrl, this.address});

  final String? phone_number;
  final String? fname;
  final String? lname;
  final String? status;
  final String? email;
  final String? ext;
  final String? locale;
  final String? picUrl;
  final String? address;

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
    phone_number: json["phone_number"] == null ? null : json["phone_number"],
    ext: json["ext"] == null ? null : json["ext"],
    fname: json["name"] == null ? null : json["name"],
    lname: json["l_name"] == null ? null : json["l_name"],
    email: json["email"] == null ? null : json["email"],
    status: json["status"] == null ? null : json["status"],
    locale: json["locale"] == null ? null : json["locale"],
    picUrl: json["pic_url"] == null ? null : json["pic_url"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toMap() => {
    "phone_number": phone_number == null ? null : phone_number,
    "ext": ext == null ? null : ext,
    "name": fname == null ? null : fname,
    "l_name": lname == null ? lname : ext,
    "email": email == null ? null : email,
  "status": status == null ? null : status,
  "locale": locale == null ? null : locale,
    "pic_url": picUrl == null ? null : picUrl,
    "address": address == null ? null : address
  };
}