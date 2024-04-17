import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../../auth/view/login/login_screen.dart';
import '../../home/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() async {
    final storedValue = await CacheHelper.getData('cusid');
    if (storedValue != null && storedValue.isNotEmpty) {
      Get.offAll(const HomeScreen());
    } else {
      Get.offAll(const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: AppColor.whiteColor,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to SAT Mobility Solutions",
                  style: TextStyle(
                    fontFamily: "Inter-Bold",
                    fontSize: 15.sp,
                    color: AppColor.whiteColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Image.asset(
                  AssetsPathes.appLogoImage,
                  height: 221.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
