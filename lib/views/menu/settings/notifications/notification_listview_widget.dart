import 'package:bip_hip/controllers/settings/privacy_settings_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/notifications/push_email_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
class NotificationListviewWidget extends StatefulWidget {
  const NotificationListviewWidget({Key? key}) : super(key: key);

  @override
  State<NotificationListviewWidget> createState() => _NotificationListviewWidgetState();
}

class _NotificationListviewWidgetState extends State<NotificationListviewWidget> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();
  List notificationSettings = [
    {
      "title": "Comments",
    },{
      "title": "Tags",
    },{
      "title": "Reminders",
    },{
      "title": "More Activity About You",
    },{
      "title": "Updates from friends",
    },{
      "title": "Friend request",
    },{
      "title": "Birthdays",
    },{
      "title": "Group chat",
    },{
      "title": "Kids",
    },{
      "title": "Shop",
    },{
      "title": "Post",
    },{
      "title": "Marketplace",
    },{
      "title": "Messages",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*.9,
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
                InkWell(
                  onTap:(){
                    Get.to(PushEmail(notificationSettings[index]['title']));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h,),
                      Padding(
                        padding:  const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText(notificationSettings[index]['title']),
                                SizedBox(height: 10.h,),
                                Normalext(privacySettingsController.getActiveNotificationTypesFromTitle(notificationSettings[index]['title'])),
                              ],
                            ),
                            Icon(BipHip.rightArrow, color: cIconColor,size: 60.sp,),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      if(index != notificationSettings.length-1)
                        const CustomDivider(thickness: 2,)
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
