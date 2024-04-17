import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/policy_model.dart';


class PolicyController extends GetxController {
  var policyMessage = ''.obs;
  var policyData = ''.obs;
  Future<void> fetchPolicy() async {

    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.privacyPolicy;
    const apiToken = ApiEndPoints.apiToken;

    final headers = {'Content-Type': 'application/json'};
    final requestData = {"api_key": apiToken};
    final jsonBody = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final policyModel = PolicyModel.fromJson(responseData);
        if (policyModel.status == true) {
          policyMessage.value = policyModel.message!;
          policyData.value = policyModel.data!.join(', ');
        } else {
          print("Status is not true");
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}