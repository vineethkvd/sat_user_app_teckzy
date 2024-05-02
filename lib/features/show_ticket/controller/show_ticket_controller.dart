import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../../feeder_status/model/feedr_status_pickup_model.dart';
import 'package:http/http.dart' as http;

import '../model/show_model.dart';

class ShowTicketController extends GetxController {
  var showTicketModel = ShowTicketModel().obs;
  Future<void> fetchShowTicket() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.showTicket;
    const apiToken = ApiEndPoints.apiToken;
    final cusId = GetStorage().read("cusid");

    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key":apiToken,
      "cus_id":cusId
    };
    final jsonBody = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        showTicketModel(ShowTicketModel.fromJson(responseData));
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
