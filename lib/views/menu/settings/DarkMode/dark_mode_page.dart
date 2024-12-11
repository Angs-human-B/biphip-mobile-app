import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/settings/privacy_settings_controller.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
            () => Stack(
          children: [SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kAppBarSizeSetting),
          child: CustomAppBar(
            onBack: () {
              Get.back();
            },
            title: ksDarkMode.tr,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  color: cGreyBoxColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("Dark mode"),
                              const SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                child: Normalext(
                                  "Adjust the appearance of BipHip app to reduce glare and give your eyes a break.",
                                  fontSize: 26.sp,
                                  txtAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: privacySettingsController.settingsPrivacyData.value?.darkModeEnabled??false,
                          activeTrackColor:Colors.green ,
                          thumbColor: WidgetStateProperty.all(cWhiteColor),
                          onChanged: (bool value) {
                            setState(() {
                              privacySettingsController.settingsPrivacyData.value?.darkModeEnabled = value;
                              privacySettingsController.updateSpecificPrivacySettings("dark_mode_enabled", value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
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