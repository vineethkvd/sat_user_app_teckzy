import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController{
  var notificationModel = NotificationModel().obs;
  Future<void> fetchNotification() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.notificationuser;
    const apiToken = ApiEndPoints.apiToken;
    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key":apiToken,
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
        notificationModel(NotificationModel.fromJson(responseData));
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}