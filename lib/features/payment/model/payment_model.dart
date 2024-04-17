class PaymentModel {
  String? status;
  String? message;
  String? tId;
  String? successLink;
  String? failedLink;
  List<PaymentDetail>? paymentDetail;

  PaymentModel(
      {this.status,
        this.message,
        this.tId,
        this.successLink,
        this.failedLink,
        this.paymentDetail});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tId = json['t_id'];
    successLink = json['success_link'];
    failedLink = json['failed_link'];
    if (json['payment_detail'] != null) {
      paymentDetail = <PaymentDetail>[];
      json['payment_detail'].forEach((v) {
        paymentDetail!.add(new PaymentDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['t_id'] = this.tId;
    data['success_link'] = this.successLink;
    data['failed_link'] = this.failedLink;
    if (this.paymentDetail != null) {
      data['payment_detail'] =
          this.paymentDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetail {
  String? key;
  int? amount;
  String? name;
  String? description;
  String? image;
  String? email;
  String? contact;
  String? color;
  String? orderId;

  PaymentDetail(
      {this.key,
        this.amount,
        this.name,
        this.description,
        this.image,
        this.email,
        this.contact,
        this.color,
        this.orderId});

  PaymentDetail.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    amount = json['amount'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    email = json['email'];
    contact = json['contact'];
    color = json['color'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['amount'] = this.amount;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['color'] = this.color;
    data['order_id'] = this.orderId;
    return data;
  }
}
