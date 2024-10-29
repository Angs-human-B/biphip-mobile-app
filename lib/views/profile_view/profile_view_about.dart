import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_about.dart';
import 'package:bip_hip/views/profile_view/widgets/about/prfole_view_about_education_background.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_basic_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_contact_info.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_relation_profession_interest_content.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_social_links.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_work.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_interest_widget.dart';

class ProfileViewAbout extends StatelessWidget {
  ProfileViewAbout({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final ProfileViewHelper profileViewHelper = ProfileViewHelper();

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
                if (profileViewController.profileViewType.value == "store")
                  ProfileViewAbotRelationProfessionInterestContent(
                    title: ksCategory.tr,
                    subTitle: profileViewController.storeProfileData.value!.categories![0],
                  ),
                //!Store location data missing from the api
                // if (profileViewController.profileViewType.value == "store")
                // ProfileViewAbotRelationProfessionInterestContent(
                //   title: ksStoreLocation.tr,
                //   subTitle: profileViewController.storeProfileData.value.,
                // ),
                if (profileViewController.profileViewType.value == "store") kH12sizedBox,
                if (profileViewController.profileViewType.value == "store")
                  Container(
                    color: cWhiteColor,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k16Padding),
                      child: Row(
                        children: [
                          Text(
                            ksRating.tr,
                            style: regular16TextStyle(cBlackColor),
                          ),
                          kW4sizedBox,
                          Container(
                            width: 2,
                            height: 2,
                            decoration: const BoxDecoration(
                              color: cBlackColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          kW4sizedBox,
                          Text(
                            "${profileViewController.profileViewStoreData.value?.store?.rating.toString() ?? ksNA.tr} (${profileViewController.profileViewStoreData.value?.store?.countPageReviews.toString() ?? ksNA.tr})",
                            style: regular16TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (profileViewController.profileViewType.value == "store") kH12sizedBox,
                if (profileViewController.profileViewType.value == "store")
                  ProfileViewAbotRelationProfessionInterestContent(
                    title: ksQRCode.tr,
                    subTitle: profileViewController.storeProfileData.value!.qrCode ?? ksNA.tr,
                  ),
                if (profileViewController.profileViewType.value != "store") kH12sizedBox,
                if (profileViewController.profileViewType.value != "store")
                  ProileViewAboutBasicInfo(
                    gender: profileViewHelper.getUserKidGender(type: profileViewController.profileViewType.value),
                    dateOfBirth: profileViewHelper.getUserKidDateOfBirth(type: profileViewController.profileViewType.value),
                    languages: profileViewHelper.getUserKidOrStoreLanguages(type: profileViewController.profileViewType.value),
                  ),
                if (profileViewController.userProfileData.value?.relation != null)
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: ProfileViewAbotRelationProfessionInterestContent(
                      title: ksRelationshipStatus.tr,
                      subTitle: profileViewController.userProfileData.value?.relation ?? ksNA.tr,
                    ),
                  ),
                if (profileViewController.profileViewType.value == "kid") kH12sizedBox,
                if (profileViewController.profileViewType.value == "kid")
                  Container(
                    width: width,
                    color: cWhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k16Padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ksRelation.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          kH16sizedBox,
                          Text(
                            profileViewController.kidProfileData.value?.relation ?? ksNA.tr,
                            style: regular16TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (Get.find<ProfileViewController>().profileViewType.value != "kid" &&
                    Get.find<ProfileViewController>().profileViewType.value != "store" &&
                    profileViewController.userProfileData.value!.profession.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: ProfileViewAbotRelationProfessionInterestContent(
                      title: ksProfession.tr,
                      subTitle: profileViewController.userProfileData.value?.profession[0],
                    ),
                  ),
                if (Get.find<ProfileViewController>().profileViewType.value != "kid" &&
                    Get.find<ProfileViewController>().profileViewType.value != "store" &&
                    profileViewController.userProfileData.value!.interest.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: ProfileViewAbotInterestContent(
                      title: ksInterest.tr,
                      subTitle: profileViewController.userProfileData.value!.interest,
                    ),
                  ),
                if (profileViewController.profileViewType.value != "store") kH12sizedBox,
                if (profileViewController.profileViewType.value != "store")
                  ProileViewAboutEducationBackground(
                    collegeList: profileViewController.collegeDataList,
                    schoolList: profileViewController.schoolDataList,
                    kidSchool: profileViewController.kidProfileSchoolData,
                  ),
                if (Get.find<ProfileViewController>().profileViewType.value != "kid" && Get.find<ProfileViewController>().profileViewType.value != "store")
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: ProileViewAboutWork(
                      workplaceList: profileViewController.workPlaceList,
                    ),
                  ),
                kH12sizedBox,
                ProileViewAboutContactInfo(
                  title: profileViewHelper.getUserKidOrStoreContactInfo(type: profileViewController.profileViewType.value),
                ),
                if (profileViewController.profileViewType.value != "store") kH12sizedBox,
                if (profileViewController.profileViewType.value != "store")
                  ProileViewAboutSocialLinks(
                    title: profileViewController.userLinkData,
                    privacyLink: profileViewController.kidProfileData.value?.privacyLink ?? [],
                  ),
                if (profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store")
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: StorePageTransperencyContent(
                      pageId: ProfileViewHelper().getKidOrStorePageId(type: profileViewController.profileViewType.value),
                      creatingDate: ProfileViewHelper().getKidOrStoreCreatingDate(type: profileViewController.profileViewType.value),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
