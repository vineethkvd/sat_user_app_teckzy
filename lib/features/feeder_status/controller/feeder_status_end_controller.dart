import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/feeder_status_destination_model.dart';


class FeederStatusEndController extends GetxController {
  String msg = '';

  var feederStatusEndList = <FeederStatusDestinationModel>[].obs;
  Future<void> fetchFeederStatusEndPoint({required String endPoint}) async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.feederStatusEnd;
    const apiToken = ApiEndPoints.apiToken;
    var routeId = await CacheHelper.getData('routeId');

    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key":apiToken,
      "route_id":routeId,
      "end_point":endPoint
    };
    final jsonBody = json.encode(requestData);

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final feederStatusDestinationModel = FeederStatusDestinationModel.fromJson(responseData);

        if (feederStatusDestinationModel.status != null && feederStatusDestinationModel.status == true) {
          msg = feederStatusDestinationModel.msg ?? '';

          // Convert each Data object into a FeederStatusModel object
          if (feederStatusDestinationModel.data != null) {

            feederStatusEndList.assignAll(feederStatusDestinationModel.data!.map((data) {
              return FeederStatusDestinationModel(
                status: feederStatusDestinationModel.status,
                msg: feederStatusDestinationModel.msg,
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
