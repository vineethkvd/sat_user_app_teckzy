import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../../buy_tickets/view/buy_ticket.dart';
import '../../drawer/widget/darawer.dart';
import '../../feeder_status/view/feedr_status.dart';
import '../../history/view/history_screen.dart';
import '../../recharge/view/recharge_screen.dart';
import '../../wallet/controller/wallet_controller.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.put(HomeController());
  final WalletController walletController = Get.put(WalletController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.determinePosition().then((value) {
      homeController.city.value = homeController.currentLocationName!.locality!;
      homeController.locality.value = homeController.currentLocationName!.subLocality!;
      // if ( homeController.city.value != null) {
      //   visibleCity=true;
      // }
    });
    walletController.fetchWalletData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appMainColor,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: const DrawerWidget(),
          bottomNavigationBar: Container(
            height: 81
                .h, // Total height of Container including the height of Text widgets
            width: 360.w,
            decoration: BoxDecoration(
              color: AppColor.appMainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.r),
                topRight: Radius.circular(50.r),
              ),
            ),
            child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Wallet Balance",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontFamily: 'Inter-Regular',
                  ),
                ),
                SizedBox(width: 5.w),
                (walletController.walletAmount.value != null &&
                    walletController.walletAmount.value.isNotEmpty)
                    ? Text(
                  "Rs. ${walletController.walletAmount}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontFamily: 'Inter-Bold',
                  ),
                )
                    : Text(
                  "Rs. 0",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontFamily: 'Inter-Bold',
                  ),
                )
              ],
            ),)
          ),
          extendBodyBehindAppBar: true,
          body: Container(
              color: AppColor.whiteColor,
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColor.appMainColor,
                      height: 50.h,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.15,
                            child: InkWell(
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.0.w),
                                child: Image.asset(AssetsPathes.menuBar),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.8,
                            child: Center(
                              child: Text(
                                "SAT Mobility Solutions",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: "Inter-Bold",
                                  color: AppColor.yellowTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 235.h,
                        width: 360.w,
                        child: Image.asset(AssetsPathes.appLogoImage)),
                    Container(
                      color: AppColor.blackTextColor,
                      height: 40.h,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Text(
                              homeController.currentDate.value,
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  color: Colors.white,
                                  fontSize: 14.0.sp),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Text(
                              homeController.currentTime.value,
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  color: Colors.white,
                                  fontSize: 14.0.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 81.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.appMainColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0.r),
                          bottomRight: Radius.circular(50.0.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AssetsPathes.locationIcon),
                          SizedBox(width: 8.0.w),
                          Text(
                            "${homeController.city.value},${homeController.locality.value}",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontFamily: "Inter-Bold",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                20.0.r), // Adjust the radius as needed
                            border: Border.all(
                              color: Colors
                                  .grey, // You can customize the border color here
                              width: 1.0
                                  .w, // You can adjust the width of the border
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20.0.r), // Same radius as the container
                            child: Container(
                              alignment: Alignment.center,
                              width: 263.w,
                              height: 270.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: InkWell(
                                          onTap: () {
                                            print("Clicked");
                                            Get.to(() => BuyTicketScreen(),
                                                transition: Transition
                                                    .leftToRightWithFade);
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                                width: 50.w,
                                                child: Image.asset(
                                                    AssetsPathes.BuyTicket),
                                              ),
                                              Text("Buy Ticket",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: 'Inter-Regular',
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to( FeederStatusScreen(),transition: Transition.leftToRightWithFade);
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                                width: 50.w,
                                                child: Image.asset(
                                                    AssetsPathes.FeederStatus),
                                              ),
                                              Text("Feeder Status",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily:
                                                          'Inter-Regular')),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: InkWell(
                                          onTap: () {
                                            print("Clicked");
                                            Get.to(() => RechargeScreen(),
                                                transition: Transition
                                                    .leftToRightWithFade);
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                                width: 50.w,
                                                child: Image.asset(
                                                    AssetsPathes.Recharge),
                                              ),
                                              Text("Recharge",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily:
                                                          'Inter-Regular')),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: InkWell(
                                          onTap: () {
                                            Get.off(HistoryScreen(),
                                                transition: Transition
                                                    .leftToRightWithFade);
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                                width: 50.w,
                                                child: Image.asset(
                                                    AssetsPathes.TravelHistory),
                                              ),
                                              Text("Travel History",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontFamily:
                                                          'Inter-Regular')),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }))),
        ),
      ),
    );
  }
}
