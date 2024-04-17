class FetchCompanyModel {
  bool? status;
  String? message;
  List<Data>? data;

  FetchCompanyModel({this.status, this.message, this.data});

  FetchCompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? companyId;
  String? campusId;
  String? companyName;
  String? companyStatus;
  String? creatDt;

  Data(
      {this.companyId,
        this.campusId,
        this.companyName,
        this.companyStatus,
        this.creatDt});

  Data.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    campusId = json['campus_id'];
    companyName = json['company_name'];
    companyStatus = json['company_status'];
    creatDt = json['creat_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['campus_id'] = this.campusId;
    data['company_name'] = this.companyName;
    data['company_status'] = this.companyStatus;
    data['creat_dt'] = this.creatDt;
    return data;
  }
}
