import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../../auth/view/login/login_screen.dart';

class LogOutController extends GetxController {
  Future<void> logout() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.logout;
    const apiToken = ApiEndPoints.apiToken;

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Logout successful');
        Get.defaultDialog(
          title: 'Logout',
          textConfirm: 'Logout',
          middleText: 'Are you sure you want to logout?',
          textCancel: 'Cancel',
          titleStyle: TextStyle(
            fontSize: 18.sp, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Adjust the font weight as needed
          ),
          buttonColor: AppColor.appMainColor, // Set the button color
          radius: 10.0, // Set the border radius
          onConfirm: () {
            CacheHelper.clearData("cusid");
            Get.back();
            Get.offAll(
              const LoginScreen(),
              transition: Transition.leftToRightWithFade,
            ); // Navigate to login screen
          },
          onCancel: () {
            Get.back(); // Close current screen
          },
        );
      } else {
        // Handle unsuccessful logout
        throw Exception('Failed to logout: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error during logout: $e');
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to logout. Please try again later.',
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
      throw Exception('Error during logout: $e');
    }
  }
}
