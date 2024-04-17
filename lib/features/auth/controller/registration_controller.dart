import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/helpers/network/helpers/api_endpoints.dart';
import '../../../core/utils/helpers/network/internet_checker.dart';
import '../model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  final NetworkInfo networkInfo = NetworkInfoImpl();

  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;

  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> email = TextEditingController().obs;
  final Rx<TextEditingController> phone = TextEditingController().obs;

  //pick image from gallery
  final picker = ImagePicker();
  RxString imagePath = ''.obs;

  Future<RegistrationModel> registerUser({
    required String name,
    required String email,
    required String phone,
    required String route,
    required String campus_id,
    required String company_id,
  }) async {
    // if (await networkInfo.isConnected) {
    //   // Device is connected to the internet
    //   // Perform actions that require internet connection
    // } else {
    //   // Device is not connected to the internet
    //   Get.defaultDialog(
    //     title: 'No Internet Connection',
    //     middleText: 'Please check your internet connection and try again.',
    //     backgroundColor: Colors.white,
    //     titleStyle: TextStyle(color: Colors.red),
    //     middleTextStyle: TextStyle(color: Colors.black),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Get.back();
    //         },
    //         child: Text('OK'),
    //       ),
    //     ],
    //   );
    // }


    const apiUrl = ApiEndPoints.baseURL + ApiEndPoints.register;
    const apiToken = ApiEndPoints.apiToken;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add headers
      request.headers.addAll({'Content-Type': 'multipart/form-data'});

      // Add fields
      request.fields['api_key'] = apiToken;
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['route'] = route;
      request.fields['campus'] = campus_id;
      request.fields['company'] = company_id;

      // Add image file
      request.files
          .add(await http.MultipartFile.fromPath('proof', imagePath.value));

      // Send request
      var response = await request.send();

      // Check response status
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("success");
        var responseData = await response.stream.bytesToString();
        return RegistrationModel.fromJson(json.decode(responseData));
      } else if (response.statusCode == 400) {
        var responseData = await response.stream.bytesToString();
        return RegistrationModel.fromJson(json.decode(responseData));
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      print("success ");
    } else {
      print("Fail to pick image");
    }
  }
}
