import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/feedr_status_pickup_model.dart'; // Import your model class

class FeederStatusPickUpController extends GetxController {
  String msg = ''; // Directly use String for msg

  var feederStatusPickUpList = <FeederStatusPickUpModel>[].obs;

  Future<void> fetchFeederStatusPickup({required String pickUpPoint}) async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.feederStatusPickup;
    const apiToken = ApiEndPoints.apiToken;
    var routeId = await CacheHelper.getData('routeId');
    print("$routeId");

    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key":apiToken,
      "route_id":routeId,
      "pickup_point":pickUpPoint
    };
    final jsonBody = json.encode(requestData);

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final feederStatusPickUpModel = FeederStatusPickUpModel.fromJson(responseData);

        if (feederStatusPickUpModel.status != null && feederStatusPickUpModel.status == true) {
          msg = feederStatusPickUpModel.msg ?? '';

          // Convert each Data object into a FeederStatusModel object
          if (feederStatusPickUpModel.data != null) {
            feederStatusPickUpList.assignAll(feederStatusPickUpModel.data!.map((data) {
              return FeederStatusPickUpModel(
                status: feederStatusPickUpModel.status,
                msg: feederStatusPickUpModel.msg,
                data: [data], // Wrap the Data object in a list
              );
            }));
          } else {
            throw Exception('Data is null in the response');
          }
        } else {
          throw Exception('Status is not true');
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
