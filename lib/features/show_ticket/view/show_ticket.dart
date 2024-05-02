import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sat_user_app_teckzy/features/show_ticket/view/show_qr.dart';

import '../../../core/configs/styles/app_colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../../home/view/home_screen.dart';
import '../controller/show_ticket_controller.dart';
import '../model/show_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowTicketScreen extends StatefulWidget {
  const ShowTicketScreen({Key? key}) : super(key: key);

  @override
  State<ShowTicketScreen> createState() => _ShowTicketScreenState();
}

class _ShowTicketScreenState extends State<ShowTicketScreen> {
  final ShowTicketController showTicketController =
      Get.put(ShowTicketController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTicketController. fetchShowTicket();
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
              child: Obx(
                () => SingleChildScrollView(
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
                              width: Get.width * 0.2.w,
                              child: InkWell(
                                onTap: () {
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
                            SizedBox(
                              width: Get.width * 0.55,
                              child: Center(
                                child: Text(
                                  'Show Ticket',
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
                      if (showTicketController.showTicketModel.value.status ==
                          true)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: showTicketController
                                  .showTicketModel.value.ticketData?.length ??
                              0,
                          itemBuilder: (context, index) {
                            TicketData ticketData = showTicketController
                                .showTicketModel.value.ticketData![index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                    ShowQrScreen(
                                      image: "${ticketData.ticketQrCode}",
                                      expiry: '${ticketData.ticketValid}',
                                      type: '${ticketData.ticketType}',
                                      place:
                                          '${ticketData.pickup} - ${ticketData.destination}',
                                    ),
                                    transition:
                                        Transition.leftToRightWithFade);
                              },
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 15.sp,vertical: 6.sp),
                                child: Container(
                                  height: 130.h,
                                  width: Get.width * 0.65.w,
                                  decoration: const BoxDecoration(
                                    color: AppColor.brownColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${ticketData.pickup} - ${ticketData.destination}',style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                                                Text(
                                                    'Type: ${ticketData.ticketType}',style: TextStyle(fontSize: 12.sp,color: Colors.black)),
                                                Text(
                                                    'Validity: ${ticketData.ticketValid}',style: TextStyle(fontSize: 12.sp,color: Colors.black)),
                                              ]),
                                        ),
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 130.h,
                                              width: 123.w,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://${ticketData.ticketQrCode.toString()}",
                                                placeholder: (context, url) =>
                                                    const CupertinoActivityIndicator(), // Placeholder widget while loading
                                                errorWidget: (context, url,
                                                        error) =>
                                                    const Icon(Icons
                                                        .error), // Widget to display in case of loading error
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      else
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                'No data available',
                                style: TextStyle(color: Colors.white),
                              ))
                            ]),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
