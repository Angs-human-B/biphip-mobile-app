import 'dart:io';
import 'dart:ui';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class AddKidUploadImage extends StatelessWidget {
  AddKidUploadImage({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();
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
                    title: ksAddKid.tr,
                    hasBackButton: false,
                    leadingWidth: 80,
                    leadingWidget: Center(
                      child: InkWell(
                        onTap: () {
                          unFocus(context);
                          Get.back();
                        },
                        child: Text(
                          ksPrevious.tr,
                          style: semiBold14TextStyle(cPrimaryColor),
                        ),
                      ),
                    ),
                    isCenterTitle: true,
                    onBack: null,
                  ),
                ),
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: height - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
                    child: Column(
                      children: [
                        const CustomDivider(
                          thickness: 1,
                        ),
                        KidTopTitleSubtitleAndCircularProgressBar(
                          title: ksUploadImages.tr,
                          subTitle: ksUploadProfileAndCoverPhoto.tr,
                          circularCenterText: ks4of4.tr,
                          percent: 1,
                        ),
                        kH16sizedBox,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: CustomDivider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => KidProfileAndCoverPhotoUpload(
                                  title: ksProfilePicture,
                                  subTitle: ksMaximumPhotoSize,
                                  profileCoverPhoto: kidsController.isKidProfileImageChanged.value ? kidsController.kidProfileImageFile.value : null,
                                  removePictureOnPressed: () {
                                    kidsController.resetKidProfilePictureData();
                                  },
                                  onPressed: () {
                                    unFocus(context);
                                    globalController.commonBottomSheet(
                                        context: context,
                                        onPressCloseButton: () {
                                          Get.back();
                                        },
                                        onPressRightButton: () {},
                                        rightText: '',
                                        rightTextStyle: regular14TextStyle(cBiddingColor),
                                        title: ksUploadPhoto.tr,
                                        isRightButtonShow: false,
                                        isScrollControlled: false,
                                        bottomSheetHeight: 180,
                                        content: ProfilePictureUploadContent());
                                  },
                                ),
                              ),
                              kH16sizedBox,
                              Obx(() => KidProfileAndCoverPhotoUpload(
                                    title: ksCoverPhoto,
                                    subTitle: ksMaximumPhotoSize,
                                    profileCoverPhoto: kidsController.isKidCoverImageChanged.value ? kidsController.kidCoverImageFile.value : null,
                                    removePictureOnPressed: () {
                                      kidsController.resetKidCoverPhotoData();
                                    },
                                    onPressed: () {
                                      unFocus(context);
                                      globalController.commonBottomSheet(
                                          context: context,
                                          onPressCloseButton: () {
                                            Get.back();
                                          },
                                          onPressRightButton: () {},
                                          rightText: '',
                                          rightTextStyle: regular14TextStyle(cBiddingColor),
                                          title: ksUploadPhoto.tr,
                                          isRightButtonShow: false,
                                          isScrollControlled: false,
                                          bottomSheetHeight: 180,
                                          content: KidCoverPhotoUploadContent());
                                    },
                                  )),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        CustomElevatedButton(
                          buttonWidth: width - 40,
                          buttonHeight: h40,
                          label: ksComplete.tr,
                          onPressed: () {
                            unFocus(context);
                            kidsController.addKid();
                          },
                          textStyle: semiBold16TextStyle(cWhiteColor),
                        ),
                        kH30sizedBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (kidsController.isAddKidLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (kidsController.isKidDeleteLoading.value) {
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

class KidProfileAndCoverPhotoUpload extends StatelessWidget {
  const KidProfileAndCoverPhotoUpload({
    super.key,
    required this.title,
    required this.subTitle,
    this.onPressed,
    this.profileCoverPhoto,
    this.removePictureOnPressed,
  });
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;
  final VoidCallback? removePictureOnPressed;
  final File? profileCoverPhoto;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: semiBold16TextStyle(cBlackColor),
        ),
        kH4sizedBox,
        Text(
          subTitle,
          style: regular14TextStyle(cSmallBodyTextColor),
        ),
        kH8sizedBox,
        if (profileCoverPhoto == null)
          InkWell(
            onTap: onPressed,
            child: Container(
              width: width - 40,
              height: 140,
              decoration: BoxDecoration(
                color: cInputFieldColor,
                borderRadius: BorderRadius.circular(k8BorderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    kiUploadImage,
                    height: 40,
                  ),
                  kH8sizedBox,
                  Text(
                    ksUploadImage,
                    style: semiBold16TextStyle(cPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
        if (profileCoverPhoto != null)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: Container(
                  width: width - 40,
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(
                            profileCoverPhoto!,
                          ),
                          fit: BoxFit.cover)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      width: width - 40,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(profileCoverPhoto!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: h20,
                    height: h20,
                    decoration: const BoxDecoration(
                      color: cRedColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: CustomIconButton(
                      onPress: removePictureOnPressed,
                      icon: BipHip.cross,
                      iconColor: cWhiteColor,
                      size: kIconSize14,
                    )),
                  )),
            ],
          ),
      ],
    );
  }
}

class ProfilePictureUploadContent extends StatelessWidget {
  ProfilePictureUploadContent({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                kidsController.isKidProfileImageChanged, kidsController.kidProfileImageLink, kidsController.kidProfileImageFile, 'camera', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CustomElevatedButton(
          label: ksChooseFromGallery.tr,
          prefixIcon: BipHip.photo,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                kidsController.isKidProfileImageChanged, kidsController.kidProfileImageLink, kidsController.kidProfileImageFile, 'gallery', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}

class KidCoverPhotoUploadContent extends StatelessWidget {
  KidCoverPhotoUploadContent({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                kidsController.isKidCoverImageChanged, kidsController.kidCoverImageLink, kidsController.kidCoverImageFile, 'camera', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CustomElevatedButton(
          label: ksChooseFromGallery.tr,
          prefixIcon: BipHip.photo,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                kidsController.isKidCoverImageChanged, kidsController.kidCoverImageLink, kidsController.kidCoverImageFile, 'gallery', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}
