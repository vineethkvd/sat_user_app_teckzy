import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/history_model.dart';



class HistoryController extends GetxController {
  var historyModel = HistoryModel().obs;
  var historyList = <TotalTrips>[].obs;
  Stream<RxList<TotalTrips>> fetchNotification() async* {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.userTravelHistory;
    const apiToken = ApiEndPoints.apiToken;
    final headers = {'Content-Type': 'application/json'};
    var cusId = await CacheHelper.getData('cusid');
    final requestData = {
      "api_key": apiToken,
      "cus_id":cusId
    };
    final jsonBody = json.encode(requestData);

    try {
      final response =
      await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        historyModel(HistoryModel.fromJson(responseData));

        if (historyModel.value.status == "Success") {
          print("success to fetchItem");

          historyList.assignAll(historyModel.value.totalTrips ?? []);
          yield historyList;
        } else {
          throw Exception('Status is not true');
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        historyModel(HistoryModel.fromJson(responseData));
        if (historyModel.value.status == "Failed") {
          print("failed to fetch Item");
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