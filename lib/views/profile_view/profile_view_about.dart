import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/prfole_view_about_education_background.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_basic_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_contact_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_relation_profession_interest_content.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_social_links.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_work.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_interest_widget.dart';
import 'package:intl/intl.dart';

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
                //  ProileViewAboutPlaceLived(
                //   homeTown: profileViewController.profileViewHometownData!,
                //  ),

                // ProileViewAboutPlaceLived(
                //   homeTown: profileViewController.profileViewHometownData.value,
                //   currentCity: profileViewController.profileViewCurrentCityData.value,
                //   placesList: profileViewController.profileViewPlacesList.value,
                // ),
                kH12sizedBox,
                ProileViewAboutBasicInfo(
                  gender: profileViewController.userProfileBasicData.value?.gender ?? "",
                  dateOfBirth: DateFormat('MMMM d, yyyy').format(profileViewController.userProfileBasicData.value?.dateOfBirth ?? DateTime.now()),
                  languages: profileViewController.userProfileBasicData.value!.languages!,
                ),
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
                ProileViewAboutEducationBackground(
                  collegeList: profileViewController.collegeDataList,
                  schoolList: profileViewController.schoolDataList,
                ),
                kH12sizedBox,
                ProileViewAboutWork(
                  workplaceList: profileViewController.workPlaceList,
                ),
                kH12sizedBox,
                ProileViewAboutContactInfo(
                  title: profileViewController.userBasicData,
                ),
                kH12sizedBox,
                ProileViewAboutSocialLinks(
                  title: profileViewController.userLinkData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
