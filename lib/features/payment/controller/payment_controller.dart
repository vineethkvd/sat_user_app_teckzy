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
import '../../razor_pay/view/razor_pay_screen.dart';
import '../../show_ticket/view/show_ticket.dart';
import '../model/payment_hit_model.dart';
import '../model/payment_model.dart';

class PaymentController extends GetxController {
  var paymentModel = PaymentModel().obs;
  var paymentHitApiMidel = PaymentHitApiMidel().obs;
  var successLink = ''.obs;
  var failedLink = ''.obs;

  Future<void> buyTickets({
    required String pickup,
    required String destination,
    required String count,
    required String tiket_type,
    required String tiket_amount,
    required String valid_till,
    required String scan_count,
    required String payment_type,
  }) async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.BuyTicket;
    const apiToken = ApiEndPoints.apiToken;
    var cusId = await CacheHelper.getData('cusid');
    var routeId = await CacheHelper.getData('routeId');
    print(routeId);
    final headers = {'Content-Type': 'application/json'};

    final requestData = {
      "api_key": apiToken,
      "cus_id": cusId,
      "pickup": pickup,
      "route_id": routeId,
      "destination": destination,
      "count": count,
      "tiket_type": tiket_type,
      "tiket_amount": tiket_amount,
      "valid_till": valid_till,
      "scan_count": scan_count,
      "payment_type": payment_type
    };
    final jsonBody = json.encode(requestData);

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        paymentModel(PaymentModel.fromJson(responseData));

        if (paymentModel.value.status == "Success") {
          if(payment_type=="Pay Online"){
            print("pay online");
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
                successLink.value = paymentModel.value.successLink!;
                print("link ${successLink.value} ");
                Get.to(PaymentPage(
                  orderId: '${paymentModel.value.paymentDetail!.first.orderId}',
                  amount: '${paymentModel.value.paymentDetail!.first.amount}',
                  razorKey: '${paymentModel.value.paymentDetail!.first.key}',
                  url: '${paymentModel.value.successLink!}',
                  t_id: '${paymentModel.value.tId!}',
                ));
              },
            );
          }else if(payment_type=="Wallet"){
            Get.defaultDialog(
              title: 'Payment Success',
              textConfirm: 'Ok',
              middleText: 'Successfully pay using Wallet',
              titleStyle: TextStyle(
                fontSize: 18.sp, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Adjust the font weight as needed
              ),
              buttonColor: AppColor.appMainColor, // Set the button color
              radius: 10.0, // Set the border radius
              onConfirm: () {
                Get.back();
                hitPayment(
                    url: "${paymentModel.value.successLink!}",
                    t_id: "${paymentModel.value.tId!}",
                    singnature: '',
                    order_id: '',
                    payment_id: '');
                if (paymentHitApiMidel.value.status == "Success") {
                  Get.back();
                  Get.off(const ShowTicketScreen(),
                      transition: Transition.leftToRightWithFade);
                }
              },
            );
          }
          print("success ");
        } else {
          throw Exception('Status is not true');
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        paymentModel(PaymentModel.fromJson(responseData));
        if (paymentModel.value.status == "Failed") {
          print("failed");
          Get.defaultDialog(
            title: 'Failed to process',
            textConfirm: 'Ok',
            middleText: '${paymentModel.value.message}',
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            buttonColor: AppColor.appMainColor,
            radius: 10.0,
            onConfirm: () {
              Get.back();
              failedLink.value = paymentModel.value.failedLink!;
              hitPayment(
                  url: failedLink.value,
                  t_id: "${paymentModel.value.tId}",
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
