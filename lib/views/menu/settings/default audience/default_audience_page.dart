import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/password_and_security_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/delete_account_page.dart';
import 'package:bip_hip/views/menu/settings/selectCustomAudience.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/menu/friend_controller.dart';
import '../../../../controllers/settings/privacy_settings_controller.dart';

class DefaultAudience extends StatefulWidget {
  const DefaultAudience({Key? key}) : super(key: key);

  @override
  State<DefaultAudience> createState() => _DefaultAudienceState();
}

class _DefaultAudienceState extends State<DefaultAudience> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();
  @override
  Widget build(BuildContext context) {
    return  Obx
      (() => Stack(
      children: [
        SafeArea(
          top: false,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kAppBarSizeSetting),
              child: CustomAppBar(
                onBack: (){
                  Get.back();
                },
                title: "Choose your default audience",
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Normalext(
                    "We will send a notification for your every new login.", txtAlign: TextAlign.justify,fontSize: 26.sp,),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 770.h,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                        color: cGreyBoxColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText("Public"),
                                SizedBox(height: 5,),
                                Container(
                                    width: 500.w,
                                    child: Normalext("Anyone can see what you share and interact with your content.", fontSize: 26.sp, txtAlign: TextAlign.start,)),
                              ],
                            ),
                            IconButton(onPressed: (){
                            },
                              icon: Radio<int>(
                                value: 0,
                                groupValue: privacySettingsController.radioValue,
                                onChanged: (value) {
                                  setState(() {
                                    privacySettingsController.radioValue = value!;
                                    privacySettingsController.radioStringValue = 'public';
                                    print("Button value: $value");
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                        CustomDivider(),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText("Family"),
                                SizedBox(height: 5,),
                                Container(
                                    width: 500.w,
                                    child: Normalext("Anyone can see what you share and interact with your content.", fontSize: 26.sp)),
                              ],
                            ),
                            IconButton(
                              onPressed: (){
                              },
                              icon: Radio<int>(
                                value: 1,
                                groupValue: privacySettingsController.radioValue,
                                onChanged: (value) {
                                  setState(() {
                                    privacySettingsController.radioValue = value!;
                                    privacySettingsController.radioStringValue = 'family';
                                    print("Button value: $value");
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                        CustomDivider(),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText("Friends"),
                                SizedBox(height: 5,),
                                Container(
                                    width: 500.w,
                                    child: Normalext("Anyone can see what you share and interact with your content.", fontSize: 26.sp, txtAlign: TextAlign.start,)),
                              ],
                            ),
                            IconButton(onPressed: (){
                            },
                              icon: Radio<int>(
                                value: 2,
                                groupValue:privacySettingsController.radioValue,
                                onChanged: (value) {
                                  setState(() {
                                    privacySettingsController.radioValue = value!;
                                    privacySettingsController.radioStringValue = 'friends';
                                    print("Button value: $value");
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                        CustomDivider(),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText("Friend and Family"),
                                SizedBox(height: 5,),
                                Container(
                                    width: 500.w,
                                    child: Normalext("Anyone can see what you share and interact with your content.", fontSize: 26.sp, txtAlign: TextAlign.start,)),
                              ],
                            ),
                            IconButton(onPressed: (){
                            },
                              icon: Radio<int>(
                                value: 3,
                                groupValue: privacySettingsController.radioValue,
                                onChanged: (value) {
                                  setState(() {
                                    privacySettingsController.radioValue = value!;
                                    privacySettingsController.radioStringValue = 'friends_and_family';
                                    print("Button value: $value");
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                        CustomDivider(),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText("Custom"),
                                SizedBox(height: 5,),
                                Container(
                                    width: 500.w,
                                    child: Normalext("Anyone can see what you share and interact with your content.", fontSize: 26.sp, txtAlign: TextAlign.start,)),
                              ],
                            ),
                            IconButton(onPressed: (){
                            },
                              icon: Radio<int>(
                                value: 4,
                                groupValue: privacySettingsController.radioValue,
                                onChanged: (value) {
                                    privacySettingsController.getCustomAudience();
                                    Get.toNamed(krSelectCustomAudience);
                                    Get.find<FriendController>().getFriendList();
                                    privacySettingsController.radioValue = value!;
                                    privacySettingsController.radioStringValue = 'custom';
                                    print("Button value: $value");
                                },
                              ),
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
            bottomNavigationBar: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue
                ),
                child: Normalext('Save', color: Colors.white,),
                onPressed:privacySettingsController.settingsPrivacyData.value?.defaultAudienceSetting != privacySettingsController.radioStringValue? ()  {
                  privacySettingsController.updateSpecificPrivacySettings("default_audience", privacySettingsController.radioStringValue!);
                }:null,
              ),
            ),
          ),
        ),
        if (privacySettingsController.isPrivacySettingsLoading.value ==
            true)
          Positioned(
            child: CommonLoadingAnimation(
              onWillPop: () async {
                if (privacySettingsController
                    .isPrivacySettingsLoading.value) {
                  return false;
                }
                return true;
              },
            ),
          ),
      ],
    ));
  }
}
