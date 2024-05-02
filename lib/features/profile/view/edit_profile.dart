import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/configs/styles/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/shared/components/widgets/custom_textfield.dart';
import '../../auth/controller/registration_controller.dart';
import '../../auth/controller/route_controller.dart';
import '../../auth/model/route_model.dart';
import '../../auth/repository/validator.dart';
import '../../home/view/home_screen.dart';
import '../controller/edit_profile_controller.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  EditProfileScreen(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  // Fix typo here

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final RouteController routeController = Get.put(RouteController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  var selectedValue;
  List<DropdownItemsModel>? data;
  Future<void> initializeData() async {
    try {
      data = await routeController.getRoutes();
    } catch (e) {
      print('Error initializing data: $e');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    editProfileController.name.value = TextEditingController(text: widget.name);
    editProfileController.phone.value =
        TextEditingController(text: widget.phone);
    editProfileController.email.value =
        TextEditingController(text: widget.email);
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appMainColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColor.appMainColor,
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: editProfileController.formKey.value,
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
                                Get.back();
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
                                'Edit Profile',
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
                    SizedBox(
                      height: 50.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: Get.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                "User name",
                                style: TextStyle(
                                  fontFamily: "Inter-Regular",
                                  fontSize: 15.sp,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: CustomTextField(
                                keyboardType: TextInputType.name,
                                validateInput: (value) =>
                                    Validator.validateName(
                                  name: value,
                                ),
                                prefixIcon: const Icon(
                                  Icons.account_circle,
                                  color: Colors.black54,
                                ),
                                controller: editProfileController.name.value,
                                hintText: "Name",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                "Email ID",
                                style: TextStyle(
                                  fontFamily: "Inter-Regular",
                                  fontSize: 15.sp,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: CustomTextField(
                                keyboardType: TextInputType.emailAddress,
                                validateInput: (value) =>
                                    Validator.validateEmail(
                                  email: value,
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black54,
                                ),
                                controller: editProfileController.email.value,
                                hintText: "Email",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                "Mobile No",
                                style: TextStyle(
                                  fontFamily: "Inter-Regular",
                                  fontSize: 15.sp,
                                  color: AppColor.whiteColor,
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
                                controller: editProfileController.phone.value,
                                prefixIcon: const Icon(
                                  Icons.phone_android_sharp,
                                  color: Colors.black54,
                                ),
                                hintText: "Mobile No",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                "Select Route",
                                style: TextStyle(
                                  fontFamily: "Inter-Regular",
                                  fontSize: 15.sp,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: data != null
                                  ? SizedBox(
                                      height: 58,
                                      child: DropdownButtonFormField<
                                          DropdownItemsModel>(
                                        dropdownColor: Colors.black54,
                                        items: data!
                                            .map((item) => DropdownMenuItem<
                                                    DropdownItemsModel>(
                                                  value: item,
                                                  child: Expanded(
                                                    child: Text(
                                                        overflow: TextOverflow.fade,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        item.metroCampus ?? ''),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (selectedItem) {
                                          selectedValue =
                                              '${selectedItem?.routeId}';
                                        },
                                        style: TextStyle(
                                          color: Colors
                                              .white, // Text color of the selected item
                                        ),
                                        decoration: const InputDecoration(
                                          labelText: 'Select Route',
                                          labelStyle: TextStyle(
                                              color: AppColor.whiteColor),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: CupertinoActivityIndicator(
                                      color: Colors.white,
                                    )),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Align(
                                alignment: Alignment.center,
                                child: Material(
                                  color: AppColor.yellowTextColor,
                                  borderRadius: BorderRadius.circular(10.0.r),
                                  elevation: 5.0,
                                  child: InkWell(
                                    onTap: () async {
                                      if (editProfileController.formKey.value.currentState!.validate()) {
                                        await editProfileController.editProfile(
                                          name: editProfileController.name.value.text,
                                          email: editProfileController.email.value.text,
                                          phone: editProfileController.phone.value.text,
                                          selectedRoute: selectedValue.toString(),
                                        );
                                        if (editProfileController.editProfileModel.value.status=="Success") {
                                          CacheHelper.clearData("routeId");
                                          CacheHelper.saveData(
                                              "routeId", selectedValue);
                                          Get.defaultDialog(
                                            title: "Success",
                                            titleStyle: TextStyle(
                                              fontFamily: 'Inter-Bold',
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            backgroundColor: Colors.white,
                                            content: Text(
                                              '${editProfileController.editProfileModel.value.message}',
                                              style: TextStyle(
                                                fontFamily: 'Inter-Regular',
                                                color: Colors.black,
                                                fontSize: 14.0.sp,
                                              ),
                                            ),
                                            textConfirm: "OK",
                                            confirmTextColor: Colors.white,
                                            buttonColor: AppColor.appMainColor,
                                            radius: 20.0.r,
                                            onConfirm: () {
                                              Get.back();
                                              // Navigate to the home screen
                                              Get.offAll(() => const HomeScreen(),
                                                transition: Transition.leftToRightWithFade,
                                              );
                                            },
                                          );
                                        } else {
                                          Get.defaultDialog(
                                            title: "Failed",
                                            titleStyle: TextStyle(
                                              fontFamily: 'Inter-Bold',
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            backgroundColor: Colors.white,
                                            content: Text(
                                              '${editProfileController.editProfileModel.value.message}',
                                              style: TextStyle(
                                                fontFamily: 'Inter-Regular',
                                                color: Colors.black,
                                                fontSize: 14.0.sp,
                                              ),
                                            ),
                                            textConfirm: "OK",
                                            confirmTextColor: Colors.white,
                                            buttonColor: AppColor.appMainColor,
                                            radius: 20.0.r,
                                            onConfirm: () {
                                              Get.back();
                                            },
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 173.w,
                                      height: 48.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10.0.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            color: AppColor.blackTextColor,
                                            fontSize: 16.0.sp,
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
