import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/prfole_view_about_education_background.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_basic_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_contact_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_place_lived.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_relation_profession_interest_content.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_social_links.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_work.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_kid_and_store_page_transperency.dart';

class ProfileViewAbout extends StatelessWidget {
  ProfileViewAbout({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksAbout.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const ProileViewAboutPlaceLived(),
                kH12sizedBox,
                const ProileViewAboutBasicInfo(),
                kH12sizedBox,
                const ProileViewAboutContactInfo(),
                if (profileViewController.isKidOrStoreProfile.value) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value == false) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value == false)
                  ProfileViewAbotRelationProfessionInterestContent(
                    title: ksRelationshipStatus.tr,
                    subTitle: "Single",
                  ),
                if (profileViewController.isKidOrStoreProfile.value == false) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value == false)
                  ProfileViewAbotRelationProfessionInterestContent(
                    title: ksProfession.tr,
                    subTitle: "Programmer",
                  ),
                if (profileViewController.isKidOrStoreProfile.value == false) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value == false)
                  ProfileViewAbotRelationProfessionInterestContent(
                    title: ksInterest.tr,
                    subTitle: "Photography",
                  ),
                if (profileViewController.isKidOrStoreProfile.value == false) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value == false) const ProileViewAboutEducationBackground(),
                if (profileViewController.isKidOrStoreProfile.value == false) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value == false) const ProileViewAboutWork(),
                if (profileViewController.isKidOrStoreProfile.value == false) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value == false) const ProileViewAboutSocialLinks(),
                if (profileViewController.isKidOrStoreProfile.value) kH12sizedBox,
                if (profileViewController.isKidOrStoreProfile.value)
                  ProfileViewKidAndStorePageTransperency(
                    pageId: Get.find<KidsController>().kidsData.value?.pageId,
                    dateTimeValue: Get.find<KidsController>().kidsData.value?.createdAt ?? DateTime.now(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
