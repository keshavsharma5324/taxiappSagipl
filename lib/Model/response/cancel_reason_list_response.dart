class CancelReasonListResponse {
  String? message;
  List<CancelReasonBean>? data;
  bool? isSuccess;

  CancelReasonListResponse({this.message, this.data, this.isSuccess});

  CancelReasonListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data =  <CancelReasonBean>[];
      json['data'].forEach((v) {
        data!.add(new CancelReasonBean.fromJson(v));
      });
    }
    isSuccess = json['is_success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['is_success'] = this.isSuccess;
    return data;
  }
}

class CancelReasonBean {
  int? id;
  String? title;
  bool? isSelected = false;

  CancelReasonBean(
      {this.id,
        this.title
      });

  CancelReasonBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

