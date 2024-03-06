import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_post_tab.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorBuilder.dart';
import 'package:flutter_svg/svg.dart';

class EditKidProfile extends StatelessWidget {
  EditKidProfile({super.key, this.profilePicture, this.coverPhoto});
  final String? profilePicture;
  final String? coverPhoto;
  // final ProfileController profileController = Get.find<ProfileController>();
  // final ProfileHelper profileHelper = ProfileHelper();
  // final EditProfileHelper editProfileHelper = EditProfileHelper();
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Stack(
        children: [
          SafeArea(
            top: false,
            child: Scaffold(
              backgroundColor: cWhiteColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kAppBarSize),
                //* info:: appBar
                child: CustomAppBar(
                  appBarColor: cWhiteColor,
                  title: ksEditProfile.tr,
                  hasBackButton: true,
                  isCenterTitle: true,
                  onBack: () {
                    Get.back();
                  },
                ),
              ),
              body: Obx(
                () => Stack(
                  children: [
                    Container(
                      color: cWhiteColor,
                      height: height - kAppBarSize,
                      width: width,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksProfilePicture.tr,
                                suffix: ksEdit.tr,
                                onEditPressed: () {
                                  kidHelper.kidProfilePicUploadBottomSheet(context);//!1
                                },
                              ),
                              kH10sizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // profileHelper.viewProfilePic();//!Change it
                                    },
                                    child: Container(
                                      height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                      width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                      decoration: const BoxDecoration(
                                        color: cBlackColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          profilePicture ?? '', //!Change it
                                          // profileController.userData.value!.profilePicture.toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => const Icon(
                                            BipHip.user,
                                            size: kIconSize70,
                                            color: cIconColor,
                                          ),
                                          loadingBuilder: imageLoadingBuilder,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kH16sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksCoverPhoto.tr,
                                suffix: ksEdit.tr,
                                onEditPressed: () {
                                  kidHelper.kidCoverPhotoUploadBottomSheet(context);//!2
                                },
                              ),
                              kH16sizedBox,
                              InkWell(
                                onTap: () {
                                  // profileHelper.viewCoverPhoto();//!Change it
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0, color: cLineColor),
                                    borderRadius: k8CircularBorderRadius,
                                    color: cBlackColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: k8CircularBorderRadius,
                                    child: Image.network(
                                      coverPhoto ?? '', //!Change throught api
                                      // profileController.userData.value!.coverPhoto.toString(),
                                      height: 150,
                                      width: width,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: width,
                                        height: 150,
                                        color: cBlackColor,
                                        child: const CommonImageErrorBuilder(
                                          icon: BipHip.imageFile,
                                          iconSize: kIconSize120,
                                        ),
                                      ),
                                      loadingBuilder: imageLoadingBuilderCover,
                                    ),
                                  ),
                                ),
                              ),
                              kH16sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksBio.tr,
                                suffix: kidsController.kidBio.value == null ? ksAdd : ksEdit.tr,
                                onEditPressed: () {
                                  // profileHelper.editBio();//!Must change it
                                  kidHelper.kidEditBio();
                                },
                              ),
                              // if (profileController.userData.value!.bio != null)//!change the condition
                              if (kidsController.kidBio.value != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: k16Padding),
                                  child: Text(
                                    // profileController.userData.value!.bio ?? '',//!Change it using api
                                    kidsController.kidBio.value ?? '', //!change
                                    style: regular14TextStyle(cIconColor),
                                  ),
                                ),
                              kH16sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksIntro.tr,
                                suffix: ksEdit.tr,
                                onEditPressed: () {
                                  // editProfileHelper.resetEditAboutPage();//!function write
                                  // profileController.showAllEditOption.value = false;//!Change
                                  Get.toNamed(krKidEditAboutInfo);
                                },
                              ),
                              kH16sizedBox,
                              // IntroContents(),
                              KidIntroContents(),
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              CustomElevatedButton(
                                label: ksEditYouAboutInfo.tr,
                                buttonHeight: h32,
                                buttonWidth: width - 40,
                                buttonColor: cPrimaryColor,
                                textStyle: semiBold14TextStyle(cWhiteColor),
                                onPressed: () async {
                                  // profileController.showAllEditOption.value = true;//!variable define
                                  // editProfileHelper.resetEditAboutPage();//!Function write
                                   Get.toNamed(krKidEditAboutInfo);
                                  // await profileController.getPositionList();//!Write this function
                                },
                              ),
                              kH20sizedBox
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 1,
                      child: CustomDivider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // if (profileController.isBioLoading.value == true)//!Condition required
            // Positioned(
            //   child: CommonLoadingAnimation(
            //     onWillPop: () async {
            //       if (profileController.isBioLoading.value) {
            //         return false;
            //       }
            //       return true;
            //     },
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}

class KidIntroContents extends StatelessWidget {
  KidIntroContents({super.key});
  // final ProfileController profileController = Get.find<ProfileController>();
  final KidsController kidsController = Get.find<KidsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (profileController.currentityData.value?.city != null && profileController.currentCityData.value?.isCurrent == 1)//!Condition must use in future
        KidStoreProfileLinkUpIconTextRow(
          iconOrSvg: const Icon(
            BipHip.info,
            size: kIconSize20,
            color: cPrimaryColor,
          ),
          prefixText: '${ksPage.tr} ',
          suffixText: ksKid.tr,
          onPressed: null,
        ),
        // if (profileController.hometownData.value != null)//!Condition must use in future
        KidStoreProfileLinkUpIconTextRow(
          iconOrSvg: SvgPicture.asset(kiParentSvgImageUrl),
          prefixText: 'Father',
          suffixText: 'Emma Isabella',
          onPressed: null,
        ),
        // if (profileController.profileData.value!.school != null)//!Condition must use in future
        //  for (int i = 0; i < profileController.schoolDataList.length; i++)
        const LinkUpIconTextRow(
          icon: BipHip.school,
          // suffixText: checkNullOrStringNull(profileController.schoolDataList[i].school),
          // prefixText: profileController.schoolDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
          // suffixText: checkNullOrStringNull(profileController.profileData.value!.school!.school),//!Change using api
          suffixText: "",
          prefixText: "Majedul islam model school",
          onPressed: null,
        ),
        // if (profileController.profileData.value!.college != null)//!Condition must use in future
        //  for (int i = 0; i < profileController.collegeDataList.length; i++)
        const LinkUpIconTextRow(
          icon: BipHip.mail,
          // suffixText: checkNullOrStringNull(profileController.profileData.value!.college!.school),//!Change it using api data
          suffixText: "",
          prefixText: "genie.kid@gmail.com",
          // suffixText: checkNullOrStringNull(profileController.collegeDataList[i].school),
          // prefixText: profileController.collegeDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
          onPressed: null,
        ),
        // if (profileController.currentWorkplace.value != null)//!Condition must use in future
        const LinkUpIconTextRow(
          icon: BipHip.phoneFill,
          // suffixText: checkNullOrStringNull(profileController.currentWorkplace.value!.company),
          suffixText: "",
          prefixText: "01763564354",
          // prefixText: profileController.currentWorkplace.value!.position == null ? '' : '${profileController.currentWorkplace.value!.position} at ',//!if needed use it in future
          onPressed: null,
        ),
      ],
    );
  }
}
