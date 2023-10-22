import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/profile.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
                                    _profileController.isProfilePicEditor.value = true;

                                    _globalController.commonBottomSheet(
                                      context: context,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {},
                                      rightText: '',
                                      rightTextStyle: regular14TextStyle(cBiddingColor),
                                      title: ksEditPhoto.tr,
                                      isRightButtonShow: false,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 180,
                                      content: PictureUploadContent(
                                        isImageChanged: _profileController.isProfileImageChanged,
                                        imagePath: _profileController.profileImageLink,
                                        imageFile: _profileController.profileImageFile,
                                      ),
                                    );
                                  },
                                ),
                                kH10sizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
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
                                  ],
                                ),
                                kH16sizedBox,
                                const CustomDivider(),
                                kH16sizedBox,
                                RowTextEdit(
                                  prefix: ksCoverPhoto.tr,
                                  suffix: ksEdit.tr,
                                  onEditPressed: () {
                                    _profileController.isProfilePicEditor.value = false;

                                    _globalController.commonBottomSheet(
                                      context: context,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {},
                                      rightText: '',
                                      rightTextStyle: regular14TextStyle(cBiddingColor),
                                      title: ksEditPhoto.tr,
                                      isRightButtonShow: false,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 180,
                                      content: PictureUploadContent(
                                        isImageChanged: _profileController.isCoverImageChanged,
                                        imagePath: _profileController.coverImageLink,
                                        imageFile: _profileController.coverImageFile,
                                      ),
                                    );
                                  },
                                ),
                                kH16sizedBox,
                                Container(
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
                                      // color: cBlackColor,
                                      width: width,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: width,
                                        height: 150,
                                        color: cBlackColor,
                                        child: const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize120,
                                          color: cIconColor,
                                        ),
                                      ),
                                      loadingBuilder: imageLoadingBuilderCover,
                                    ),
                                  ),
                                ),
                                kH16sizedBox,
                                const CustomDivider(),
                                kH16sizedBox,
                                RowTextEdit(
                                  prefix: ksBio.tr,
                                  suffix: _profileController.userData.value!.bio == null ? ksAdd.tr : ksEdit.tr,
                                  onEditPressed: () {
                                    if (_profileController.userData.value!.bio == null) {
                                      _profileController.bioCount.value = 0;
                                      _profileController.bioEditingController.text = '';
                                      _profileController.bio.value = '';
                                    } else {
                                      _profileController.bio.value = _profileController.userData.value!.bio!;
                                      _profileController.bioCount.value = _profileController.userData.value!.bio.toString().length;
                                      _profileController.bioEditingController.text = _profileController.userData.value!.bio!;
                                    }
                                    Get.toNamed(krEditBio);
                                    // else {
                                    //   _globalController.commonBottomSheet(
                                    //       context: context,
                                    //       onPressCloseButton: () {
                                    //         Get.back();
                                    //       },
                                    //       onPressRightButton: () {},
                                    //       rightText: '',
                                    //       rightTextStyle: regular14TextStyle(cBiddingColor),
                                    //       title: ksEditBio.tr,
                                    //       isRightButtonShow: false,
                                    //       isScrollControlled: false,
                                    //       bottomSheetHeight: 190,
                                    //       content: EditBioModalSheet(
                                    //         profileController: _profileController,
                                    //       ));
                                    // }
                                  },
                                ),
                                if (_profileController.userData.value!.bio != null) kH16sizedBox,
                                Text(
                                  _profileController.userData.value!.bio ?? '',
                                  style: regular14TextStyle(cIconColor),
                                ),
                                if (_profileController.userData.value!.bio != null) kH16sizedBox,
                                const CustomDivider(),
                                kH16sizedBox,
                                RowTextEdit(
                                  prefix: ksIntro.tr,
                                  suffix: ksEdit.tr,
                                  onEditPressed: () {
                                    _profileController.resetEditAboutPage();
                                    _profileController.showAllEditOption.value = false;
                                    Get.toNamed(krEditAboutInfo);
                                  },
                                ),
                                kH16sizedBox,
                                // for (int i = 0; i < editProfileInfoContent.length; i++)
                                //   LinkUpIconTextRow(
                                //     icon: profileInfoContent[i]['icon'],
                                //     text: profileInfoContent[i]['text'],
                                //     isLink: profileInfoContent[i]['isLink'],
                                //   ),
                                if (_profileController.currentCityData.value?.city != null && _profileController.currentCityData.value?.isCurrent == 1)
                                  LinkUpIconTextRow(
                                    icon: BipHip.address,
                                    prefixText: 'Lives in ',
                                    suffixText: '${_profileController.currentCityData.value?.city}',
                                    isLink: false,
                                    onPressed: null,
                                  ),
                                if (_profileController.hometownData.value != null)
                                  LinkUpIconTextRow(
                                    icon: BipHip.location,
                                    prefixText: 'From ',
                                    suffixText: '${_profileController.hometownData.value?.city}',
                                    isLink: false,
                                    onPressed: null,
                                  ),
                                if (_profileController.userData.value!.relation != null)
                                  LinkUpIconTextRow(
                                    icon: BipHip.love,
                                    suffixText: '',
                                    prefixText: checkNullOrStringNull(_profileController.userData.value!.relation),
                                    isLink: false,
                                    onPressed: null,
                                  ),
                                if (_profileController.schoolDataList.isNotEmpty)
                                  LinkUpIconTextRow(
                                    icon: BipHip.school,
                                    suffixText: '',
                                    prefixText: checkNullOrStringNull(_profileController.schoolDataList[0].school),
                                    isLink: false,
                                    onPressed: null,
                                  ),
                                if (_profileController.collegeDataList.isNotEmpty)
                                  LinkUpIconTextRow(
                                    icon: BipHip.school,
                                    suffixText: '',
                                    prefixText: checkNullOrStringNull(_profileController.collegeDataList[0].school),
                                    isLink: false,
                                    onPressed: null,
                                  ),
                                if (_profileController.workplaceDataList.isNotEmpty)
                                  LinkUpIconTextRow(
                                    icon: BipHip.work,
                                    suffixText: '',
                                    prefixText: checkNullOrStringNull(_profileController.workplaceDataList[0].company),
                                    isLink: false,
                                    onPressed: null,
                                  ),
                                const CustomDivider(),
                                kH16sizedBox,
                                CustomElevatedButton(
                                  label: ksEditYouAboutInfo.tr,
                                  buttonHeight: h28,
                                  buttonWidth: width - 40,
                                  buttonColor: cLineColor,
                                  textStyle: semiBold12TextStyle(cBlackColor),
                                  onPressed: () async {
                                    _profileController.showAllEditOption.value = true;
                                    _profileController.resetEditAboutPage();
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
                        top: 0,
                        child: CustomDivider(),
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

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: const Divider(
        thickness: 1,
        height: 1,
        color: cLineColor,
      ),
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

class EditBioModalSheet extends StatelessWidget {
  const EditBioModalSheet({super.key, required this.profileController});
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          onPressed: () {
            Get.back();
            profileController.bioEditingController.text = profileController.userData.value!.bio!;
            Get.toNamed(krEditBio);
          },
          label: ksEditBio.tr,
          buttonColor: cWhiteColor,
          borderColor: cBlackColor,
          buttonWidth: width - 40,
          textStyle: semiBold14TextStyle(cBlackColor),
          prefixIcon: BipHip.edit,
          prefixIconColor: cBlackColor,
        ),
        kH12sizedBox,
        CustomElevatedButton(
          onPressed: () async {
            Get.back();
            profileController.bioEditingController.text = '';
            await profileController.updateBio(false);
          },
          label: ksRemoveBio.tr,
          buttonColor: cWhiteColor,
          borderColor: cBlackColor,
          buttonWidth: width - 40,
          textStyle: semiBold14TextStyle(cBlackColor),
          prefixIcon: BipHip.delete,
          prefixIconColor: cBlackColor,
        ),
      ],
    );
  }
}
