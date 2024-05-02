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
import '../model/feedr_status_pickup_model.dart'; // Import your model class

class FeederStatusPickUpController extends GetxController {
  var feederStatusPickUpModel = FeederStatusPickUpModel().obs;
  var feederStatusPickList = <Data>[].obs;

  Future<void> fetchFeederStatusPickup({required String pickUpPoint}) async {
    final baseController = BaseController();
    // baseController.showLoading('Fetching slider data...');
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.feederStatusPickup;
    const apiToken = ApiEndPoints.apiToken;
    var routeId = await CacheHelper.getData('routeId');
    print("base :$apiUrl");
    print("$pickUpPoint");

    final requestData = {
      "api_key": apiToken,
      "route_id": routeId,
      "pickup_point": pickUpPoint
    };
    print("pickUpPoint$pickUpPoint");
    try {
      final baseClient = BaseClient();
      var response = await baseClient.post(apiUrl, requestData);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        feederStatusPickUpModel(FeederStatusPickUpModel.fromJson(responseData));

        if (feederStatusPickUpModel.value.status == true) {
          print("success");
          feederStatusPickList.value.clear();
          feederStatusPickList
              .assignAll(feederStatusPickUpModel.value.data ?? []);
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
