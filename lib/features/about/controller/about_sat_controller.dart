import 'package:get/get.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/about_sat_model.dart';
class AbouSatController extends GetxController{
  var abousatMessage = ''.obs;
  var aboutsatData = ''.obs;
  Future<void> fetchAbouSat() async {
    const apiUrl = ApiEndPoints.baseURL+ApiEndPoints.about_us;
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
        final aboutSatModel = AboutSatModel.fromJson(responseData);
        if (aboutSatModel.status == true) {
          abousatMessage.value = aboutSatModel.message!;
          aboutsatData.value = aboutSatModel.data!.join(', ');
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