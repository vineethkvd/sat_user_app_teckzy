class FetchCampusModel {
  bool? status;
  String? message;
  List<Data>? data;

  FetchCampusModel({this.status, this.message, this.data});

  FetchCampusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? campId;
  String? campusName;
  String? campusStatus;
  String? creatDt;

  Data({this.campId, this.campusName, this.campusStatus, this.creatDt});

  Data.fromJson(Map<String, dynamic> json) {
    campId = json['camp_id'];
    campusName = json['campus_name'];
    campusStatus = json['campus_status'];
    creatDt = json['creat_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['camp_id'] = this.campId;
    data['campus_name'] = this.campusName;
    data['campus_status'] = this.campusStatus;
    data['creat_dt'] = this.creatDt;
    return data;
  }
}
