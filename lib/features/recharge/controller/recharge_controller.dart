import 'dart:convert';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../../payment/model/payment_hit_model.dart';
import '../../razor_pay/view/razor_pay_screen.dart';
import '../model/recharge_hit_model.dart';
import '../model/recharge_model.dart';
import 'package:flutter/material.dart';

class RechargeController extends GetxController {
  var rechargeModel = RechargeModel().obs;
  var rechargeHitApiMidel = RechargeHitApiMidel().obs;
  var paymentHitApiMidel = PaymentHitApiMidel().obs;
  var successLink = ''.obs;
  var failedLink = ''.obs;

  Future<void> rechargeWallet({required String amount}) async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.recharge;
    const apiToken = ApiEndPoints.apiToken;
    var cusId = await CacheHelper.getData('cusid');
    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "api_key": apiToken,
      "cus_id": cusId,
      "amount": amount
    };
    final jsonBody = json.encode(requestData);

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        rechargeModel(RechargeModel.fromJson(responseData));

        if (rechargeModel.value.status == true) {
          print("success ");
          Get.defaultDialog(
            title: 'Processing',
            textConfirm: 'Ok',
            middleText: 'Payment Processing',
            titleStyle: TextStyle(
              fontSize: 18.sp, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
            buttonColor: AppColor.appMainColor, // Set the button color
            radius: 10.0, // Set the border radius
            onConfirm: () {
              Get.back();
              successLink.value = rechargeModel.value.successLink!;
              print("link ${successLink.value} ");
              Get.to(PaymentPage(
                orderId: '${rechargeModel.value.paymentDetail!.first.orderId}',
                amount: '${rechargeModel.value.paymentDetail!.first.amount}',
                razorKey: '${rechargeModel.value.paymentDetail!.first.key}',
                url: '${rechargeModel.value.successLink!}',
                t_id: '${rechargeModel.value.tId!}',
              ));
            },
          );
        } else {
          throw Exception('Status is not true');
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        rechargeModel(RechargeModel.fromJson(responseData));
        if (rechargeModel.value.status == "Failed") {
          print("failed");
          Get.defaultDialog(
            title: 'Failed to process',
            textConfirm: 'Ok',
            middleText: '${rechargeModel.value.msg}',
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            buttonColor: AppColor.appMainColor,
            radius: 10.0,
            onConfirm: () {
              Get.back();
              failedLink.value = rechargeModel.value.failedLink!;
              hitPayment(
                  url: failedLink.value,
                  t_id: "${rechargeModel.value.tId}",
                  singnature: '',
                  order_id: '',
                  payment_id: '');
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
    }
  }

  Future<void> hitPayment(
      {required String url,
        required String t_id,
        required String singnature,
        required String order_id,
        required String payment_id}) async {
    final apiUrl = url;
    final headers = {'Content-Type': 'application/json'};

    final requestData = {
      "t_id": t_id,
      "singnature": singnature,
      "order_id": order_id,
      "payment_id": payment_id
    };
    final jsonBody = json.encode(requestData);
    try {
      final response =
      await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        paymentHitApiMidel(PaymentHitApiMidel.fromJson(responseData));

        // if (paymentHitApiMidel.value.status == "Success") {
        //   print("success ");
        //   Get.defaultDialog(
        //     title: '${paymentHitApiMidel.value.status}',
        //     textConfirm: 'Ok',
        //     middleText: '${paymentHitApiMidel.value.message}',
        //     titleStyle: TextStyle(
        //       fontSize: 18.sp, // Adjust the font size as needed
        //       fontWeight: FontWeight.bold, // Adjust the font weight as needed
        //     ),
        //     buttonColor: AppColor.appMainColor, // Set the button color
        //     radius: 10.0, // Set the border radius
        //     onConfirm: () {
        //       Get.back();
        //       Get.off(HomeScreen(), transition: Transition.leftToRightWithFade);
        //     },
        //   );
        // } else {
        //   throw Exception('Status is not true');
        // }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        paymentHitApiMidel(PaymentHitApiMidel.fromJson(responseData));
        if (paymentHitApiMidel.value.status == "Failed") {
          print("failed");
          Get.defaultDialog(
            title: '${paymentHitApiMidel.value.status}',
            textConfirm: 'Ok',
            middleText: '${paymentHitApiMidel.value.message}',
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            buttonColor: AppColor.appMainColor,
            radius: 10.0,
            onConfirm: () {
              Get.back();
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
    }
  }
}
