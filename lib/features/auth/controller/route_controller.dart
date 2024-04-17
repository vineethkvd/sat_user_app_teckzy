import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/route_model.dart';
import 'package:http/http.dart' as http;

class RouteController extends GetxController{
  Future<List<DropdownItemsModel>> getRoutes() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.route;
    const apiToken = ApiEndPoints.apiToken;
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({"api_key": apiToken}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map<DropdownItemsModel>((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsModel.fromJson(map);
        }).toList();
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    } catch (e) {
      print(e);
      throw Exception("Fetch Data Error: $e");
    }
  }
}