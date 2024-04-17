class PolicyModel {
  bool? status;
  String? message;
  List<String>? data;

  PolicyModel({this.status, this.message, this.data});

  PolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['Data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['Data'] = this.data;
    return data;
  }
}