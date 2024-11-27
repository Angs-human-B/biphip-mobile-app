import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/settings/settings_controller.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../how people will find you/modalsheetWidget.dart';

class ProfileAndTaggingSettingsPage extends StatefulWidget {
  const ProfileAndTaggingSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileAndTaggingSettingsPage> createState() => _ProfileAndTaggingSettingsPageState();
}

class _ProfileAndTaggingSettingsPageState extends State<ProfileAndTaggingSettingsPage> {
  bool toggleShareYourPostsToTheirStories = true;
  bool toggleReviewPosts = false;
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
            title: ksProfileAndTagging.tr,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                                child: HeaderText(
                                  "Who can post on your profile?",
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
                                        "Who can post on your profile?",
                                        "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post",
                                        1,privacySettingsController.settingsPrivacyData.value!);
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
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.whoCanPostOnYourProfile),
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
                      const SizedBox(height: 10),
                      const CustomDivider(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                                child: HeaderText(
                                  "Who can see what others post on your profile?",
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
                                        "Who can see what others post on your profile?",
                                        "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post",
                                        1,privacySettingsController.settingsPrivacyData.value!);
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
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.whoCanSeeWhatOthersPostOnYourProfile),
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
                      const SizedBox(height: 10),
                      const CustomDivider(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                                child: HeaderText(
                                  "Who can see what others post on your profile Friends?",
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
                                        "Who can see what others post on your profile Friends?",
                                        "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post",
                                        1,privacySettingsController.settingsPrivacyData.value!);
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
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.whoCanSeeWhatOthersPostOnYourProfileFriends),
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
                                HeaderText("Allow others to share your posts to their stories?"),
                                const SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  child: Normalext(
                                    "If you create a public post, anyone on Facebook can share it to their story. If you tag someone in any post, they can share it to their story. Their story will include your full name, a link to your post, and will be visible for 24 hours. They control who sees it.",fontSize: 26.sp,
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
                                privacySettingsController.updateSpecificPrivacySettings('review_posts_youre_tagged_in_before_they_appear_on_your_profile', value);
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
                                HeaderText("Review posts you're tagged in before the post appears on your profile?"),
                                const SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  child: Normalext(
                                    "This only controls what's allowed on your profile. Posts you're tagged in still appear in search, News Feed and other places on Facebook.",fontSize: 26.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: privacySettingsController.settingsPrivacyData.value?.reviewPostsYoureTaggedInBeforeTheyAppearOnYourProfile??true,
                            activeTrackColor:Colors.green ,
                            thumbColor: WidgetStateProperty.all(cWhiteColor),
                            onChanged: (bool value) {
                              setState(() {
                                privacySettingsController.settingsPrivacyData.value?.reviewPostsYoureTaggedInBeforeTheyAppearOnYourProfile = value;
                                privacySettingsController.updateSpecificPrivacySettings('review_posts_youre_tagged_in_before_they_appear_on_your_profile', value);
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
