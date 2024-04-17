class ProfileModel {
  bool? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? customerId;
  String? customerUniqId;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? idProof;
  String? selectedRoute;
  String? routeId;
  String? metroCampus;

  Data(
      {this.customerId,
        this.customerUniqId,
        this.customerName,
        this.customerEmail,
        this.customerPhone,
        this.idProof,
        this.selectedRoute,
        this.routeId,
        this.metroCampus});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerUniqId = json['customer_uniq_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    idProof = json['id_proof'];
    selectedRoute = json['selected_route'];
    routeId = json['route_id'];
    metroCampus = json['metro-campus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_uniq_id'] = this.customerUniqId;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    data['id_proof'] = this.idProof;
    data['selected_route'] = this.selectedRoute;
    data['route_id'] = this.routeId;
    data['metro-campus'] = this.metroCampus;
    return data;
  }
}