import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/settings/privacy_settings_controller.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../how people will find you/modalsheetWidget.dart';

class FollowersSettingsPage extends StatefulWidget {
  const FollowersSettingsPage({Key? key}) : super(key: key);

  @override
  State<FollowersSettingsPage> createState() => _FollowersSettingsPageState();
}

class _FollowersSettingsPageState extends State<FollowersSettingsPage> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
            () => Stack(
          children: [ SafeArea(
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
            title: ksFollowers.tr,
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
                                      "Who can follow me?",
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
                                            "Who can follow me?",
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
                                          privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.whoCanFollowMe),
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
                            "Followers see your posts, reels and stories in Feed. Friends follow your posts, reels and stories by default, but you can also allow people who are not your friends to follow your public posts, reels and stories. Use this setting to choose who can follow you. Each time you post or create a reel or story, you choose which audience you want to share with. This setting doesn't apply to people who follow you on Marketplace and in buy and sell groups. You can manage those settings on Marketplace.",fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const CustomDivider(),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                                child: HeaderText(
                                  "Who can see your followers on your timeline?",
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
                                        "Who can see your followers on your timeline?",
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
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.whoCanSeeYourFollowers),
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
                      const CustomDivider(),const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "Who can see the people, Pages and lists you follow?",
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
                                            "Who can see the people, Pages and lists you follow?",
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
                                          privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.whoCanSeePeoplePagesListsYouFollow),
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
                            "Remember, the people you follow can see that you're following them.",fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const CustomDivider(),
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "Who can comment on your public posts?",
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
                                            "Who can comment on your public posts?",
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
                                          privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.whoCanCommentOnYourPublicPosts),
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
                            "Choose who is allowed to comment on your public posts. People tagged in your public posts and their friends may still be able to comment.",fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const CustomDivider(),const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "Public post notifications",
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
                                            "Public post notifications",
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
                                          privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.publicPostNotifications),
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
                            "You can get notifications when people who aren't your friends start following you and share, like or comment on your public posts.",fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const CustomDivider(),const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "Public profile info",
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
                                            "Public profile info",
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
                                          privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.publicProfileInfo),
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
                            "Manage who can like or comment on profile information that is always public, including your profile pictures, profile videos, cover photos, featured photos and updates to your short bio.",fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      SizedBox(height: 15),
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
