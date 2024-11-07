import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/account_ownership_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/contact_info_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/menu/profile_controller.dart';
import '../../../../helpers/profile/edit_profile_helper.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

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
            title: "Personal Details",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Normalext(
                "Bip-Hip uses this information to verify your identity and to keep our community safe. You decide what personal details you make visible to others.",
                txtAlign: TextAlign.justify,
                fontSize: 25.sp,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: cGreyBoxColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(const ContactInfo());

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("Contact info"),
                              for (int i = 0;
                                  i < profileController.contactDataList.length;
                                  i++)
                                if (profileController.contactDataList[i].type ==
                                    'email')
                                  Normalext(
                                    checkNullOrStringNull(profileController
                                        .contactDataList[i].value),
                                    fontSize: 26.sp,
                                  ),
                              for (int i = 0;
                                  i < profileController.contactDataList.length;
                                  i++)
                                if (profileController.contactDataList[i].type ==
                                    'phone')
                                  Normalext(
                                    checkNullOrStringNull(profileController
                                        .contactDataList[i].value),
                                    fontSize: 26.sp,
                                  ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: cIconColor,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomDivider(),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: (){
                        editProfileHelper.editBirthday();

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("Birthday"),
                              Normalext(
                                profileController.userData.value!.dob == null
                                    ? ksDateOfBirth.tr
                                    : DateFormat("MMMM dd, yyyy").format(profileController.userData.value!.dob!),
                                fontSize: 26.sp,
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: cIconColor,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CustomDivider(),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: (){
                        Get.to(const AccountOwnership());

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("Account ownership and control"),
                              Normalext(
                                  "Deactivate or delete your account and profile",
                                  fontSize: 26.sp),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: cIconColor,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
