import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:sat_user_app_teckzy/features/show_ticket/controller/show_ticket_controller.dart';

import '../../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../../../core/utils/shared/components/widgets/custom_snackbar.dart';
import '../../home/view/home_screen.dart';
import '../../razor_pay/view/razor_pay_screen.dart';
import '../../show_ticket/controller/show_ticket_controller.dart';
import '../../show_ticket/view/show_ticket.dart';
import '../model/payment_hit_model.dart';
import '../model/payment_model.dart';

class PaymentController extends GetxController {
  final ShowTicketController showTicketController=ShowTicketController();
  var paymentModel = PaymentModel().obs;
  var paymentHitApiMidel = PaymentHitApiMidel().obs;
  var successLink = ''.obs;
  var failedLink = ''.obs;
  var loading = true.obs;

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
    loading.value = false;
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
        loading.value = true;
        print("Responce data: $responseData");
        if (paymentModel.value.status == "Success") {
          if (payment_type == "Pay Online") {
            print("pay online");
            CustomSnackBar.showCustomSnackBar(
                title: "Processing", message: "Payment Processing");
            successLink.value = paymentModel.value.successLink!;
            print("link ${successLink.value} ");
            Get.to(PaymentPage(
              orderId: '${paymentModel.value.paymentDetail!.first.orderId}',
              amount: '${paymentModel.value.paymentDetail!.first.amount}',
              razorKey: '${paymentModel.value.paymentDetail!.first.key}',
              url: '${paymentModel.value.successLink!}',
              t_id: '${paymentModel.value.tId!}',
            ));
          } else if (payment_type == "Wallet") {
            CustomSnackBar.showCustomSnackBar(
                title: "Payment Success",
                message: "Successfully pay using Wallet");
            hitPayment(
                url: "${paymentModel.value.successLink!}",
                t_id: "${paymentModel.value.tId!}",
                singnature: '',
                order_id: '',
                payment_id: '');
            if (paymentHitApiMidel.value.status == "Success") {
              Get.off(const ShowTicketScreen(),
                  transition: Transition.leftToRightWithFade);
            }
          }
          print("success ");
        } else {
          throw Exception('Status is not true');
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        paymentModel(PaymentModel.fromJson(responseData));
        print("Responce data: $responseData");
        loading.value = true;
        print("wallet fails :${paymentModel.value.status}");

        if (paymentModel.value.status == "Failed") {
          if (payment_type == "Pay Online") {
            failedLink.value = paymentModel.value.failedLink!;
            hitPayment(
                url: failedLink.value,
                t_id: "${paymentModel.value.tId}",
                singnature: '',
                order_id: '',
                payment_id: '');
            CustomSnackBar.showCustomErrorSnackBar(
                title: "Failed", message: "${paymentModel.value.message}");
          } else if (payment_type == "Wallet") {
            CustomSnackBar.showCustomErrorSnackBar(
                title: "Payment Failed",
                message: "${paymentModel.value.message}");
          }

          print("failed");
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
      loading.value = true;
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

        if (paymentHitApiMidel.value.status == "Success") {
          CustomSnackBar.showCustomSnackBar(
              title: "Payment Success",
              message: "${paymentHitApiMidel.value.status}");
          showTicketController.fetchShowTicket();
          Get.offAll(const ShowTicketScreen(),
              transition: Transition.leftToRightWithFade);
        } else {
          throw Exception('Status is not true');
        }
      } else if (response.statusCode == 401) {
        final responseData = json.decode(response.body);
        paymentHitApiMidel(PaymentHitApiMidel.fromJson(responseData));
        if (paymentHitApiMidel.value.status == "Failed") {
          print("failed");

          CustomSnackBar.showCustomErrorSnackBar(
              title: "Payment Failed",
              message: "${paymentHitApiMidel.value.status}");
          Get.off(HomeScreen(),transition: Transition.leftToRightWithFade);
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
