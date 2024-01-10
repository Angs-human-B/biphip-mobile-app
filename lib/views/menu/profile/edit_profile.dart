import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/helpers/profile/profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_post_tab.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorBuilder.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final ProfileHelper profileHelper = ProfileHelper();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: cWhiteColor,
        child: Obx(
          () => Stack(
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
                  body: Stack(
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
                                    profileHelper.profilePicUploadBottomSheet(context);
                                  },
                                ),
                                kH10sizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        profileHelper.viewProfilePic();
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
                                            profileController.userData.value!.profilePicture.toString(),
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
                                    profileHelper.coverPhotoUploadBottomSheet(context);
                                  },
                                ),
                                kH16sizedBox,
                                InkWell(
                                  onTap: () {
                                    profileHelper.viewCoverPhoto();
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
                                        profileController.userData.value!.coverPhoto.toString(),
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
                                  suffix: profileController.userData.value!.bio == null ? ksAdd.tr : ksEdit.tr,
                                  onEditPressed: () {
                                    profileHelper.editBio();
                                  },
                                ),
                                if (profileController.userData.value!.bio != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: k16Padding),
                                    child: Text(
                                      profileController.userData.value!.bio ?? '',
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
                                    editProfileHelper.resetEditAboutPage();
                                    profileController.showAllEditOption.value = false;
                                    Get.toNamed(krEditAboutInfo);
                                  },
                                ),
                                kH16sizedBox,
                                IntroContents(),
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
                                    profileController.showAllEditOption.value = true;
                                    editProfileHelper.resetEditAboutPage();
                                    Get.toNamed(krEditAboutInfo);
                                    // await profileController.getPositionList();
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
              if (profileController.isBioLoading.value == true)
                Positioned(
                  child: CommonLoadingAnimation(
                    onWillPop: () async {
                      if (profileController.isBioLoading.value) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
            ],
          ),
        ));
  }
}

class IntroContents extends StatelessWidget {
  IntroContents({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            if (profileController.currentCityData.value?.city != null && profileController.currentCityData.value?.isCurrent == 1)
              LinkUpIconTextRow(
                icon: BipHip.address,
                prefixText: '${ksLivesIn.tr} ',
                suffixText: '${profileController.currentCityData.value?.city}',
                onPressed: null,
              ),
            if (profileController.hometownData.value != null)
              LinkUpIconTextRow(
                icon: BipHip.location,
                prefixText: '${ksFrom.tr} ',
                suffixText: '${profileController.hometownData.value?.city}',
                onPressed: null,
              ),
            if (profileController.userData.value!.relation != null)
              LinkUpIconTextRow(
                icon: BipHip.love,
                suffixText: checkNullOrStringNull(profileController.userData.value!.relation),
                prefixText: '',
                onPressed: null,
              ),
            // if (profileController.profileData.value!.school != null)
            for (int i = 0; i < profileController.schoolDataList.length; i++)
              LinkUpIconTextRow(
                icon: BipHip.school,
                suffixText: checkNullOrStringNull(profileController.schoolDataList[i].school),
                prefixText: profileController.schoolDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
                // suffixText: checkNullOrStringNull(profileController.profileData.value!.school!.school),
                // prefixText: profileController.profileData.value!.school!.graduated == 1 ? '${ksStudiedAt.tr} ' : '${ksStudiesAt.tr} ',

                onPressed: null,
              ),
            // if (profileController.profileData.value!.college != null)
            for (int i = 0; i < profileController.collegeDataList.length; i++)
              LinkUpIconTextRow(
                icon: BipHip.school,
                // suffixText: checkNullOrStringNull(profileController.profileData.value!.college!.school),
                // prefixText: profileController.profileData.value!.college!.graduated == 1 ? '${ksStudiedAt.tr} ' : '${ksStudiesAt.tr} ',
                suffixText: checkNullOrStringNull(profileController.collegeDataList[i].school),
                prefixText: profileController.collegeDataList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
                onPressed: null,
              ),
            if (profileController.currentWorkplace.value != null)
              LinkUpIconTextRow(
                icon: BipHip.work,
                suffixText: checkNullOrStringNull(profileController.currentWorkplace.value!.company),
                prefixText: profileController.currentWorkplace.value!.position == null ? '' : '${profileController.currentWorkplace.value!.position} at ',
                onPressed: null,
              ),
          ],
        ));
  }
}

class RowTextEdit extends StatelessWidget {
  const RowTextEdit({super.key, required this.prefix, this.onEditPressed, required this.suffix});

  final String prefix;
  final String suffix;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          prefix,
          style: semiBold18TextStyle(cBlackColor),
        ),
        TextButton(
          style: kTextButtonStyle,
          onPressed: onEditPressed,
          child: Text(
            suffix,
            style: semiBold16TextStyle(cPrimaryColor),
          ),
        ),
      ],
    );
  }
}
