import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../../../core/utils/helpers/network/helpers/app_exceptions.dart';
import '../../../core/utils/helpers/network/helpers/base_client.dart';
import '../../../core/utils/helpers/network/helpers/base_controller.dart';
import '../../../core/utils/helpers/network/helpers/dialog_helper.dart';
import '../model/feeder_status_destination_model.dart';



class FeederStatusEndController extends GetxController {
  var feederStatusDestinationModel = FeederStatusDestinationModel().obs;
  var feederStatusDestinationList = <Data>[].obs;

  Future<void> fetchFeederStatusEndPoint({required String endPoint}) async {
    final baseController = BaseController();
    // baseController.showLoading('Fetching slider data...');
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.feederStatusEnd;


    const apiToken = ApiEndPoints.apiToken;
    var routeId = await CacheHelper.getData('routeId');
    final requestData = {
      "api_key": apiToken,
      "route_id": routeId,
      "end_point": endPoint
    };
    try {
      final baseClient = BaseClient();
      var response = await baseClient.post(apiUrl, requestData);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        feederStatusDestinationModel(FeederStatusDestinationModel.fromJson(responseData));

        if (feederStatusDestinationModel.value.status == true) {
          print("success");
          feederStatusDestinationList.value.clear();
          feederStatusDestinationList
              .assignAll(feederStatusDestinationModel.value.data ?? []);
        } else {
          throw Exception('Status is not true');
        }
      } else {
        throw Exception('Failed to fetch slider data');
      }
    } catch (error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErroDialog(description: apiError["reason"]);
      } else {
        baseController.handleError(error);
      }
    } finally {
      // baseController.hideLoading();
      // loading.value = true;
    }
  }
}
