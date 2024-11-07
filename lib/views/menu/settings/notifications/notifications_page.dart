import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/notifications/notification_listview_widget.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List notificationSettings = [
    {
      "header":"",
      "title": "Comments",
      "description":"Push, Email"
    },
    {
      "header":"",
      "title": "Tags",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Reminders",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "More Activity About You",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Updates from friends",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Friend request",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Birthdays",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Group chat",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Kids",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Shop",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Post",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Marketplace",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Messages",
      "description":"Push, Email"
    },{
      "header":"",
      "title": "Others Notifications",
      "description":"Push, Email"
    },
    {
      "header":"What Notification You Receive",
      "title": "Comments",
      "description":"Push, Email"
    },
    {
      "header":"",
      "title": "Others Notifications",
      "description":"Push, Email"
    },

  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            Get.back();
          },
          title: ksNotificationsSetting.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Normalext("Bip-hip may still send you important notifications about your account and content outside of your preferred notification settings."),
            SizedBox(height: 20.h,),
            Expanded(
              child: NotificationListviewWidget()
            ),
          ],
        ),
      ),
    );
  }
}
