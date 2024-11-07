import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controllers/menu/profile_controller.dart';
import '../../../../helpers/profile/edit_profile_helper.dart';
import '../../../../shimmers/profile/gender_shimmer.dart';
import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';
import 'package:bip_hip/utils/icons/bip_hip_icons.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  List contact_info = [
    "shohagjalal@gmail.com",
    "sshohagjalal@gmail.com",
    "+8801793-144278",
    "+8801993-144278"
  ];
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();
  showBottomSheet() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(top: 50.h, left: 30.w),
            child: Container(
              height: 500.h,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  HeaderText('Which would you like to add?'),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    height: 200.h,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        color: cGreyBoxColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.to(AddContactInfo("Add Contact Info", 'phone'));
                              editProfileHelper.addPhone();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Normalext("Add mobile number",
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          const CustomDivider(),
                          SizedBox(height: 35.h),
                          GestureDetector(
                            onTap: () {
                              // Get.to(AddContactInfo("Add Contact Info", "email"));
                              editProfileHelper.addEmail();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Normalext(
                                "Add email",
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              title: "Contact Info",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Normalext(
                      "Manage your mobile numbers and emails to make sure your contact info is accurate and up to date."),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => profileController.isProfileLoading.value
                      ? const GenderListShimmer()
                      : Container(
                          height:
                              70.h * profileController.contactDataList.length,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                              color: cGreyBoxColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  profileController.contactDataList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (checkNullOrStringNull(
                                                profileController
                                                    .contactDataList[index]
                                                    .value)
                                            .contains(".")) {
                                          editProfileHelper.editEmail(index);
                                          // Get.to(AddContactInfo("Edit Contact Info", 'email',controllerTxt: contact_info[index],));
                                        } else {
                                          editProfileHelper.editPhone(index);
                                          // Get.to(AddContactInfo("Edit Contact Info", 'phone',controllerTxt: contact_info[index],));
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.w),
                                            child: Normalext(
                                                checkNullOrStringNull(
                                                    profileController
                                                        .contactDataList[index]
                                                        .value)),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          const IconButton(
                                              onPressed: null,
                                              icon: Icon(BipHip.edit))
                                        ],
                                      ),
                                    ),
                                    if (index <
                                        profileController
                                                .contactDataList.length -
                                            1)
                                      const CustomDivider()
                                  ],
                                );
                              })))
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            child: ElevatedButton(
              child: Normalext(
                '+ Add new contact',
                color: Colors.white,
              ),
              onPressed: () {
                showBottomSheet();
              },
            ),
          )),
    );
  }
}
