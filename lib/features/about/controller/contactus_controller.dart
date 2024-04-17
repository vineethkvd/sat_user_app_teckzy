import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/contactus_model.dart';
import '../model/policy_model.dart';

class ContactUsController extends GetxController {
  var contactMessage = ''.obs;
  var contactData = ''.obs;
  Future<void> fetchContact() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.customer;
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
        final contactUsModel = ContactUsModel.fromJson(responseData);
        if (contactUsModel.status == true) {
          contactMessage.value = contactUsModel.message!;
          contactData.value = contactUsModel.data!.join(', ');
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
