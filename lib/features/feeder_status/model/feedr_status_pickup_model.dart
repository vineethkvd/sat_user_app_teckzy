class FeederStatusPickUpModel {
  bool? status;
  String? msg;
  List<Data>? data;

  FeederStatusPickUpModel({this.status, this.msg, this.data});

  FeederStatusPickUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
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
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? pickupPoint;
  String? vehicleStatus;
  String? vehicleNo;
  String? vehicleRegno;

  Data(
      {this.pickupPoint,
        this.vehicleStatus,
        this.vehicleNo,
        this.vehicleRegno});

  Data.fromJson(Map<String, dynamic> json) {
    pickupPoint = json['pickup_point'];
    vehicleStatus = json['vehicle_status'];
    vehicleNo = json['vehicle_no'];
    vehicleRegno = json['vehicle_regno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_point'] = this.pickupPoint;
    data['vehicle_status'] = this.vehicleStatus;
    data['vehicle_no'] = this.vehicleNo;
    data['vehicle_regno'] = this.vehicleRegno;
    return data;
  }
}
