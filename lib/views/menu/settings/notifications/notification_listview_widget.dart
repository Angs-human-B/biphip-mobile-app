import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter/material.dart';
import 'package:bip_hip/views/menu/settings/notifications/push_email_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
class NotificationListviewWidget extends StatefulWidget {
  const NotificationListviewWidget({Key? key}) : super(key: key);

  @override
  State<NotificationListviewWidget> createState() => _NotificationListviewWidgetState();
}

class _NotificationListviewWidgetState extends State<NotificationListviewWidget> {
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
    return Container(
      width: MediaQuery.of(context)!.size.width*.9,
      decoration: BoxDecoration(
          color: cGreyBoxColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListView.builder(
          itemCount: notificationSettings.length,
          itemBuilder: (context, index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                notificationSettings[index]['header'] != ""?
                Container(
                    height: 100.h,
                    width :MediaQuery.of(context)!.size.width*.9,
                    alignment: Alignment.centerLeft,
                    color: cWhiteColor,
                    child: HeaderText(notificationSettings[index]['header'])): Container(),
                InkWell(
                  onTap:(){
                    Get.to(PushEmail(notificationSettings[index]['title']));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h,),
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText(notificationSettings[index]['title']),
                                SizedBox(height: 10.h,),
                                Normalext(notificationSettings[index]['description']),
                              ],
                            ),
                            Icon(BipHip.rightArrow, color: cIconColor,size: 60.sp,),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      if(index != 13)
                        CustomDivider(thickness: 2,)
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
