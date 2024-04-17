import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../core/configs/styles/app_colors.dart';
import '../controller/about_sat_controller.dart';
import '../controller/faq_controller.dart';
import '../controller/terms_controller.dart';
import 'about_screen.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final FaqController faqController = Get.put(FaqController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqController.fetchFaq();
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (faqController.faqMessage.value.isEmpty ||
                        faqController.faqData.value.isEmpty) {
                      return SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: const Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CupertinoActivityIndicator(),
                          ],
                        ),
                      );
                    } else {
                      return Column(
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
                                      Get.to(const AboutScreen(),
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
                                      '${faqController.faqMessage.value}',
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Html(
                              data: '${faqController.faqData.value}',
                              style: {
                                "body": Style(
                                    color: Colors.white,
                                    fontFamily: 'Inter-Regular'),
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
