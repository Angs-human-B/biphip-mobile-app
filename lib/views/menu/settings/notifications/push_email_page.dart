import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';

import '../../../../controllers/settings/privacy_settings_controller.dart';
import '../../../../models/privacySettings/privacySettings.dart';

class PushEmail extends StatefulWidget {
  String title;
  PushEmail(this.title, {Key? key}) : super(key: key);

  @override
  State<PushEmail> createState() => _PushEmailState();
}

class _PushEmailState extends State<PushEmail> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
            () => Stack(
          children: [  SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cWhiteColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSizeSetting),
          child: CustomAppBar(
            onBack: () {
              Get.back();
            },
            title:"${widget.title} settings",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(ksPush.tr),
                  Switch(
                    value: privacySettingsController.getNotificationTypeFromTitle(widget.title)?.push??false,
                    activeTrackColor:Colors.green ,
                    thumbColor: WidgetStateProperty.all(cWhiteColor),
                    onChanged: (bool value) {
                      setState(() {
                        privacySettingsController.getNotificationTypeFromTitle(widget.title)?.push = value;
                        privacySettingsController.updateSpecificPrivacySettings("${privacySettingsController.getSettingKeyFromTitle(widget.title)}.push", value);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(ksEmail.tr),
                  Switch(
                    value: privacySettingsController.getNotificationTypeFromTitle(widget.title)?.email??false,
                    activeTrackColor:Colors.green ,
                    thumbColor: WidgetStateProperty.all(cWhiteColor),
                    onChanged: (bool value) {
                      setState(() {
                        privacySettingsController.getNotificationTypeFromTitle(widget.title)?.email = value;
                        privacySettingsController.updateSpecificPrivacySettings("${privacySettingsController.getSettingKeyFromTitle(widget.title)}.email", value);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
          child: TextButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: cPrimaryColor
            ),
            onPressed: () {
              Get.back();
              // privacySettingsController.getPrivacySettings();
            },
            child: HeaderText("Save", color: cWhiteColor,),
          ),
        )
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