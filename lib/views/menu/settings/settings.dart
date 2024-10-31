

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../controllers/menu/menu_section_controller.dart';
import '../../../controllers/menu/profile_controller.dart';
import '../../../helpers/profile/profile_helper.dart';
import '../../../shimmers/settings/settings_shimmer.dart';
import '../../../utils/constants/imports.dart';
import '../menu.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final MenuSectionController menuController =
      Get.find<MenuSectionController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();
  final ProfileHelper profileHelper = ProfileHelper();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () =>  profileController.isProfileLoading.value
            ? const SettingsShimmerPage()
            : Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: ksSettings.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        Text(
                          ksAccountsCenter.tr,
                          style: semiBold20TextStyle(cBlackColor),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          ksAccountsCenterDetails.tr,
                          style: regular14TextStyle(cPlaceHolderColor2),
                        ),
                        SizedBox(height: 10.h),
                        CustomMenuContainer(
                          text: ksProfile.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.user, color: cIconColor),
                          onPressed: ()  {
                            Get.toNamed(krEditProfile);
                          },
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksPersonalDetails.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.termsCondition,
                              color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksPasswordAndSecurity.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.lock, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksVerification.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                              const Icon(BipHip.starFill, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          ksToolsAndResources.tr,
                          style: semiBold20TextStyle(cBlackColor),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          ksToolsAndResourcesDetails.tr,
                          style: regular14TextStyle(cPlaceHolderColor2),
                        ),
                        SizedBox(height: 10.h),
                        CustomMenuContainer(
                          text: ksDefaultAudienceSettings.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.removeFamily,
                              color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          ksPreferences.tr,
                          style: semiBold20TextStyle(cBlackColor),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          ksPreferencesDetails.tr,
                          style: regular14TextStyle(cPlaceHolderColor2),
                        ),
                        SizedBox(height: 10.h),
                        CustomMenuContainer(
                          text: ksReactionPreferences.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.user, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksNotifications.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.notificationOutline,
                              color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksLanguageAndRegion.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                              const Icon(BipHip.language, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksDarkMode.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                              const Icon(BipHip.darkMode, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          ksAudienceAndVisibility.tr,
                          style: semiBold20TextStyle(cBlackColor),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          ksAudienceAndVisibilityDetails.tr,
                          style: regular14TextStyle(cPlaceHolderColor2),
                        ),
                        SizedBox(height: 10.h),
                        CustomMenuContainer(
                          text: ksProfileDetails.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.info, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksHowPeopleWillFindYou.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                              const Icon(BipHip.addFamily, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksPosts.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                              const Icon(BipHip.starFill, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksSelfies.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                              const Icon(BipHip.selfieNew, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksPolls.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                          const Icon(BipHip.starFill, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksFollowers.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                          const Icon(BipHip.follow, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksProfileAndTagging.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                          const Icon(BipHip.tagFriends, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksBlocking.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading:
                          const Icon(BipHip.lock, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          ksPayments.tr,
                          style: semiBold20TextStyle(cBlackColor),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          ksPaymentsDetails.tr,
                          style: regular14TextStyle(cPlaceHolderColor2),
                        ),
                        SizedBox(height: 10.h),
                        CustomMenuContainer(
                          text: ksAdsPayments.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.earnings,
                              color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          ksYourActivity.tr,
                          style: semiBold20TextStyle(cBlackColor),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          ksYourActivityDetails.tr,
                          style: regular14TextStyle(cPlaceHolderColor2),
                        ),
                        SizedBox(height: 10.h),
                        CustomMenuContainer(
                          text: ksActivityLog.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.activity, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),

                        CustomMenuContainer(
                          text: ksTrash.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.delete, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksArchive.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.withdraw, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksReviewPostsYouTaggedIn.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.tagFriends, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 22.h),
                        Text(
                          ksCommunityStandardAndLegalPolicy.tr,
                          style: semiBold20TextStyle(cBlackColor),
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksTermsOfService.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.termsCondition, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksPrivacyPolicy.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.info, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksCookiesPolicy.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.starFill, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 12.h),
                        CustomMenuContainer(
                          text: ksCommunityStandard.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                          height: 70.h,
                          leading: const Icon(BipHip.profession, color: cIconColor),
                          onPressed: () {},
                        ),
                        SizedBox(height: 22.h),

                        CustomMenuContainer(
                          height: 48,
                          trailing: const Icon(
                            BipHip.downArrow,
                            color: cIconColor,
                          ),
                          onPressed: () {
                            menuController.firstNameEditingController.text =
                                globalController.userFirstName.value ?? '';
                            menuController.lastNameEditingController.text =
                                globalController.userLastName.value ?? '';
                            menuController
                                .changeNameBottomSheetButtonState.value = false;
                            globalController.commonBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                isBottomSheetRightButtonActive: menuController
                                    .changeNameBottomSheetButtonState,
                                content: ChangeNameBottomSheetContent(
                                  menuController: menuController,
                                ),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () async {
                                  menuController.changeNameBottomSheetButtonState
                                      .value = false;
                                  unfocus(context);
                                  Get.back();
                                  await menuController.changeName();
                                },
                                rightText: ksDone.tr,
                                rightTextStyle: medium14TextStyle(cPrimaryColor),
                                title: ksChangeName.tr,
                                isRightButtonShow: true);
                          },
                          text: ksChangeName.tr,
                          textStyle: semiBold16TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (menuController.isChangeNameLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (menuController.isChangeNameLoading.value) {
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

class ChangeNameBottomSheetContent extends StatelessWidget {
  const ChangeNameBottomSheetContent({super.key, required this.menuController});
  final MenuSectionController menuController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ksFirstName.tr,
          style: medium16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
          controller: menuController.firstNameEditingController,
          hint: ksFirstName.tr,
          onChanged: (v) {
            menuController.checkCanChangeName();
          },
        ),
        Text(
          ksLastName.tr,
          style: medium16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
          controller: menuController.lastNameEditingController,
          hint: ksLastName.tr,
          onChanged: (v) {
            menuController.checkCanChangeName();
          },
        ),
        kH8sizedBox,
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: ksNameChangeWarning.tr,
              style: regular12TextStyle(cBlackColor)),
          TextSpan(
              text: ' ${ksLearnMoreAboutStars.tr}',
              style: regular12TextStyle(cPrimaryColor))
        ]))
      ],
    );
  }
}
