import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../shared/components/widgets/custom_buttons.dart';



class DialogHelper {
  //show error dialog
  static void showErroDialog({String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  // You can add more style properties as needed
                ),
              ),
              Text(
                description ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  // You can add more style properties as needed
                ),
              ),
              CustomElevatedBtn(
                onPressed: () async {
                  if (Get.isDialogOpen!) Get.back();
                },
                backgroundColor: Color(0xFF134005),
                width: 50.w,
                height: 30.h,
                child:
               const Text(
                  "Okay",
                  style: TextStyle(color: Colors.white),
                )

              )
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}