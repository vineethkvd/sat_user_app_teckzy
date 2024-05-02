import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import Get for state management

import '../../../core/configs/styles/app_colors.dart';
import '../controller/feeder_status_end_controller.dart';
import '../controller/feeder_status_pickup_controller.dart';
import '../controller/fetch_route_controller.dart';

class FeederStatusScreen extends StatefulWidget {
  @override
  State<FeederStatusScreen> createState() => _FeederStatusScreenState();
}

class _FeederStatusScreenState extends State<FeederStatusScreen> {
  final FetchRouteController fetchRouteController =
      Get.put(FetchRouteController());
  final FeederStatusPickUpController feederStatusPickupController =
      Get.put(FeederStatusPickUpController());
  final FeederStatusEndController feederStatusEndController =
      Get.put(FeederStatusEndController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRouteController.fetchRoute();
    Future.delayed(const Duration(seconds: 2), () {
      feederStatusPickupController.fetchFeederStatusPickup(
          pickUpPoint: '${fetchRouteController.pickupLocation.value}');
      feederStatusEndController.fetchFeederStatusEndPoint(
          endPoint: '${fetchRouteController.endLocation.value}');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appMainColor,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColor.appMainColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.0.w, top: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: AppColor.whiteColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 60.0.w),
                            child: Column(
                              children: [
                                Text(
                                  'Vehicle Availability status',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'inter-Regular',
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    width: 400.w,
                    height: 250.h,
                    child: ListView(
                      children: [
                        Obx(
                          () => Center(
                            child: Text(
                              '${fetchRouteController.pickupLocation.value}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 50.0.sp, right: 50.0.sp, top: 15.0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Vehicle',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.yellowColor,
                                ),
                              ),
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.yellowColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          if (feederStatusPickupController
                              .feederStatusPickList.value.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No vehicle avalilable",
                                  style: TextStyle(color: AppColor.whiteColor),
                                ),
                              ),
                            );
                          } else {
                            // Display fetched data
                            return Column(
                              children: feederStatusPickupController
                                  .feederStatusPickList.value
                                  .map((feederStatus) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 50.0.sp,
                                      right: 50.0.sp,
                                      top: 15.0.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        feederStatus.vehicleRegno ??
                                            'N/A', // Access vehicleNo from Data object
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                      Text(
                                        feederStatus
                                            .vehicleStatus ??
                                            'N/A', // Access vehicleStatus from Data object
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                  Container(
                    width: 400.w,
                    height: 250.h,
                    child: ListView(
                      children: [
                        Obx(
                          () => Center(
                            child: Text(
                              '${fetchRouteController.endLocation.value}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 50.0.sp, right: 50.0.sp, top: 15.0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Vehicle',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.yellowColor,
                                ),
                              ),
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.yellowColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          if (feederStatusEndController
                              .feederStatusDestinationList.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No vehicles available",
                                  style: TextStyle(color: AppColor.whiteColor),
                                ),
                              ),
                            );
                          } else {
                            // Display fetched data
                            return Column(
                              children: feederStatusEndController
                                  .feederStatusDestinationList.value
                                  .map((feederStatus) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 50.0.sp,
                                      right: 50.0.sp,
                                      top: 15.0.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        feederStatus.vehicleRegno ??
                                            'N/A',
                                        // Access vehicleNo from the first Data object in the list
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                      Text(
                                        feederStatus.vehicleStatus  ??
                                            'N/A',
                                        // Access vehicleStatus from the first Data object in the list
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
