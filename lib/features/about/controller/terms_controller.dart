import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/terms_model.dart';

class TermsController extends GetxController {
  var termsMessage = ''.obs;
  var termsData = ''.obs;
  Future<void> fetchTerms() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.terms;
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
        final termsModel = TermsModel.fromJson(responseData);
        if (termsModel.status == true) {
          termsMessage.value = termsModel.message!;
          termsData.value = termsModel.data!.join(', ');
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
