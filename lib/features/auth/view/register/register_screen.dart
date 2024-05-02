import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../core/configs/styles/app_colors.dart';
import '../../../../core/utils/shared/components/widgets/custom_textfield.dart';
import '../../../buy_tickets/model/ticket_model.dart';
import '../../controller/fetch_campus_controller.dart';
import '../../controller/fetch_company_controller.dart';
import '../../controller/registration_controller.dart';
import '../../controller/route_controller.dart';
import '../../model/route_model.dart';
import '../../repository/validator.dart';
import '../login/login_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final RegistrationController _registrationController =
      Get.put(RegistrationController());
  final RouteController routeController = Get.put(RouteController());
  final FetchCampusController fetchcampuscontroller =
      Get.put(FetchCampusController());
  final FetchCompanyController fetchCompanyController =
      Get.put(FetchCompanyController());

  final ImagePicker picker = ImagePicker();
  var selectedValue;
  List<DropdownItemsModel>? data;
  var campusList = [];
  var companyList = [];
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
    // TODO: implement initState
    super.initState();
    initializeData();
  }

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
            child: Obx(() => Form(
                  key: _registrationController.formKey.value,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Container(
                            color: const Color(0xffbec3c7),
                            height: 1000.h, // Use setHeight to adapt height
                            width: 319.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Text(
                                    "Registration Page",
                                    style: TextStyle(
                                      fontFamily: "Inter-Bold",
                                      fontSize: 24.sp,
                                      color: AppColor.blackTextColor,
                                    ),
                                  ),
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
                                            "User name",
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
                                            keyboardType: TextInputType.name,
                                            validateInput: (value) =>
                                                Validator.validateName(
                                              name: value,
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.account_circle,
                                              color: Colors.black54,
                                            ),
                                            controller: _registrationController
                                                .name.value,
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
                                              color: AppColor.blackTextColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: CustomTextField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validateInput: (value) =>
                                                Validator.validateEmail(
                                              email: value,
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.black54,
                                            ),
                                            controller: _registrationController
                                                .email.value,
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
                                            controller: _registrationController
                                                .phone.value,
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
                                              color: AppColor.blackTextColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: data != null
                                              ? Container(
                                                  height: 50.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0), // You can adjust the radius as needed
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey), // You can add border for visual distinction
                                                  ),
                                                  child:
                                                      DropdownButtonFormField<
                                                          DropdownItemsModel>(
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        'Select Route',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder
                                                          .none, // This removes the underline
                                                    ),
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    dropdownColor: Colors.white,
                                                    items: data!
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                DropdownItemsModel>(
                                                              value: item,
                                                              child: Text(
                                                                  item.metroCampus ??
                                                                      ''),
                                                            ))
                                                        .toList(),
                                                    onChanged: (selectedItem) {
                                                      selectedValue =
                                                          '${selectedItem?.routeId}';
                                                      fetchcampuscontroller
                                                          .selectedCampus
                                                          .value = '';
                                                      fetchcampuscontroller
                                                          .campusdataList.value
                                                          .clear();
                                                      fetchcampuscontroller
                                                          .fetchCampusData(
                                                              route_id:
                                                                  '${selectedItem?.routeId}');
                                                    },
                                                  ),
                                                )
                                              : const Center(
                                                  child:
                                                      CupertinoActivityIndicator()),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            "Select Campus",
                                            style: TextStyle(
                                              fontFamily: "Inter-Regular",
                                              fontSize: 15.sp,
                                              color: AppColor.blackTextColor,
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(
                                                    8.0), // You can adjust the radius as needed
                                                border: Border.all(
                                                    color: Colors
                                                        .grey), // You can add border for visual distinction
                                              ),
                                              child: DropdownButton<String>(
                                                dropdownColor: Colors.white,
                                                underline: Container(),
                                                hint: fetchcampuscontroller
                                                        .selectedCampus
                                                        .value
                                                        .isEmpty
                                                    ? const Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                                'Select Campus',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        children: [
                                                          Text(
                                                            fetchcampuscontroller
                                                                .selectedCampus
                                                                .value!,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: fetchcampuscontroller
                                                    .campusdataList.value
                                                    .map(
                                                  (val) {
                                                    fetchcampuscontroller
                                                            .selectedCampus
                                                            .value =
                                                        val.campusName!;
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: val.campId,
                                                      child: Text(
                                                          "${val.campusName}"),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (val) {
                                                  setState(() {
                                                    fetchcampuscontroller
                                                        .campus_id.value = val!;
                                                    print(
                                                        "${fetchcampuscontroller.campus_id.value}");
                                                    fetchCompanyController
                                                        .companyList.value
                                                        .clear();
                                                    fetchCompanyController
                                                        .selectedCompany
                                                        .value = '';
                                                    fetchCompanyController
                                                        .fetchCompany(
                                                            campus_id:
                                                                fetchcampuscontroller
                                                                    .campus_id
                                                                    .value);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            "Select Company",
                                            style: TextStyle(
                                              fontFamily: "Inter-Regular",
                                              fontSize: 15.sp,
                                              color: AppColor.blackTextColor,
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: DropdownButton<String>(
                                                dropdownColor: Colors.white,
                                                underline: Container(),
                                                hint: fetchCompanyController
                                                        .selectedCompany
                                                        .value
                                                        .isEmpty
                                                    ? const Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              'Select Company',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        children: [
                                                          Text(
                                                            fetchCompanyController
                                                                .selectedCompany
                                                                .value!,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: fetchCompanyController
                                                    .companyList.value
                                                    .map((val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val.companyId,
                                                    child: Text(
                                                        "${val.companyName}"),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  fetchCompanyController
                                                      .company_id.value = val!;
                                                  fetchCompanyController
                                                          .selectedCompany
                                                          .value =
                                                      fetchCompanyController
                                                          .companyList.value
                                                          .firstWhere((company) =>
                                                              company
                                                                  .companyId ==
                                                              val)
                                                          .companyName!;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            "Upload ID Proof",
                                            style: TextStyle(
                                              fontFamily: "Inter-Regular",
                                              fontSize: 15.sp,
                                              color: AppColor.blackTextColor,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print("clicked");
                                            _registrationController
                                                .pickImageFromGallery();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0.w),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Material(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0.r),
                                                elevation: 5.0,
                                                child: Container(
                                                  width: 300.w,
                                                  height: 48.h,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            8.0.w),
                                                        child: Text(
                                                          'Choose Image',
                                                          style: TextStyle(
                                                            color: AppColor
                                                                .blackTextColor,
                                                            fontSize: 16.0.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            8.0.w),
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .camera),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            _registrationController
                                                    .imagePath.value.isNotEmpty
                                                ? "Image selected"
                                                : "No image selected",
                                            style: TextStyle(
                                              color: _registrationController
                                                      .imagePath
                                                      .value
                                                      .isNotEmpty
                                                  ? Colors.indigo
                                                  : Colors.red,
                                              fontSize: 16.0.sp,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Material(
                                              color: AppColor.yellowTextColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0.r),
                                              elevation: 5.0,
                                              child: InkWell(
                                                onTap: () async {
                                                  print(fetchCompanyController
                                                      .company_id.value);
                                                  if (_registrationController
                                                      .formKey
                                                      .value
                                                      .currentState!
                                                      .validate()) {
                                                    if (_registrationController
                                                        .imagePath
                                                        .value
                                                        .isEmpty) {
                                                      Get.defaultDialog(
                                                        title: "Select Image",
                                                        titleStyle: TextStyle(
                                                            fontFamily:
                                                                'Inter-Bold',
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: Text(
                                                          "Please select image.",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Inter-Regular',
                                                            color: Colors.black,
                                                            fontSize: 14.0.sp,
                                                          ),
                                                        ),
                                                        textConfirm: "OK",
                                                        confirmTextColor:
                                                            Colors.white,
                                                        buttonColor: AppColor
                                                            .appMainColor,
                                                        radius: 20.0.r,
                                                        onConfirm: () {
                                                          Get.back();
                                                        },
                                                      );
                                                    } else {
                                                      try {
                                                        if (fetchcampuscontroller
                                                                .campus_id
                                                                .value
                                                                .isNotEmpty &&
                                                            fetchCompanyController
                                                                .company_id
                                                                .value
                                                                .isNotEmpty) {
                                                          print(
                                                              "${fetchCompanyController.selectedCompany.value}");
                                                          final registrationModel =
                                                              await _registrationController
                                                                  .registerUser(
                                                            name:
                                                                _registrationController
                                                                    .name
                                                                    .value
                                                                    .text,
                                                            email:
                                                                _registrationController
                                                                    .email
                                                                    .value
                                                                    .text,
                                                            phone:
                                                                _registrationController
                                                                    .phone
                                                                    .value
                                                                    .text,
                                                            route:
                                                                selectedValue,
                                                            campus_id:
                                                                fetchcampuscontroller
                                                                    .campus_id
                                                                    .value,
                                                            company_id:
                                                                fetchCompanyController
                                                                    .company_id
                                                                    .value,
                                                          );
                                                          Get.defaultDialog(
                                                            buttonColor: AppColor
                                                                .appMainColor,
                                                            backgroundColor:
                                                                Colors.white,
                                                            titleStyle: TextStyle(
                                                                fontFamily:
                                                                    'Inter-Bold',
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            title: registrationModel
                                                                        .status ==
                                                                    true
                                                                ? "Success"
                                                                : "Failure",
                                                            content: Text(
                                                              registrationModel
                                                                      .message ??
                                                                  'Unknown error',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Inter-Regular',
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    14.0.sp,
                                                              ),
                                                            ),
                                                            textConfirm: "OK",
                                                            confirmTextColor:
                                                                Colors.white,
                                                            onConfirm: () {
                                                              if (registrationModel
                                                                      .status ==
                                                                  true) {
                                                                Get.off(
                                                                    const LoginScreen(),
                                                                    transition:
                                                                        Transition
                                                                            .leftToRightWithFade);
                                                              } else {
                                                                Get.back(); // Go back to the previous screen
                                                              }
                                                            },
                                                          );
                                                        } else {
                                                          Get.defaultDialog(
                                                            buttonColor: AppColor
                                                                .appMainColor,
                                                            backgroundColor:
                                                                Colors.white,
                                                            titleStyle: TextStyle(
                                                                fontFamily:
                                                                    'Inter-Bold',
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            title: "failed",
                                                            content: Text(
                                                              'Please select all the mandatory fields',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Inter-Regular',
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    14.0.sp,
                                                              ),
                                                            ),
                                                            textConfirm: "OK",
                                                            confirmTextColor:
                                                                Colors.white,
                                                            onConfirm: () {
                                                              Get.back();
                                                            },
                                                          );
                                                        }

                                                        // Display dialog based on registration result
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: 173.w,
                                                  height: 48.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.r),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0.w),
                                                    child: Text(
                                                      'Register',
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
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
