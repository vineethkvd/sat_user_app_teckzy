class LoginModel {
  bool? status;
  String? message;
  Data? data;
  int? otp;

  LoginModel({this.status, this.message, this.data, this.otp});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    otp = json['Otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['Otp'] = this.otp;
    return data;
  }
}

class Data {
  String? customerId;
  String? customerUniqId;
  String? customerName;
  Null? customerProfile;
  String? customerEmail;
  String? customerPhone;
  Null? metroStation;
  String? campusId;
  String? companyId;
  String? idProof;
  String? selectedRoute;
  Null? customerOtp;
  Null? customerToken;
  Null? refId;
  String? joinDate;
  String? joinTime;
  String? customerStatus;
  String? customerWallet;
  String? cusIsDeleded;

  Data(
      {this.customerId,
        this.customerUniqId,
        this.customerName,
        this.customerProfile,
        this.customerEmail,
        this.customerPhone,
        this.metroStation,
        this.campusId,
        this.companyId,
        this.idProof,
        this.selectedRoute,
        this.customerOtp,
        this.customerToken,
        this.refId,
        this.joinDate,
        this.joinTime,
        this.customerStatus,
        this.customerWallet,
        this.cusIsDeleded});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerUniqId = json['customer_uniq_id'];
    customerName = json['customer_name'];
    customerProfile = json['customer_profile'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    metroStation = json['metro_station'];
    campusId = json['campus_id'];
    companyId = json['company_id'];
    idProof = json['id_proof'];
    selectedRoute = json['selected_route'];
    customerOtp = json['customer_otp'];
    customerToken = json['customer_token'];
    refId = json['ref_id'];
    joinDate = json['join_date'];
    joinTime = json['join_time'];
    customerStatus = json['customer_status'];
    customerWallet = json['customer_wallet'];
    cusIsDeleded = json['cus_isDeleded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_uniq_id'] = this.customerUniqId;
    data['customer_name'] = this.customerName;
    data['customer_profile'] = this.customerProfile;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    data['metro_station'] = this.metroStation;
    data['campus_id'] = this.campusId;
    data['company_id'] = this.companyId;
    data['id_proof'] = this.idProof;
    data['selected_route'] = this.selectedRoute;
    data['customer_otp'] = this.customerOtp;
    data['customer_token'] = this.customerToken;
    data['ref_id'] = this.refId;
    data['join_date'] = this.joinDate;
    data['join_time'] = this.joinTime;
    data['customer_status'] = this.customerStatus;
    data['customer_wallet'] = this.customerWallet;
    data['cus_isDeleded'] = this.cusIsDeleded;
    return data;
  }
}
