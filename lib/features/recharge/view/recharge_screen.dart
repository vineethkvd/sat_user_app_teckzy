import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../home/view/home_screen.dart';
import '../../../core/configs/styles/app_colors.dart';
import '../../payment/controller/payment_controller.dart';
import '../controller/recharge_controller.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final RechargeController rechargeController = Get.put(RechargeController());
  int? selectedAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appMainColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: AppColor.whiteColor,
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
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
                  SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Recharge amount',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Inter-Regular",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildAmountButton(40),
                            buildAmountButton(80),
                            buildAmountButton(160),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildAmountButton(320),
                            buildAmountButton(400),
                            buildAmountButton(640),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildAmountButton(800),
                            buildAmountButton(1000),
                            buildAmountButton(1760),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Center(
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedAmount != null) {
                              await rechargeController.rechargeWallet(
                                  amount: "${selectedAmount.toString()}");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Please select a recharge amount.'),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFC78F00)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Center(
                            child: Text(
                              'Proceed to Pay',
                              style: TextStyle(
                                fontFamily: "Inter-Regular",
                                fontSize: 15,
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
          ),
        ),
      ),
    );
  }

  Widget buildAmountButton(int amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAmount = amount;
        });
      },
      child: Container(
        height: 50,
        width: 96,
        decoration: BoxDecoration(
          color: selectedAmount == amount
              ? Colors.green // Customize the color for selected amount
              : AppColor.appMainColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            amount.toString(),
            style: TextStyle(
              color:
                  selectedAmount == amount ? Colors.white : AppColor.whiteColor,
              fontSize: 24,
              fontFamily: "Inter-Regular",
            ),
          ),
        ),
      ),
    );
  }
}
