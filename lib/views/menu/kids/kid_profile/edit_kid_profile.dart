import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_post_tab.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorbuilder.dart';
import 'package:flutter_svg/svg.dart';

class EditKidProfile extends StatelessWidget {
  EditKidProfile({
    super.key,
  });
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();
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
                                  kidHelper.kidProfilePicUploadBottomSheet(context); 
                                },
                              ),
                              kH12sizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      kidHelper.viewKidProfilePic();
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
                                          kidsController.kidOverviewData.value?.kids?.profilePicture ?? '',
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
                              kH20sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksCoverPhoto.tr,
                                suffix: ksEdit.tr,
                                onEditPressed: () {
                                  kidHelper.kidCoverPhotoUploadBottomSheet(context);
                                },
                              ),
                              kH12sizedBox,
                              InkWell(
                                onTap: () {
                                  kidHelper.viewKidCoverPhoto();
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
                                      kidsController.kidOverviewData.value?.kids?.coverPhoto ?? '',
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
                              kH20sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksBio.tr,
                                suffix: kidsController.kidBio.value == null ? ksAdd : ksEdit.tr,
                                onEditPressed: () {
                                  kidHelper.kidEditBio();
                                },
                              ),
                              if (kidsController.kidBio.value != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: k16Padding),
                                  child: Text(
                                    kidsController.kidBio.value ?? '', 
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
                                onEditPressed: () async{
                                  await kidsController.getKidAllSchoolList();
                                  await kidsController.getKidContacts();
                                  Get.toNamed(krKidEditAboutInfo);
                                },
                              ),
                              kH16sizedBox,
                              KidIntroContents(),
                              kH16sizedBox,
                              CustomElevatedButton(
                                label: ksEditYouAboutInfo.tr,
                                buttonHeight: h32,
                                buttonWidth: width - 40,
                                buttonColor: cPrimaryColor,
                                textStyle: semiBold14TextStyle(cWhiteColor),
                                onPressed: () async {
                                  await kidsController.getKidAllSchoolList();
                                   await kidsController.getKidContacts();
                                  Get.toNamed(krKidEditAboutInfo);
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
          ],
        ),
      ),
    );
  }
}

class KidIntroContents extends StatelessWidget {
  KidIntroContents({super.key});
  final KidsController kidsController = Get.find<KidsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KidStoreProfileLinkUpIconTextRow(
          iconOrSvg: const Icon(
            BipHip.info,
            size: kIconSize20,
            color: cPrimaryColor,
          ),
          prefixText: ksPage.tr,
          suffixText: kidsController.kidOverviewData.value?.kids?.pageType ?? ksNA,
          onPressed: null,
        ),
        KidStoreProfileLinkUpIconTextRow(
          iconOrSvg: SvgPicture.asset(kiParentSvgImageUrl),
          prefixText: kidsController.kidOverviewData.value?.kids?.relation ?? ksNA,
          suffixText: kidsController.kidOverviewData.value?.parent?.fullName ?? ksNA,
          onPressed: null,
        ),
        LinkUpIconTextRow(
          icon: BipHip.school,
          suffixText: "",
          prefixText: kidsController.kidOverviewData.value?.school ?? ksNA,
          onPressed: null,
        ),
        LinkUpIconTextRow(
          icon: BipHip.mail,
          suffixText: "",
          prefixText: kidsController.kidOverviewData.value?.email ?? ksNA,
          onPressed: null,
        ),
        LinkUpIconTextRow(
          icon: BipHip.phoneFill,
          suffixText: "",
          prefixText: kidsController.kidOverviewData.value?.phone ?? ksNA,
          onPressed: null,
        ),
      ],
    );
  }
}
