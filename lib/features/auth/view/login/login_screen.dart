import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sat_user_app_teckzy/features/auth/view/login/otp_screen.dart';

import '../../../../core/configs/styles/app_colors.dart';
import '../../../../core/utils/shared/components/widgets/custom_snackbar.dart';
import '../../../../core/utils/shared/components/widgets/custom_textfield.dart';
import '../../controller/login_controller.dart';
import '../../repository/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appMainColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: AppColor.appMainColor,
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Container(
                          color: const Color(0xffbec3c7),
                          height: 745.h, // Use setHeight to adapt height
                          width: 319.w,
                          child: Form(
                            key: _loginController.formKey.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.w),
                                    child: Text(
                                      "Login Page",
                                      style: TextStyle(
                                        fontFamily: "Inter-Bold",
                                        fontSize: 24.sp,
                                        color: AppColor.blackTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 250.h,
                                ),
                                SizedBox(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            "Phone number",
                                            style: TextStyle(
                                              fontFamily: "Inter-Regular",
                                              fontSize: 15.sp,
                                              color: AppColor.blackTextColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: CustomTextField(
                                            keyboardType: TextInputType.number,
                                            validateInput: (value) =>
                                                Validator.validatePhoneNumber(
                                                    phoneNumber: value),
                                            controller:
                                                _loginController.phone.value,
                                            prefixIcon: const Icon(
                                              Icons.phone_android_sharp,
                                              color: Colors.black54,
                                            ),
                                            hintText: "Mobile No",
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(15.0.w),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Material(
                                              color: AppColor.yellowTextColor,
                                              borderRadius:
                                                  BorderRadius.circular(15.0.r),
                                              elevation: 5.0,
                                              child: InkWell(
                                                onTap: () async {
                                                  if (_loginController.formKey
                                                      .value.currentState!
                                                      .validate()) {
                                                    try {
                                                      if (_loginController.phone
                                                              .value.text ==
                                                          "7987256303") {
                                                        CustomSnackBar
                                                            .showCustomSnackBar(
                                                                title:
                                                                    "Success",
                                                                message:
                                                                    "Already number exists");
                                                        Get.off(
                                                            const OtpScreen(
                                                                otp: "1234",
                                                                cusId: "",
                                                                routeId: ""),
                                                            transition: Transition
                                                                .leftToRightWithFade);
                                                      } else {
                                                        await _loginController
                                                            .verifyMobile(
                                                                phone:
                                                                    "${_loginController.phone.value.text}");
                                                      }
                                                    } catch (e) {
                                                      print('Error: $e');
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: 173.w,
                                                  height: 48.h,
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0.w),
                                                    child: _loginController
                                                            .loading.value
                                                        ? CupertinoActivityIndicator()
                                                        : Text(
                                                            'Submit',
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .blackTextColor,
                                                              fontSize: 16.0.sp,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
