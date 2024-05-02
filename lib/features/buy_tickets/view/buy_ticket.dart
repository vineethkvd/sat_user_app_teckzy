import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../../home/view/home_screen.dart';
import '../../payment/view/payment_page.dart';
import '../../wallet/controller/wallet_controller.dart';
import '../controller/ticket_controller.dart';

class BuyTicketScreen extends StatefulWidget {
  const BuyTicketScreen({super.key});

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  final TicketController _ticketController = Get.put(TicketController());
  final WalletController walletController = Get.put(WalletController());
  void initState() {
    super.initState();
    _ticketController.fetchTicket();

    // Delay the execution of the other methods
    Future.delayed(const Duration(seconds: 1), () {
      _ticketController.calculateCurrentDateValidity();
      _ticketController.calculateNextWeekValidity();
      _ticketController.calculateNextMonthValidity();
    });
    walletController.fetchWalletData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ticketController.count.value = 1;
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
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  _ticketController.count.value = 1;
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
                                  'Buy Tickets',
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
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom:5.w,top: 5.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0.r),
                          child: Container(
                            height: 230.h,
                            padding: EdgeInsets.only(left: 5.w,right: 5.w,bottom:5.w,top: 5.w),
                            color: AppColor.brownColor,
                            child: Column(
                              children: [

                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 60.w,
                                        child: Image.asset(
                                          AssetsPathes.appLogoImage,
                                          width: 50.w,
                                          height: 30.h,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "Daily Ticket",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Inter-Bold'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 55.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 130.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _ticketController.choosenMetro.value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:
                                            Image.asset(AssetsPathes.arrowLogo),
                                      ),
                                      SizedBox(
                                        width: 130.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _ticketController.choosenCampus.value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Pass Count",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter-Regular'),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0.r),
                                        child: Container(
                                          color: AppColor.blackTextColor,
                                          width: 120.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _ticketController.decPrice();
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Text("-",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0.w),
                                                child: Text(
                                                  "${_ticketController.count.value}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14..sp,
                                                      fontFamily: 'Inter-Bold'),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _ticketController.incPrice();
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Text(
                                                    "+",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100.w,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "Rs ${_ticketController.dailyFare.value}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14..sp,
                                                  fontFamily: 'Inter-Bold')),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.sp,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Row(children: [
                                            Text(
                                              "Wallet Balance : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                            (walletController
                                                            .walletAmount.value !=
                                                        null &&
                                                    walletController.walletAmount
                                                        .value.isNotEmpty)
                                                ? Text(
                                                    "Rs. ${walletController.walletAmount}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter-Bold'),
                                                  )
                                                : Text(
                                                    "Rs. 0",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter-Bold'),
                                                  )
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110.w,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w, right: 8.w),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            AppColor
                                                                .yellowTextColor)),
                                                onPressed: () {
                                                  if (_ticketController.dailyFare
                                                      .value.isNotEmpty) {
                                                    Get.to(
                                                        PaymentOptionsScreen(
                                                            pickup:
                                                                "${_ticketController.choosenMetro.value}",
                                                            destination:
                                                                "${_ticketController.choosenCampus.value}",
                                                            count:
                                                                "${_ticketController.count.value}",
                                                            tiket_type: "Daily",
                                                            tiket_amount:
                                                                "${_ticketController.dailyFare.value}",
                                                            valid_till:
                                                                "${_ticketController.dailyValidity.value}",
                                                            scan_count: "1"),
                                                        transition: Transition
                                                            .leftToRightWithFade);
                                                  }
                                                },
                                                child: Text("Buy",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            'Inter-Bold'))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 320.w,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            "Valid till: ${_ticketController.dailyValidity.value}, 11:59 PM",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom:5.w,top: 5.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0.r),
                          child: Container(
                            height: 230.h,
                            padding: EdgeInsets.only(left: 5.w,right: 5.w,bottom:5.w,top: 5.w),
                            color: AppColor.brownColor,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 60.w,
                                        child: Image.asset(
                                          AssetsPathes.appLogoImage,
                                          width: 50.w,
                                          height: 30.h,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "Weekly Ticket",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Inter-Bold'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 55.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 130.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _ticketController.choosenMetro.value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:
                                        Image.asset(AssetsPathes.arrowLogo),
                                      ),
                                      SizedBox(
                                        width: 130.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _ticketController.choosenCampus.value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Pass Count",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter-Regular'),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0.r),
                                        child: Container(
                                          color: AppColor.blackTextColor,
                                          width: 120.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0.w),
                                                child: Text(
                                                  "10",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14..sp,
                                                      fontFamily: 'Inter-Bold'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100.w,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "Rs ${_ticketController.weeklyFare.value}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14..sp,
                                                  fontFamily: 'Inter-Bold')),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.sp,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Row(children: [
                                            Text(
                                              "Wallet Balance : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                            (walletController
                                                            .walletAmount.value !=
                                                        null &&
                                                    walletController.walletAmount
                                                        .value.isNotEmpty)
                                                ? Text(
                                                    "Rs. ${walletController.walletAmount}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter-Bold'),
                                                  )
                                                : Text(
                                                    "Rs. 0",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter-Bold'),
                                                  )
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110.w,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w, right: 8.w),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            AppColor
                                                                .yellowTextColor)),
                                                onPressed: () {
                                                  Get.to(
                                                      PaymentOptionsScreen(
                                                          pickup:
                                                              "${_ticketController.choosenMetro.value}",
                                                          destination:
                                                              "${_ticketController.choosenCampus.value}",
                                                          count:
                                                              "${_ticketController.count.value}",
                                                          tiket_type: "Weekly",
                                                          tiket_amount:
                                                              "${_ticketController.weeklyFare.value}",
                                                          valid_till:
                                                              "${_ticketController.weeklyValidity.value}",
                                                          scan_count: "14"),
                                                      transition: Transition
                                                          .leftToRightWithFade);
                                                },
                                                child: Text("Buy",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            'Inter-Bold'))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 320.w,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            "Valid till: ${_ticketController.weeklyValidity.value}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom:5.w,top: 5.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0.r),
                          child: Container(
                            height: 230.h,
                            padding: EdgeInsets.only(left: 5.w,right: 5.w,bottom:5.w,top: 5.w),
                            color: AppColor.brownColor,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 60.w,
                                        child: Image.asset(
                                          AssetsPathes.appLogoImage,
                                          width: 50.w,
                                          height: 30.h,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "Monthly Ticket",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Inter-Bold'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 55.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 130.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _ticketController.choosenMetro.value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:
                                        Image.asset(AssetsPathes.arrowLogo),
                                      ),
                                      SizedBox(
                                        width: 130.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              _ticketController.choosenCampus.value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Pass Count",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter-Regular'),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0.r),
                                        child: Container(
                                          color: AppColor.blackTextColor,
                                          width: 120.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0.w),
                                                child: Text(
                                                  "44",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontFamily: 'Inter-Bold'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100.w,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "Rs ${_ticketController.monthlyFare.value}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14..sp,
                                                  fontFamily: 'Inter-Bold')),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.sp,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Row(children: [
                                            Text(
                                              "Wallet Balance : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Inter-Bold'),
                                            ),
                                            (walletController
                                                            .walletAmount.value !=
                                                        null &&
                                                    walletController.walletAmount
                                                        .value.isNotEmpty)
                                                ? Text(
                                                    "Rs. ${walletController.walletAmount}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter-Bold'),
                                                  )
                                                : Text(
                                                    "Rs. 0",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Inter-Bold'),
                                                  )
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110.w,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w, right: 8.w),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            AppColor
                                                                .yellowTextColor)),
                                                onPressed: () {
                                                  Get.to(
                                                      PaymentOptionsScreen(
                                                          pickup:
                                                              "${_ticketController.choosenMetro.value}",
                                                          destination:
                                                              "${_ticketController.choosenCampus.value}",
                                                          count:
                                                              "${_ticketController.count.value}",
                                                          tiket_type: "Monthly",
                                                          tiket_amount:
                                                              "${_ticketController.monthlyFare.value}",
                                                          valid_till:
                                                              "${_ticketController.monthlyValidity.value}",
                                                          scan_count: "60"),
                                                      transition: Transition
                                                          .leftToRightWithFade);
                                                },
                                                child: Text("Buy",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            'Inter-Bold'))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 38.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 320.w,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            "Valid till: ${_ticketController.monthlyValidity.value}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
