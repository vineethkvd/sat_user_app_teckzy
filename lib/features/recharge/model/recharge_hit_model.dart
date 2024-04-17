class RechargeHitApiMidel {
  bool? status;
  String? msg;
  String? qrCodeUrl;

  RechargeHitApiMidel({this.status, this.msg, this.qrCodeUrl});

  RechargeHitApiMidel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    qrCodeUrl = json['qr_code_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['qr_code_url'] = this.qrCodeUrl;
    return data;
  }
}