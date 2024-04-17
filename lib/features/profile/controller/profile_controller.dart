import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  var profileModel = ProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.profile;
    const apiToken = ApiEndPoints.apiToken;
    final cusId = GetStorage().read("cusid");

    final headers = {'Content-Type': 'application/json'};
    final requestData = { "api_key":apiToken,
      "customer_id":cusId};
    final jsonBody = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final profile = ProfileModel.fromJson(responseData);
        if (profile.status == true) {
          profileModel(profile);
        } else {
          throw Exception('Profile status is not true');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}