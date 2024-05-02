import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/configs/styles/app_colors.dart';
import '../../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../../core/utils/shared/components/widgets/custom_snackbar.dart';
import '../../../home/view/home_screen.dart';
import '../../controller/login_controller.dart';

class OtpScreen extends StatefulWidget {
  final String otp;
  final String cusId;
  final String routeId;
  const OtpScreen(
      {Key? key, required this.otp, required this.cusId, required this.routeId})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    print("otp:${widget.otp}");
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.w),
                                    child: Text(
                                      "OTP Verification",
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
                                          padding: EdgeInsets.only(
                                              left: 20.w, bottom: 10.w),
                                          child: Text(
                                            "Enter OTP",
                                            style: TextStyle(
                                              fontFamily: "Inter-Regular",
                                              fontSize: 15.sp,
                                              color: AppColor.blackTextColor,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: OTPTextField(
                                            otpFieldStyle: OtpFieldStyle(
                                                backgroundColor: Colors.white),
                                            controller: _loginController
                                                .otpFieldController.value,
                                            length: 4,
                                            width: 300.w,
                                            fieldWidth: 50,
                                            style: TextStyle(fontSize: 17.w),
                                            textFieldAlignment:
                                                MainAxisAlignment.spaceAround,
                                            fieldStyle: FieldStyle.box,
                                            spaceBetween: 5,
                                            onCompleted: (pin) {
                                              print("Completed: " + pin);
                                              _loginController
                                                  .enteredOtp.value = pin;
                                            },
                                          ),
                                        ),
                                        // Align(
                                        //   alignment: Alignment.topRight,
                                        //   child: TextButton(
                                        //     onPressed: () {},
                                        //     child: Text(
                                        //       "Resend OTP?",
                                        //       style: TextStyle(
                                        //         fontFamily: "Inter-Regular",
                                        //         fontSize: 15.sp,
                                        //         color: AppColor.blueTextColor,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        InkWell(
                                          onTap: () async {
                                            if (widget.otp ==
                                                "1234") {
                                              if (_loginController
                                                  .enteredOtp.value
                                                  .trim() ==
                                                  widget.otp.trim()){
                                                CustomSnackBar
                                                    .showCustomSnackBar(
                                                    title:
                                                    "Success",
                                                    message:
                                                    "Welcome back");
                                                Get.off(
                                                   const HomeScreen(),
                                                    transition: Transition
                                                        .leftToRightWithFade);
                                              }

                                            }else{
                                              if (_loginController
                                                  .enteredOtp.value
                                                  .trim() ==
                                                  widget.otp.trim()) {
                                                CacheHelper.saveData(
                                                    "cusid", widget.cusId);
                                                CacheHelper.saveData(
                                                    "routeId", widget.routeId);
                                                Get.defaultDialog(
                                                  title: "Success",
                                                  titleStyle: TextStyle(
                                                      fontFamily: 'Inter-Bold',
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  backgroundColor: Colors.white,
                                                  content: Text(
                                                    'Welcome back',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter-Regular',
                                                      color: Colors.black,
                                                      fontSize: 14.0.sp,
                                                    ),
                                                  ),
                                                  textConfirm: "OK",
                                                  confirmTextColor: Colors.white,
                                                  buttonColor:
                                                  AppColor.appMainColor,
                                                  radius: 20.0.r,
                                                  onConfirm: () {
                                                    Get.back();
                                                    // Navigate to the registration page
                                                    Get.offAll(
                                                            () => const HomeScreen(),
                                                        transition: Transition
                                                            .leftToRightWithFade);
                                                  },
                                                );
                                              } else {
                                                Get.defaultDialog(
                                                  title: "Failure",
                                                  titleStyle: TextStyle(
                                                      fontFamily: 'Inter-Bold',
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  backgroundColor: Colors.white,
                                                  content: Text(
                                                    'Please enter valid OTP',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter-Regular',
                                                      color: Colors.black,
                                                      fontSize: 14.0.sp,
                                                    ),
                                                  ),
                                                  textConfirm: "OK",
                                                  confirmTextColor: Colors.white,
                                                  buttonColor:
                                                  AppColor.appMainColor,
                                                  radius: 20.0.r,
                                                  onConfirm: () {
                                                    Get.back();
                                                  },
                                                );
                                              }
                                            }

                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(15.0.w),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Material(
                                                color: AppColor.yellowTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0.r),
                                                elevation: 5.0,
                                                child: Container(
                                                  width: 173.w,
                                                  height: 48.h,
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0.w),
                                                    child: Text(
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
                        )
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
