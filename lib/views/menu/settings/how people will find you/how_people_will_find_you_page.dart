import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/settings/settings_controller.dart';
import '../../../../models/privacySettings/privacySettings.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import 'modalsheetWidget.dart';

class HowPeopleWillFindYou extends StatefulWidget {
  const HowPeopleWillFindYou({Key? key}) : super(key: key);

  @override
  State<HowPeopleWillFindYou> createState() => _HowPeopleWillFindYouState();
}

class _HowPeopleWillFindYouState extends State<HowPeopleWillFindYou> {
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
          preferredSize: Size.fromHeight(kAppBarSizeSetting),
          child: CustomAppBar(
            onBack: () {
              Get.back();
            },
            title: ksHowPeopleWillFindYou.tr,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      color: cGreyBoxColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              child: HeaderText(
                                "Who can send you friend requests?",
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
                                  ),
                                  context: context, builder: (BuildContext context){

                                return ModalSheetWidget("Who can send you friend requests?"
                                    ,"Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post",
                                    0,privacySettingsController.settingsPrivacyData.value!);
                              });
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4.5.h),
                                    child: Normalext(
                                      // "Everyone",
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.friendRequestSetting),
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
                      SizedBox(
                        height: 15,
                      ),
                      CustomDivider(),
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "Who can see your friends list?",
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
                                      ),
                                      context: context, builder: (BuildContext context){
                                    return ModalSheetWidget(
                                        "Who can see your friends list?",
                                        "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post"
                                        ,
                                        1,privacySettingsController.settingsPrivacyData.value! );
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
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
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 4.5.h),
                                        child: Normalext(
                                          // "Public",
                                          privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.friendsListVisibility),
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
                            "Remember, your friends control who can see their friendships on their own Timelines. If people can see your friendship on another timeline, they'll be able to see it in News Feed, search and other places on Facebook. If you set this to Only me, only you will be able to see your full friends list on your timeline. Other people will see only mutual friends.",
                            fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomDivider(),
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "For people with your phone number, deliver requests to:",
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
                                      ),
                                      context: context, builder: (BuildContext context){

                                    return ModalSheetWidget(
                                        "For people with your phone number, deliver requests to:",
                                        // "How you get message requests",
                                        "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post"
                                        ,
                                        2, privacySettingsController.settingsPrivacyData.value!);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: cPrimaryTint3Color,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 4.5.h),
                                    child: Normalext(
                                      // "Message request",
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.phoneNumberDeliveryPreference),
                                      weight: FontWeight.bold,
                                      fontSize: 26.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Normalext(
                            "Message requests from people on Messenger or Facebook with your phone number in their uploaded contacts will be delivered to your Chats list unless you choose otherwise. This includes people you're not friends with on Bip-Hip. New group chat message requests won't be delivered to your Chats list.",
                            fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomDivider(),
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "For friends of friends on Bip-Hip, deliver requests to:",
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet<void>(
                                      // isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
                                      ),
                                      context: context, builder: (BuildContext context){
                                    return ModalSheetWidget(
                                        "For friends of friends on Bip-Hip, deliver requests to:",
                                            // "How you get message requests",
                                        "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post"
                                        ,
                                        2, privacySettingsController.settingsPrivacyData.value!);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: cPrimaryTint3Color,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 4.5.h),
                                    child: Normalext(
                                      // "Message request",
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.friendsOfFriendsDeliveryPreference),

                                      weight: FontWeight.bold,
                                      fontSize: 26.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Normalext(
                            "Group message requests won't be delivered to your Chats list. Remember not all messages are message requests, see the full list of",
                            fontSize: 25.sp,
                            txtAlign: TextAlign.start,
                            weight: FontWeight.normal,
                            color: cBlackColor,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomDivider(),
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                    child: HeaderText(
                                      "For others on Messenger or Bip-Hip, deliver requests to:",
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
                                      ),
                                      context: context, builder: (BuildContext context){

                                    return Container(
                                      height: 10000,
                                      child: ModalSheetWidget(
                                          "For others on Messenger or Bip-Hip, deliver requests to:",
                                          // "How you get message requests",
                                          "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post"
                                          ,
                                          2, privacySettingsController.settingsPrivacyData.value!),
                                    );
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: cPrimaryTint3Color,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 4.5.h),
                                    child: Normalext(
                                      // "Message request",
                                      privacySettingsController.getPrivacySettingValueText(privacySettingsController.settingsPrivacyData.value?.publicDeliveryPreference),
                                      weight: FontWeight.bold,
                                      fontSize: 26.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Normalext(
                            "Some conversations, like those that might go against our Community Standards, will be delivered to Spam. Remember not all messages are message requests, see the full list of who can message you.",
                            fontSize: 25.sp,
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
