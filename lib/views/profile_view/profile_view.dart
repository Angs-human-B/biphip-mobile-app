import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/bottom_sheet_content/user_profile_action_bottom_sheet_content.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_top_tab_widget.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_award_tab.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_post_tab.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_profile_cover_photo_widget.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_top_row_widget.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_video_tab.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final ProfileController profileController = Get.find<ProfileController>(); //!Remove this profile controller and replace here profile_view_controller
  final ProfileViewController profileViewController =
      Get.find<ProfileViewController>(); //!Remove this profile controller and replace here profile_view_controller

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => profileController.isProfileLoading.value
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
                      title: "Wahid Murad",
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProfileViewProfileCoverPhotoWidget(),
                        Padding(
                          padding: const EdgeInsets.only(left: k20Padding, top: k8Padding, right: k20Padding, bottom: k20Padding),
                          child: Text(
                            "Wahid Murad", //!User name from api
                            style: semiBold24TextStyle(cBlackColor),
                          ),
                        ),
                        ProfileViewTopRowWidget(
                          buttonText: ksFriend.tr,
                          messageButtonText: ksMessage.tr,
                          messageIcon: BipHip.chatFill,
                          buttonIcon: BipHip.friends,
                          buttonOnPressed: () {},
                          messageButtonOnPressed: () {},
                          profileActionButtonOnPressed: () {
                            Get.find<GlobalController>().commonBottomSheet(
                                context: context,
                                content: const UserProfileActionBottomSheetContent(),
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
                        const ProfileTopTabWidget(),
                        kH16sizedBox,
                        if (profileViewController.profileSelectedTabIndex.value == 0) ProfileViewPostTab(),
                        if (profileViewController.profileSelectedTabIndex.value == 2) ProfileViewVideoTab(),
                        if (profileViewController.profileSelectedTabIndex.value == 3) ProfileViewAwardTab(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
