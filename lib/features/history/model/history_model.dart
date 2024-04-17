class HistoryModel {
  String? status;
  String? message;
  List<TotalTrips>? totalTrips;

  HistoryModel({this.status, this.message, this.totalTrips});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Total_Trips'] != null) {
      totalTrips = <TotalTrips>[];
      json['Total_Trips'].forEach((v) {
        totalTrips!.add(new TotalTrips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.totalTrips != null) {
      data['Total_Trips'] = this.totalTrips!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalTrips {
  String? tripId;
  String? cusId;
  String? pickup;
  String? destination;
  String? date;
  String? startTime;
  String? endTime;
  String? totalTravelTime;

  TotalTrips(
      {this.tripId,
        this.cusId,
        this.pickup,
        this.destination,
        this.date,
        this.startTime,
        this.endTime,
        this.totalTravelTime});

  TotalTrips.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    cusId = json['cus_id'];
    pickup = json['pickup'];
    destination = json['destination'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalTravelTime = json['total_travel_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id'] = this.tripId;
    data['cus_id'] = this.cusId;
    data['pickup'] = this.pickup;
    data['destination'] = this.destination;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_travel_time'] = this.totalTravelTime;
    return data;
  }
}
