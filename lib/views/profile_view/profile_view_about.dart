import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/prfole_view_about_education_background.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_basic_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_contact_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_place_lived.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_relation_profession_interest_content.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_social_links.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_work.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_interest_widget.dart';

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
                if (profileViewController.userProfileData.value!.relation != null)
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: ProfileViewAbotRelationProfessionInterestContent(
                      title: ksRelationshipStatus.tr,
                      subTitle: profileViewController.userProfileData.value?.relation ?? ksNA.tr,
                    ),
                  ),
                if (profileViewController.userProfileData.value!.profession.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: ProfileViewAbotRelationProfessionInterestContent(
                      title: ksProfession.tr,
                      subTitle: profileViewController.userProfileData.value?.profession[0],
                    ),
                  ),
                if (profileViewController.userProfileData.value!.interest.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: ProfileViewAbotInterestContent(
                      title: ksInterest.tr,
                      subTitle: profileViewController.userProfileData.value!.interest,
                    ),
                  ),
                kH12sizedBox,
                const ProileViewAboutEducationBackground(),
                kH12sizedBox,
                const ProileViewAboutWork(),
                kH12sizedBox,
                const ProileViewAboutContactInfo(),
                kH12sizedBox,
                const ProileViewAboutSocialLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
