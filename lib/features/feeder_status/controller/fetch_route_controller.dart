import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/fetch_route_model.dart';

class FetchRouteController extends GetxController{
  var fetchRouteModel = FetchRouteModel().obs;
  var pickupLocation = ''.obs;
  var endLocation = ''.obs;
  Future<void> fetchRoute() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.findRoute;
    const apiToken = ApiEndPoints.apiToken;
    var routeId = await CacheHelper.getData('routeId');
    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key": apiToken,
      "route_id": routeId
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
        fetchRouteModel.value = FetchRouteModel.fromJson(responseData);

        // Extracting data from the response and updating observables
        if (fetchRouteModel.value.status == true && fetchRouteModel.value.data != null) {
          pickupLocation.value = fetchRouteModel.value.data![0].choosenMetro ?? '';
          endLocation.value = fetchRouteModel.value.data![0].choosenCampus ?? '';
        } else {
          throw Exception('Invalid data format or missing data');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}