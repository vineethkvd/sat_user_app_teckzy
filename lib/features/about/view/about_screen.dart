import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sat_user_app_teckzy/features/about/view/policy_screen.dart';
import 'package:sat_user_app_teckzy/features/about/view/terms_screen.dart';

import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../controller/about_sat_controller.dart';
import 'about_sat_screen.dart';
import 'contact_us_screen.dart';
import 'faq_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: AppColor.appMainColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.15,
                        child: InkWell(
                          onTap: () {
                            Get.to(HomeScreen(),
                                transition: Transition.leftToRightWithFade);
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
                            'About Us',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Inter-Bold",
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:  Get.width * 0.2.w,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(AboutSatScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "About SAT",
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 30.h,
                // ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(TermsScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "Terms & Conditions",
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(PolicyScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(ContactUsScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "Contact Us",
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(FaqScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "FAQs",
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
