import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/prfole_view_about_education_background.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_basic_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_contact_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_place_lived.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_relation_profession_interest_content.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_social_links.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_work.dart';

class ProfileViewAbout extends StatelessWidget {
  const ProfileViewAbout({super.key});

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
                ProfileViewAbotRelationProfessionInterestContent(
                  title: ksRelationshipStatus.tr,
                  subTitle: "Single",
                ),
                kH12sizedBox,
                ProfileViewAbotRelationProfessionInterestContent(
                  title: ksProfession.tr,
                  subTitle: "Programmer",
                ),
                kH12sizedBox,
                ProfileViewAbotRelationProfessionInterestContent(
                  title: ksInterest.tr,
                  subTitle: "Photography",
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