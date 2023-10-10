import 'package:bip_hip/controllers/profile_controller.dart';
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
      child: SafeArea(
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
                    child: Obx(
                      () => Column(
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
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(110),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    Environment.imageBaseUrl + _profileController.profileData.value!.user!.profilePicture.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => ClipOval(
                                      child: Image.asset(
                                        kiProfileDefaultImageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
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
                                  ));
                            },
                          ),
                          kH16sizedBox,
                          ClipRRect(
                            borderRadius: k12CircularBorderRadius,
                            child: SizedBox(
                              height: 150,
                              width: width,
                              child: Image.network(
                                Environment.imageBaseUrl + _profileController.profileData.value!.user!.coverPhoto.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  kiCoverPicImageUrl,
                                  fit: BoxFit.cover,
                                ),
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
                                Get.toNamed(krEditBio);
                              } else {
                                _globalController.commonBottomSheet(
                                    context: context,
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: () {},
                                    rightText: '',
                                    rightTextStyle: regular14TextStyle(cBiddingColor),
                                    title: ksEditBio.tr,
                                    isRightButtonShow: false,
                                    isScrollControlled: false,
                                    bottomSheetHeight: 190,
                                    content: const EditBioModalSheet());
                              }
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
                            onEditPressed: () {},
                          ),
                          kH16sizedBox,
                          // for (int i = 0; i < editProfileInfoContent.length; i++)
                          //   LinkUpIconTextRow(
                          //     icon: profileInfoContent[i]['icon'],
                          //     text: profileInfoContent[i]['text'],
                          //     isLink: profileInfoContent[i]['isLink'],
                          //   ),
                          if (_profileController.profileData.value!.currentCity != null && _profileController.profileData.value!.currentCity!.isCurrent == 1)
                            LinkUpIconTextRow(
                              icon: BipHip.address,
                              text: 'Lives in ${_profileController.profileData.value!.currentCity!.city}',
                              isLink: false,
                              onPressed: null,
                            ),
                          if (_profileController.profileData.value!.hometown != null)
                            LinkUpIconTextRow(
                              icon: BipHip.location,
                              text: 'From ${_profileController.profileData.value!.hometown!.city}',
                              isLink: false,
                              onPressed: null,
                            ),
                          if (_profileController.profileData.value!.user!.relation != null)
                            LinkUpIconTextRow(
                              icon: BipHip.love,
                              text: checkNullOrStringNull(_profileController.profileData.value!.user!.relation),
                              isLink: false,
                              onPressed: null,
                            ),
                          if (_profileController.profileData.value!.school.isNotEmpty)
                            LinkUpIconTextRow(
                              icon: BipHip.school,
                              text: checkNullOrStringNull(_profileController.profileData.value!.school[0].school),
                              isLink: false,
                              onPressed: null,
                            ),
                          if (_profileController.profileData.value!.college.isNotEmpty)
                            LinkUpIconTextRow(
                              icon: BipHip.school,
                              text: checkNullOrStringNull(_profileController.profileData.value!.college[0].school),
                              isLink: false,
                              onPressed: null,
                            ),
                          if (_profileController.profileData.value!.currentWorkplace != null)
                            LinkUpIconTextRow(
                              icon: BipHip.work,
                              text: checkNullOrStringNull(_profileController.profileData.value!.currentWorkplace!.company),
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
                            onPressed: () {
                              Get.toNamed(krEditAboutInfo);
                            },
                          ),
                          kH20sizedBox
                        ],
                      ),
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
    );
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
          style: semiBold14TextStyle(cBlackColor),
        ),
        TextButton(
          style: kTextButtonStyle,
          onPressed: onEditPressed,
          child: Text(
            suffix,
            style: regular12TextStyle(cPrimaryColor),
          ),
        ),
      ],
    );
  }
}

class EditBioModalSheet extends StatelessWidget {
  const EditBioModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          onPressed: () {
            Get.find<ProfileController>().bioEditingController.text = Get.find<ProfileController>().userData.value!.bio!;
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
          onPressed: () {},
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
