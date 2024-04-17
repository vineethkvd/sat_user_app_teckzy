import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/wallet_model.dart';

class WalletController extends GetxController {
  var walletAmount = ''.obs;

  Future<void> fetchWalletData() async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.wallet;
    const apiToken = ApiEndPoints.apiToken;

    final headers = {'Content-Type': 'application/json'};
    final cusId = await CacheHelper.getData('cusid');
    final requestData = {"api_key": apiToken, "cus_id": cusId};
    final jsonBody = json.encode(requestData);

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final walletModel = WalletModel.fromJson(responseData);

        if (walletModel.status != null && walletModel.status!) {
          if (walletModel.data != null && walletModel.data!.isNotEmpty) {
            // Assuming only one data entry is returned
            walletAmount.value = walletModel.data![0].wallet ?? '';
          } else {
            walletAmount.value = '';
          }
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
