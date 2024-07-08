import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_follower_list_widget.dart';

class ProfileViewFollower extends StatelessWidget {
  ProfileViewFollower({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final FriendController friendController = Get.find<FriendController>();

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
              title: ksFollowers.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                CustomModifiedTextField(
                    borderRadius: h8,
                    controller: profileViewController.followerSearchController,
                    prefixIcon: BipHip.search,
                    // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,//! use it later
                    // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,//! use it later
                    hint: ksSearch.tr,
                    contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                    textInputStyle: regular16TextStyle(cBlackColor),
                    onSuffixPress: () {
                      // friendHelper.friendSearchReset();//!craete a new function
                    },
                    onSubmit: (v) {
                      unfocus(context);
                      // friendController.isFriendSuffixIconVisible.value = false;//!Use it later
                    },
                    onChanged: (v) {
                      // friendHelper.searchFriends();//!craete a new function
                    }),
                Expanded(
                  child: SingleChildScrollView(
                    // controller: .sendFamilyListScrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kH16sizedBox,
                        ListView.separated(
                          itemCount: friendController.friendList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => kH16sizedBox,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                              child: ProfileViewFollowerListWidget(
                                backgroundImage: friendController.friendList[index].profilePicture.toString(),
                                imageSize: h45,
                                name: friendController.friendList[index].fullName ?? ksNA.tr,
                                buttonText: friendController.friendList[index].followStatus == 0 ? ksFollow.tr : ksFollowing.tr,
                                buttonOnPressed: friendController.friendList[index].followStatus == 0 ? null : () async {},
                                buttonColor: cPrimaryColor,
                                textStyle: semiBold12TextStyle(cWhiteColor),
                              ),
                            );
                          },
                        ),
                        kH16sizedBox,
                        if (friendController.friendList.isNotEmpty &&
                            friendController.friendListScrolled.value &&
                            friendController.friendListSubLink.value != null)
                          const Center(child: CircularProgressIndicator()),
                      ],
                    ),
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