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
                            prefix: 'Profile picture',
                            suffix: 'Edit',
                            onEditPressed: () {
                              _globalController.commonBottomSheet(
                                context: context,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {},
                                rightText: '',
                                rightTextStyle: regular14TextStyle(cBiddingColor),
                                title: 'Edit photo',
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
                                height: height > kSmallDeviceSizeLimit ? kProfileImageSize : (kProfileImageSize - h10),
                                width: height > kSmallDeviceSizeLimit ? kProfileImageSize : (kProfileImageSize - h10),
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(110),
                                ),
                                child: ClipOval(
                                  child: Image.file(
                                    _profileController.profileImageFile.value,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => ClipOval(
                                      child: Image.asset(
                                        'assets/images/profileDefault.png',
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
                            prefix: 'Cover photo',
                            suffix: 'Edit',
                            onEditPressed: () {
                              _globalController.commonBottomSheet(
                                  context: context,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: () {},
                                  rightText: '',
                                  rightTextStyle: regular14TextStyle(cBiddingColor),
                                  title: 'Edit photo',
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
                              child: Image.file(
                                _profileController.coverImageFile.value,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  'assets/images/coverPic.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          kH16sizedBox,
                          const CustomDivider(),
                          kH16sizedBox,
                          RowTextEdit(
                            prefix: 'Bio',
                            suffix: _profileController.bio.value == '' ? 'Add' : 'Edit',
                            onEditPressed: () {
                              _globalController.commonBottomSheet(
                                  context: context,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: () {},
                                  rightText: '',
                                  rightTextStyle: regular14TextStyle(cBiddingColor),
                                  title: 'Edit Bio',
                                  isRightButtonShow: false,
                                  isScrollControlled: false,
                                  bottomSheetHeight: 190,
                                  content: const EditBioModalSheet());
                            },
                          ),
                          if (_profileController.bio.value != '') kH16sizedBox,
                          Text(
                            _profileController.bio.value,
                            style: regular14TextStyle(cIconColor),
                          ),
                          if (_profileController.bio.value != '') kH16sizedBox,
                          const CustomDivider(),
                          kH16sizedBox,
                          RowTextEdit(
                            prefix: 'Intro',
                            suffix: 'Edit',
                            onEditPressed: () {},
                          ),
                          kH16sizedBox,
                          for (int i = 0; i < editProfileInfoContent.length; i++)
                            LinkUpIconTextRow(
                              icon: profileInfoContent[i]['icon'],
                              text: profileInfoContent[i]['text'],
                              isLink: profileInfoContent[i]['isLink'],
                            ),
                          const CustomDivider(),
                          kH16sizedBox,
                          CustomElevatedButton(
                            label: 'Edit your about info',
                            buttonHeight: h28,
                            buttonWidth: width - 40,
                            buttonColor: cLineColor,
                            textStyle: semiBold12TextStyle(cBlackColor),
                            onPressed: () {},
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
            Get.toNamed(krEditBio);
          },
          label: 'Edit bio',
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
          label: 'Remove bio',
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
