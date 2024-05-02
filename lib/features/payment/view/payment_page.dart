import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../controller/payment_controller.dart';

enum PaymentMethod {
  PayOnline,
  Wallet,
}

class PaymentOptionsScreen extends StatefulWidget {
  final String pickup;
  final String destination;
  final String count;
  final String tiket_type;
  final String tiket_amount;
  final String valid_till;
  final String scan_count;

  PaymentOptionsScreen({
    Key? key,
    required this.pickup,
    required this.destination,
    required this.count,
    required this.tiket_type,
    required this.tiket_amount,
    required this.valid_till,
    required this.scan_count,
  }) : super(key: key);

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appMainColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          'Payment Page',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 274.w,
                  height: 50.h,
                  child: Container(
                    width: 274.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColor.appMainColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Amount Rs.${widget.tiket_amount}',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200.h,
              ),
              SizedBox(
                width: 274.w,
                height: 50.h,
                child: Container(
                  width: 274.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColor.appMainColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: InkWell(
                    onTap: () async {
                      await paymentController.buyTickets(
                          pickup: widget.pickup,
                          destination: widget.destination,
                          count: widget.count,
                          tiket_type: widget.tiket_type,
                          tiket_amount: widget.tiket_amount,
                          valid_till: widget.valid_till,
                          scan_count: widget.scan_count,
                          payment_type: "Wallet");
                    },
                    child: Row(
                      children: [
                        // Logo in the top left corner
                        Container(
                          width: 50.w,
                          height: 50.h,
                          color: AppColor.appMainColor,
                          child: Image.asset(
                            AssetsPathes.walletlogoimage,
                            width: 50.w,
                            height: 50.h,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child:Text(
                                    'Pay with Wallet',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                               ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () async {
                  print("Clicked");
                  await paymentController.buyTickets(
                      pickup: widget.pickup,
                      destination: widget.destination,
                      count: widget.count,
                      tiket_type: widget.tiket_type,
                      tiket_amount: widget.tiket_amount,
                      valid_till: widget.valid_till,
                      scan_count: widget.scan_count,
                      payment_type: "Pay Online");
                },
                child: Container(
                  width: 274.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColor.appMainColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: Row(
                    children: [
                      // Logo in the top left corner
                      Container(
                        width: 50.w,
                        height: 50.h,
                        color: AppColor.appMainColor,
                        child: Image.asset(
                          AssetsPathes.debitlogoimage,
                          width: 50.w,
                          height: 50.h,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: paymentController.loading.value?Text(
                            'Pay with your bank',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ):CupertinoActivityIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
