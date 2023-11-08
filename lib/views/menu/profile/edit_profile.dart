import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/helpers/profile_helpers/profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/profile_widgets/profile_post_tab.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorBuilder.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final ProfileHelper _profileHelper = ProfileHelper();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
                                    _profileHelper.profilePicUploadBottomSheet(context);
                                  },
                                ),
                                kH10sizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _profileHelper.viewProfilePic();
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
                                            Environment.imageBaseUrl + _profileController.userData.value!.profilePicture.toString(),
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
                                    _profileHelper.coverPhotoUploadBottomSheet(context);
                                  },
                                ),
                                kH16sizedBox,
                                InkWell(
                                  onTap: () {
                                    _profileHelper.viewCoverPhoto();
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
                                        Environment.imageBaseUrl + _profileController.userData.value!.coverPhoto.toString(),
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
                                  suffix: _profileController.userData.value!.bio == null ? ksAdd.tr : ksEdit.tr,
                                  onEditPressed: () {
                                    _profileHelper.editBio();
                                  },
                                ),
                                if (_profileController.userData.value!.bio != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: k16Padding),
                                    child: Text(
                                      _profileController.userData.value!.bio ?? '',
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
                                    _editProfileHelper.resetEditAboutPage();
                                    _profileController.showAllEditOption.value = false;
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
                                    _profileController.showAllEditOption.value = true;
                                    _editProfileHelper.resetEditAboutPage();
                                    Get.toNamed(krEditAboutInfo);
                                    await _profileController.getPositionList();
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
              if (_profileController.isBioLoading.value == true)
                Positioned(
                  child: CommonLoadingAnimation(
                    onWillPop: () async {
                      if (_profileController.isBioLoading.value) {
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
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_profileController.currentCityData.value?.city != null && _profileController.currentCityData.value?.isCurrent == 1)
          LinkUpIconTextRow(
            icon: BipHip.address,
            prefixText: '${ksLivesIn.tr} ',
            suffixText: '${_profileController.currentCityData.value?.city}',
            onPressed: null,
          ),
        if (_profileController.hometownData.value != null)
          LinkUpIconTextRow(
            icon: BipHip.location,
            prefixText: '${ksFrom.tr} ',
            suffixText: '${_profileController.hometownData.value?.city}',
            onPressed: null,
          ),
        if (_profileController.userData.value!.relation != null)
          LinkUpIconTextRow(
            icon: BipHip.love,
            suffixText: checkNullOrStringNull(_profileController.userData.value!.relation),
            prefixText: '',
            onPressed: null,
          ),
        if (_profileController.schoolDataList.isNotEmpty)
          LinkUpIconTextRow(
            icon: BipHip.school,
            suffixText: checkNullOrStringNull(_profileController.schoolDataList[0].school),
            prefixText: _profileController.schoolDataList[0].ended != null ? '${ksStudiedAt.tr} ' : '${ksStudiesAt.tr} ',
            onPressed: null,
          ),
        if (_profileController.collegeDataList.isNotEmpty)
          LinkUpIconTextRow(
            icon: BipHip.school,
            suffixText: checkNullOrStringNull(_profileController.collegeDataList[0].school),
            prefixText: _profileController.collegeDataList[0].ended != null ? '${ksStudiedAt.tr} ' : '${ksStudiesAt.tr} ',
            onPressed: null,
          ),
        if (_profileController.currentWorkplace.value != null)
          LinkUpIconTextRow(
            icon: BipHip.work,
            suffixText: checkNullOrStringNull(_profileController.currentWorkplace.value!.company),
            prefixText: _profileController.currentWorkplace.value!.position == null ? '' : '${_profileController.currentWorkplace.value!.position} at ',
            onPressed: null,
          ),
      ],
    );
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
