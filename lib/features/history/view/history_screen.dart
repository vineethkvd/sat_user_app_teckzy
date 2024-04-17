import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../core/configs/styles/app_colors.dart';
import '../../home/view/home_screen.dart';
import '../controller/history_controller.dart';
import '../model/history_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryController historyController =
  Get.put(HistoryController());
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Get.to(const HomeScreen(),transition: Transition.leftToRightWithFade);
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
                                'History',
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
                    StreamBuilder<RxList<TotalTrips>>(
                      stream: historyController.fetchNotification(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error fetching data: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text('No data available.'),
                          );
                        } else {
                          final dataList = snapshot.data!;
                          return SizedBox(
                            height: Get.height.h,
                            child: ListView.builder(
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                final data = dataList[index];
                                return  Padding(
                                  padding: EdgeInsets.all(15.0.w),
                                  child: Container(
                                    height: 130.h,
                                    width: 310.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.brownColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.w),
                                                  child: Text('${data.pickup}-${data.destination}'),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(3.w),
                                                  child: Text('${data.totalTravelTime}'),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(3.w),
                                                  child: Text('${data.date}'),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(3.w),
                                                  child: Text('${data.endTime}'),
                                                ),
                                              ]),
                                        ),
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 130.h,
                                                width: 123.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
