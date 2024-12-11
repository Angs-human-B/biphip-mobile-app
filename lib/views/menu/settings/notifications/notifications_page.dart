import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/notifications/notification_listview_widget.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controllers/settings/privacy_settings_controller.dart';
import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
            () => Stack(
          children: [   SafeArea(
      top: false,
      child: Scaffold(
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
      ),
    ),
    if (privacySettingsController.isPrivacySettingsLoading.value == true)
    Positioned(
    child: CommonLoadingAnimation(
    onWillPop: () async {
    if (privacySettingsController.isPrivacySettingsLoading.value) {
    return false;
    }
    return true;
    },
    ),
    ),
    ],
    ),
    ),
    );
  }
}