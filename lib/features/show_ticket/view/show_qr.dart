import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sat_user_app_teckzy/features/show_ticket/view/show_ticket.dart';


import '../../../core/configs/styles/app_colors.dart';

class ShowQrScreen extends StatefulWidget {
  final String image;
  final String expiry;
  final String type;
  final String place;
  const ShowQrScreen(
      {Key? key,
      required this.image,
      required this.expiry,
      required this.type,
      required this.place})
      : super(key: key);

  @override
  State<ShowQrScreen> createState() => _ShowQrScreenState();
}

class _ShowQrScreenState extends State<ShowQrScreen> {
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
                            Get.to(const ShowTicketScreen(),
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
                      SizedBox(
                        width: Get.width * 0.55,
                        child: Center(
                          child: Text(
                            'Show QR',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Inter-Bold",
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 250.h,
                    width: 250.w,
                    color: Colors.white,
                    child: CachedNetworkImage(
                      imageUrl: "https://${widget.image}",
                      placeholder: (context, url) =>
                          CupertinoActivityIndicator(), // Placeholder widget while loading
                      errorWidget: (context, url, error) => Icon(Icons
                          .error), // Widget to display in case of loading error
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.sp),
                        child: Text(
                          "${widget.place}",
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontFamily: 'Inter-Regular',
                              fontSize: 14.sp),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.sp),
                        child: Text(
                          "Type: ${widget.type}",
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontFamily: 'Inter-Regular',
                              fontSize: 14.sp),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 15.sp),
                        child: Text(
                          "Validity: ${widget.expiry}",
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontFamily: 'Inter-Regular',
                              fontSize: 14.sp),
                        ),
                      ),

                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
