class FetchRouteModel {
  bool? status;
  String? message;
  List<Data>? data;

  FetchRouteModel({this.status, this.message, this.data});

  FetchRouteModel.fromJson(Map<String, dynamic> json) {
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
  String? routeId;
  String? choosenMetro;
  String? choosenCampus;

  Data({this.routeId, this.choosenMetro, this.choosenCampus});

  Data.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    choosenMetro = json['choosen_metro'];
    choosenCampus = json['choosen_campus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_id'] = this.routeId;
    data['choosen_metro'] = this.choosenMetro;
    data['choosen_campus'] = this.choosenCampus;
    return data;
  }
}