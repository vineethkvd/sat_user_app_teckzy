import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/edit_profile_model.dart';

class EditProfileController extends GetxController {
  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;

  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> email = TextEditingController().obs;
  final Rx<TextEditingController> phone = TextEditingController().obs;

  var editProfileModel = EditProfileModel().obs;
  Future<void> editProfile(
      {required String name,
      required String email,
      required String phone,
      required String selectedRoute}) async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.editProfile;
    const apiToken = ApiEndPoints.apiToken;
    final headers = {'Content-Type': 'application/json'};
    var cusId = await CacheHelper.getData('cusid');
    final requestData = {
      "api_key":apiToken,
      "customer_id" : cusId,
      "customer_name" :name,
      "customer_phone" : phone,
      "customer_email" : email,
      "selected_route":selectedRoute
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
        editProfileModel(EditProfileModel.fromJson(responseData));
        if(editProfileModel.value.status=="Success"){
          print("Updated : ${editProfileModel.value.message}");
        }else{
          print("failed to update ${editProfileModel.value.message}");
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
