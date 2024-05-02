import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';

import '../../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/login_model.dart';
import '../view/login/otp_screen.dart';
import '../view/register/register_screen.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel().obs;
  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;
  RxBool loading = false.obs;

  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<TextEditingController> phone = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxString enteredOtp = ''.obs;
  RxString otpFromApi = ''.obs;
  RxString cusId = ''.obs;
  RxString routeId = ''.obs;
  final Rx<OtpFieldController> otpFieldController = OtpFieldController().obs;

  Future<void> verifyMobile({required String phone}) async {
    loading.value = true;
    String phoneNumber = phone.toString();
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.login;
    const apiToken = ApiEndPoints.apiToken;
    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key": apiToken,
      "phone": phoneNumber.toString(),
    };
    final jsonBody = json.encode(requestData);

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        loginModel(LoginModel.fromJson(responseData));

        if (loginModel.value.status == true) {
          print("success ");
          cusId.value = loginModel.value.data!.customerId!;

          otpFromApi.value = loginModel.value.otp!.toString();
          routeId.value = loginModel.value.data!.selectedRoute!;
          Get.defaultDialog(
            title: 'Already exists',
            textConfirm: 'Ok',
            middleText: 'Your number already exists',
            titleStyle: TextStyle(
              fontSize: 18.sp, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
            buttonColor: AppColor.appMainColor, // Set the button color
            radius: 10.0, // Set the border radius
            onConfirm: () {
              Get.back();
              // Navigate to the registration page
              Get.to(
                  () => OtpScreen(
                        otp: otpFromApi.value,
                        cusId: cusId.value,
                        routeId: routeId.value,
                      ),
                  transition: Transition.leftToRightWithFade);
            },
          );
        } else {
          throw Exception('Status is not true');
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        loginModel(LoginModel.fromJson(responseData));
        if (loginModel.value.status == false) {
          print("failed");
          Get.defaultDialog(
            title: 'Failed',
            textConfirm: 'Ok',
            middleText: '${loginModel.value.message}',
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            buttonColor: AppColor.appMainColor,
            radius: 10.0,
            onConfirm: () {
              Get.back();
              Get.to(
                () => const RegistrationPage(),
                transition: Transition.leftToRightWithFade,
              );
            },
          );
          print("failed to fetch category Item");
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
    } finally {
      loading.value = false;
    }
  }
}
