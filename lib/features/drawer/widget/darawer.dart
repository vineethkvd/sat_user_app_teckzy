import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/configs/styles/app_colors.dart';
import '../../about/view/about_screen.dart';
import '../../buy_tickets/view/buy_ticket.dart';
import '../../feeder_status/view/feedr_status.dart';
import '../../history/view/history_screen.dart';
import '../../logout/controller/log_out_controller.dart';
import '../../notification/view/notification_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../show_ticket/view/show_ticket.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final LogOutController logOutController = Get.put(LogOutController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Wrap(
        runSpacing: 10,
        children: [
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
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
              Get.to(ShowTicketScreen(),transition: Transition.leftToRightWithFade);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Show Ticket",
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

                Get.to(BuyTicketScreen(),transition: Transition.leftToRightWithFade);

            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Buy Ticket",
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
              Get.to(FeederStatusScreen(),transition: Transition.leftToRightWithFade);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Feeder Status",
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
              Get.to(HistoryScreen(),transition: Transition.leftToRightWithFade);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "History",
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
              Get.to(NotificationScreen(),transition: Transition.leftToRightWithFade);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Notification",
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
              Get.to(ProfileScreen(),
                  transition: Transition.leftToRightWithFade);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "My Profile",
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
              Get.back(); // Close the current screen
              Future.delayed(Duration(milliseconds: 300), () {
                Get.to(AboutScreen(),
                    transition: Transition.leftToRightWithFade);
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "About Us",
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
              logOutController.logout();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Logout",
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
      backgroundColor: AppColor.appMainColor,
    );
  }
}
