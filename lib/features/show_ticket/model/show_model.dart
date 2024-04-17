class ShowTicketModel {
  bool? status;
  String? msg;
  List<TicketData>? ticketData;

  ShowTicketModel({this.status, this.msg, this.ticketData});

  ShowTicketModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['ticket_data'] != null) {
      ticketData = <TicketData>[];
      json['ticket_data'].forEach((v) {
        ticketData!.add(new TicketData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.ticketData != null) {
      data['ticket_data'] = this.ticketData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketData {
  String? bookId;
  String? ticketTransactionId;
  String? cusId;
  String? pickup;
  String? destination;
  String? noOfTicket;
  String? ticketType;
  String? ticketAmount;
  String? paymentType;
  String? ticketQrCode;
  String? ticketValid;
  String? ticketCreatDate;
  String? ticketCreatTime;
  String? ticketStatus;
  String? scanCount;

  TicketData(
      {this.bookId,
        this.ticketTransactionId,
        this.cusId,
        this.pickup,
        this.destination,
        this.noOfTicket,
        this.ticketType,
        this.ticketAmount,
        this.paymentType,
        this.ticketQrCode,
        this.ticketValid,
        this.ticketCreatDate,
        this.ticketCreatTime,
        this.ticketStatus,
        this.scanCount});

  TicketData.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    ticketTransactionId = json['ticket_transaction_id'];
    cusId = json['cus_id'];
    pickup = json['pickup'];
    destination = json['destination'];
    noOfTicket = json['no_of_ticket'];
    ticketType = json['ticket_type'];
    ticketAmount = json['ticket_amount'];
    paymentType = json['payment_type'];
    ticketQrCode = json['ticket_qr_code'];
    ticketValid = json['ticket_valid'];
    ticketCreatDate = json['ticket_creat_date'];
    ticketCreatTime = json['ticket_creat_time'];
    ticketStatus = json['ticket_status'];
    scanCount = json['scan_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['ticket_transaction_id'] = this.ticketTransactionId;
    data['cus_id'] = this.cusId;
    data['pickup'] = this.pickup;
    data['destination'] = this.destination;
    data['no_of_ticket'] = this.noOfTicket;
    data['ticket_type'] = this.ticketType;
    data['ticket_amount'] = this.ticketAmount;
    data['payment_type'] = this.paymentType;
    data['ticket_qr_code'] = this.ticketQrCode;
    data['ticket_valid'] = this.ticketValid;
    data['ticket_creat_date'] = this.ticketCreatDate;
    data['ticket_creat_time'] = this.ticketCreatTime;
    data['ticket_status'] = this.ticketStatus;
    data['scan_count'] = this.scanCount;
    return data;
  }
}
