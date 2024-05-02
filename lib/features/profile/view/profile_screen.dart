import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/configs/styles/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../../home/view/home_screen.dart';
import '../controller/profile_controller.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key); // Fix typo here

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appMainColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColor.appMainColor,
          body: SingleChildScrollView(
            child: Obx(() => Container(
              padding: EdgeInsets.only(left: 10.w,right:10.w,top: 10.w,bottom: 10.w),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: AppColor.appMainColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width * 0.2.w,
                              child: InkWell(
                                onTap: () {
                                  Get.to(const HomeScreen(),
                                      transition:
                                          Transition.leftToRightWithFade);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12.0.w),
                                  child: Icon(
                                    CupertinoIcons.back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'My Profile',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: "Inter-Bold",
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.2.w,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: Icon(
                              CupertinoIcons.profile_circled,
                              size: 50,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8.w),
                        child: Text(
                          'Cus Id',
                          style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            fontSize: 14.sp,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: Get.width.w,
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: Text(
                          profileController.profileModel.value.status == true
                              ? "${profileController.profileModel.value.data!.customerId ?? '0'}"
                              : "",
                          style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            fontSize: 14.sp,
                            color: AppColor.blackTextColor,
                          ),
                        ),
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 14.sp,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: Get.width.w,
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: Text(
                          profileController.profileModel.value.status == true
                              ? "${profileController.profileModel.value.data!.customerName ?? '0'}"
                              : "",
                          style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            fontSize: 14.sp,
                            color: AppColor.blackTextColor,
                          ),
                        ),
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 14.sp,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.white,
                        width: Get.width.w,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          profileController.profileModel.value.status == true
                              ? "${profileController.profileModel.value.data!.customerEmail ?? '0'}"
                              : "",
                          style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            fontSize: 12.sp,
                            color: AppColor.blackTextColor,
                          ),
                        ),
                      ),
                      Text(
                        'Phone',
                        style: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 14.sp,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: Get.width.w,
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: Text(
                          profileController.profileModel.value.status == true
                              ? profileController.profileModel.value.data!.customerPhone ?? '0'
                              : "",
                          style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            fontSize: 14.sp,
                            color: AppColor.blackTextColor,
                          ),
                        ),
                      ),
                      Text(
                        'Route',
                        style: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 14.sp,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: Get.width.w,
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: Text(
                          profileController.profileModel.value.status == true
                              ? "${profileController.profileModel.value.data!.metroCampus ?? '0'}"
                              : "",
                          style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            fontSize: 14.sp,
                            color: AppColor.blackTextColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: AppColor
                                .yellowTextColor, // Set the background color
                            borderRadius: BorderRadius.circular(
                                8.0), // Set the border radius
                            child: InkWell(
                              onTap: () {
                                if (profileController
                                        .profileModel.value.status ==
                                    true) {
                                  String name = profileController.profileModel
                                          .value.data!.customerName ??
                                      '';
                                  String email = profileController.profileModel
                                          .value.data!.customerEmail ??
                                      '';
                                  String phone = profileController.profileModel
                                          .value.data!.customerPhone ??
                                      '';
                                  Get.to(
                                      EditProfileScreen(
                                        name: name,
                                        email: email,
                                        phone: phone,
                                      ),
                                      transition:
                                          Transition.leftToRightWithFade);
                                }
                              },
                              borderRadius: BorderRadius.circular(
                                  8.0), // Match the border radius
                              child: Container(
                                width: 100.w,
                                height: 50.h,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 24.0), // Set padding
                                child: Center(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontFamily: 'Inter-Bold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
            )),
          ),
        ),
      ),
    );
  }
}
