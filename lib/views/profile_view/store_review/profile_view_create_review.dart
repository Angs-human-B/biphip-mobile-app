import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class ProfileViewCreateReview extends StatelessWidget {
  ProfileViewCreateReview({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

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
              title: ksReviews.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h16),
                  child: CustomElevatedButton(
                    label: ksPost.tr,
                    onPressed: () {},
                    buttonWidth: 60,
                    buttonHeight: 32,
                  ),
                ),
              ],
            ),
          ),
          body: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDivider(),
                  kH16sizedBox,
                  Row(
                    children: [
                      Container(
                        width: h40,
                        height: h40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            Get.find<GlobalController>().userImage.value ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      kW8sizedBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            Get.find<GlobalController>().userName.value ?? ksNA.tr,
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                          CustomElevatedButton(
                            isCustomButton: true,
                            label: profileViewController.reviewSelectedPrivacy.value,
                            prefixIcon: profileViewController.reviewSelectedPrivacyIcon.value,
                            onPressed: () {
                              profileViewController.showReviewPrivacySheet(context);
                            },
                            buttonHeight: 22,
                            suffixIcon: BipHip.downArrow,
                            buttonColor: cGreyBoxColor,
                            prefixIconColor: cBlackColor,
                            suffixIconColor: cBlackColor,
                            textStyle: regular12TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  Text(
                    ksWhatDoYouRecommendAbout.tr,
                    style: regular16TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  Text(
                    "${Get.find<GlobalController>().userName.value}?",
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  kH24sizedBox,
                  kH16sizedBox,
                  Center(
                    child: Text(
                      profileViewController.ratingValue.value.toString(),
                      style: semiBold16TextStyle(cBlackColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewAudienceContent extends StatelessWidget {
  ReviewAudienceContent({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${ksWhoCanSeeYourPost.tr}?",
          style: semiBold16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        Text(
          ksAudienceInformation.tr,
          style: regular14TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        for (int i = 0; i < profileViewController.reviewPrivacyList.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: k4Padding),
            child: Obx(
              () => CustomListTile(
                onPressed: () {
                  profileViewController.temporaryReviewSelectedPrivacy.value = profileViewController.reviewPrivacyList[i]["action"].toString();
                  profileViewController.temporaryeviewSelectedPrivacyIcon.value = profileViewController.reviewPrivacyList[i]['icon'];
                },
                itemColor: profileViewController.temporaryReviewSelectedPrivacy.value == profileViewController.reviewPrivacyList[i]["action"].toString()
                    ? cPrimaryTint3Color
                    : cWhiteColor,
                title: profileViewController.reviewPrivacyList[i]["action"].toString(),
                leading: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: cNeutralColor,
                  ),
                  height: h28,
                  width: h28,
                  child: Icon(
                    profileViewController.reviewPrivacyList[i]["icon"],
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  ),
                ),
                trailing: CustomRadioButton(
                  onChanged: () {
                    profileViewController.temporaryeviewSelectedPrivacyIcon.value = profileViewController.reviewPrivacyList[i]['icon'];
                    profileViewController.temporaryReviewSelectedPrivacy.value = profileViewController.reviewPrivacyList[i]["action"].toString();
                  },
                  isSelected: profileViewController.temporaryReviewSelectedPrivacy.value == profileViewController.reviewPrivacyList[i]["action"].toString(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
