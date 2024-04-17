class DropdownItemsModel {
  String? routeId;
  String? metroCampus;

  DropdownItemsModel({this.routeId, this.metroCampus});

  DropdownItemsModel.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    metroCampus = json['metro_campus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_id'] = this.routeId;
    data['metro_campus'] = this.metroCampus;
    return data;
  }
}