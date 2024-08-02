import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/bottom_sheet_content/user_profile_action_bottom_sheet_content.dart';
import 'package:bip_hip/views/profile_view/store_review/store_review.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_top_tab_widget.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_award_tab.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_photo_tab.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_post_tab.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_profile_cover_photo_widget.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_top_row_widget.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_video_tab.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final ProfileViewHelper profileViewHelper = ProfileViewHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => profileViewController.isUserProfileViewOverviewLoading.value ||
                profileViewController.isProfileViewFriendLoading.value ||
                profileViewController.isProfileViewFamilyLoading.value
            ? const ProfilePageShimmer2()
            : SafeArea(
                top: false,
                child: Scaffold(
                  backgroundColor: cWhiteColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kAppBarSize),
                    //* info:: appBar
                    child: CustomAppBar(
                      appBarColor: cWhiteColor,
                      title: profileViewHelper.getUserKidOrStoreName(type: profileViewController.profileViewType.value),
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileViewProfileCoverPhotoWidget(),
                        Padding(
                          padding: const EdgeInsets.only(left: k20Padding, top: k8Padding, right: k20Padding),
                          child: Text(
                            profileViewHelper.getUserKidOrStoreName(type: profileViewController.profileViewType.value),
                            style: semiBold24TextStyle(cBlackColor),
                          ),
                        ),
                        if (profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store")
                          Padding(
                            padding: const EdgeInsets.only(top: k4Padding, left: k20Padding, right: k20Padding),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(krProfileViewFollower);
                              },
                              child: Text(
                                // "500 Followers",
                                profileViewHelper.getKidOrStoreFollowers(type: profileViewController.profileViewType.value),
                                style: semiBold14TextStyle(cPrimaryColor),
                              ),
                            ),
                          ),
                        profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store"
                            ? kH12sizedBox
                            : kH20sizedBox,
                        ProfileViewTopRowWidget(
                          // buttonText: profileViewController.userProfileViewData.value?.user?.friendStatus == 1 ? ksFriend.tr : ksAddFriend.tr,
                          buttonText: profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store"
                              ? ksFollow.tr
                              : ksFriends.tr,
                          messageButtonText: ksMessage.tr,
                          messageIcon: BipHip.chatFill,
                          buttonIcon: profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store"
                              ? BipHip.follow
                              : BipHip.friends,
                          buttonOnPressed: () {},
                          messageButtonOnPressed: () {},
                          profileActionButtonOnPressed: () {
                            Get.find<GlobalController>().commonBottomSheet(
                                context: context,
                                bottomSheetHeight:
                                    profileViewController.profileViewType.value == "kid" || profileViewController.profileViewType.value == "store"
                                        ? height * 0.35
                                        : 0.5,
                                content: UserProfileActionBottomSheetContent(),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {},
                                rightText: "",
                                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                title: ksAction.tr,
                                isRightButtonShow: false,
                                isBottomSheetRightButtonActive: false.obs);
                          },
                        ),
                        kH16sizedBox,
                        Container(
                          height: h8,
                          color: cBackgroundColor,
                        ),
                        ProfileTopTabWidget(),
                        kH16sizedBox,
                        if (profileViewController.profileSelectedTabIndex.value == 0) ProfileViewPostTab(),
                        if (profileViewController.profileSelectedTabIndex.value == 1) ProfileViewPhotoTab(),
                        if (profileViewController.profileSelectedTabIndex.value == 2) ProfileViewVideoTab(),
                        if (profileViewController.profileSelectedTabIndex.value == 3 && profileViewController.profileViewType.value != "store")
                          ProfileViewAwardTab(),
                        if (profileViewController.profileSelectedTabIndex.value == 3 && profileViewController.profileViewType.value == "store") StoreReview(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
