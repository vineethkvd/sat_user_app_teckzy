import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../model/fetch_company_model.dart';

class FetchCompanyController extends GetxController {
  var fetchCompanyModel = FetchCompanyModel().obs;
  var selectedCompany = ''.obs;
  var companyList = <Data>[].obs;
  var company_id = ''.obs;
  Future<void> fetchCompany({required String campus_id}) async {
    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.company;
    const apiToken = ApiEndPoints.apiToken;
    final headers = {'Content-Type': 'application/json'};
    final requestData = {"api_key": apiToken, "campus_id": campus_id};
    final jsonBody = json.encode(requestData);

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        fetchCompanyModel(FetchCompanyModel.fromJson(responseData));

        if (fetchCompanyModel.value.status == true) {
          print("success");
          companyList.clear();
          companyList.assignAll(fetchCompanyModel.value.data!);
          print("${companyList.value}");
        } else {
          throw Exception('Status is not Success');
        }
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        fetchCompanyModel(FetchCompanyModel.fromJson(responseData));

        if (fetchCompanyModel.value.status == false) {
          print("fail to load route");
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
