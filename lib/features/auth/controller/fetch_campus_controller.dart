import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/fetch_campus_controller.dart';

class FetchCampusController extends GetxController {
  var fetchCampusModel = FetchCampusModel().obs;
  var selectedCampus = ''.obs;
  var campusdataList = <Data>[].obs;
  var campus_id = ''.obs;
  Future<void> fetchCampusData({required String route_id}) async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.campus;
    const apiToken = ApiEndPoints.apiToken;
    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key":apiToken,
      "route_id":route_id
    };
    final jsonBody = json.encode(requestData);

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        fetchCampusModel(FetchCampusModel.fromJson(responseData));

        if (fetchCampusModel.value.status == true) {
          print("success");
          campusdataList.clear();
          campusdataList.assignAll(fetchCampusModel.value.data!);
          print("${campusdataList.value}");
        } else {
          throw Exception('Status is not Success');
        }
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        fetchCampusModel(FetchCampusModel.fromJson(responseData));

        if (fetchCampusModel.value.status == false) {
          print("fail to load route");
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: $e');
    } on SocketException catch (e) {
      throw Exception('Socket Exception: $e');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
