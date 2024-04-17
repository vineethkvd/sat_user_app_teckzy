class TicketModel {
  bool? status;
  String? message;
  List<Data>? data;

  TicketModel({this.status, this.message, this.data});

  TicketModel.fromJson(Map<String, dynamic> json) {
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
  String? perTicket;
  String? dailyFare;
  String? weeklyFare;
  String? monthlyFare;
  String? dailyValidity;
  String? weeklyValidity;
  String? monthlyValidity;

  Data(
      {this.routeId,
        this.choosenMetro,
        this.choosenCampus,
        this.perTicket,
        this.dailyFare,
        this.weeklyFare,
        this.monthlyFare,
        this.dailyValidity,
        this.weeklyValidity,
        this.monthlyValidity});

  Data.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    choosenMetro = json['choosen_metro'];
    choosenCampus = json['choosen_campus'];
    perTicket = json['per_ticket'];
    dailyFare = json['daily_fare'];
    weeklyFare = json['weekly_fare'];
    monthlyFare = json['monthly_fare'];
    dailyValidity = json['daily_validity'];
    weeklyValidity = json['weekly_validity'];
    monthlyValidity = json['monthly_validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_id'] = this.routeId;
    data['choosen_metro'] = this.choosenMetro;
    data['choosen_campus'] = this.choosenCampus;
    data['per_ticket'] = this.perTicket;
    data['daily_fare'] = this.dailyFare;
    data['weekly_fare'] = this.weeklyFare;
    data['monthly_fare'] = this.monthlyFare;
    data['daily_validity'] = this.dailyValidity;
    data['weekly_validity'] = this.weeklyValidity;
    data['monthly_validity'] = this.monthlyValidity;
    return data;
  }
}
