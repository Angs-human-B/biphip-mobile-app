import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/settings/settings_controller.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../how people will find you/modalsheetWidget.dart';

class SelfiesSettingsPage extends StatefulWidget {
  const SelfiesSettingsPage({Key? key}) : super(key: key);

  @override
  State<SelfiesSettingsPage> createState() => _SelfiesSettingsPageState();
}

class _SelfiesSettingsPageState extends State<SelfiesSettingsPage> {
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
            title: ksSelfies.tr,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      color: cGreyBoxColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "Who can see your stories?",
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                            Radius.circular(k16BorderRadius),
                                            topRight:
                                            Radius.circular(k16BorderRadius)),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ModalSheetWidget(
                                            "Who can see your stories?",
                                            "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post",
                                            1,privacySettingsController.settingsPrivacyData.value! );
                                      });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: cPrimaryTint3Color,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        BipHip.world,
                                        color: Colors.black,
                                        size: 30.sp,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 4.5.h),
                                        child: Normalext(
                                          // "Public",
                                          privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.selfieVisibility),
                                          weight: FontWeight.bold,
                                          fontSize: 26.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Normalext(
                            "Your default audience is set to Public. This will be your audience for See star bonus, but you can always change it for a specific post.",
                            fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const CustomDivider(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText("Allow others to share your public stories to their own story?"),
                                const SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  child: Normalext(
                                    "Their story will include your full name and a link to your original story. They control who sees it.",fontSize: 26.sp,
                                    txtAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: privacySettingsController.settingsPrivacyData.value?.allowOthersToShareYourPublicStoriesToTheirStory??true,
                            activeTrackColor:Colors.green ,
                            thumbColor: WidgetStateProperty.all(cWhiteColor),
                            onChanged: (bool value) {
                              setState(() {
                                privacySettingsController.settingsPrivacyData.value?.allowOthersToShareYourPublicStoriesToTheirStory = value;
                                privacySettingsController.updateSpecificPrivacySettings('allow_others_to_share_your_public_stories_to_their_story', value);
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const CustomDivider(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText("Archiving your stories"),
                                const SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  child: Normalext(
                                   "Automatically archive photos and videos after they disappear from your story. Only you can see your story archive.",fontSize: 26.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: privacySettingsController.settingsPrivacyData.value?.storyArchiving??true,
                            activeTrackColor:Colors.green ,
                            thumbColor: WidgetStateProperty.all(cWhiteColor),
                            onChanged: (bool value) {
                              setState(() {
                                privacySettingsController.settingsPrivacyData.value?.storyArchiving = value;
                                privacySettingsController.updateSpecificPrivacySettings('story_archiving', value);
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                )
              ],
            ),
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
