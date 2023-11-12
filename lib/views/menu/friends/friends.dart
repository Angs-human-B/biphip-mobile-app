import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/menu/friend/friend_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class Friends extends StatelessWidget {
  Friends({super.key});
  final GlobalController globalController = Get.find<GlobalController>();
  final FriendController friendController = Get.find<FriendController>();
  final FriendHelper friendHelper = FriendHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    title: ksFriends.tr,
                    hasBackButton: friendController.isRouteFromBottomNavBar.value ? false : true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: k20Padding),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            friendHelper.friendSearchFieldReset();
                            if (friendController.debounce?.isActive ?? false) friendController.debounce!.cancel();
                            friendController.addFriendRequestList.clear();
                            Get.toNamed(krAddFriend);
                          },
                          child: Text(
                            ksAdd.tr,
                            style: semiBold16TextStyle(cPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH4sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: TapAbleButtonContainer(
                          buttonText: globalController.tapAbleButtonText,
                          buttonState: globalController.tapAbleButtonState,
                          buttonPress: RxList([
                            () {
                              unFocus(context);
                              friendHelper.allFriendTapableButtonOnPressed();
                            },
                            () {
                              unFocus(context);
                              friendHelper.receivedFriendTapableButtonOnPressed();
                            },
                            () {
                              unFocus(context);
                              friendHelper.pendingFriendTapableButtonOnPressed();
                            },
                          ]),
                        ),
                      ),
                      kH12sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: Obx(() => globalController.tapAbleButtonState[0]
                            ? CustomModifiedTextField(
                                borderRadius: h8,
                                controller: globalController.searchController,
                                prefixIcon: BipHip.search,
                                suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                hint: ksSearch.tr,
                                contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                                textInputStyle: regular16TextStyle(cBlackColor),
                                onSuffixPress: () {
                                  friendHelper.friendSuffixPressed();
                                },
                                onSubmit: (v) {
                                  unfocus(context);
                                  friendController.isFriendSuffixIconVisible.value = false;
                                },
                                onChanged: (v) {
                                  friendHelper.friendOnChanged();
                                })
                            : const SizedBox()),
                      ),
                      if (globalController.tapAbleButtonState[0] || globalController.tapAbleButtonState[1]) kH4sizedBox,
                      if (globalController.tapAbleButtonState[0] || globalController.tapAbleButtonState[1])
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: (friendController.isFriendListLoading.value || friendController.isReceivedFriendListLoading.value)
                                ? ShimmerCommon(
                                    widget: Container(
                                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                      height: 16,
                                      width: 120,
                                    ),
                                  )
                                : friendHelper.totalFriendCountShow()),
                      if (globalController.tapAbleButtonState[0] || globalController.tapAbleButtonState[1]) kH12sizedBox,
                      if (globalController.tapAbleButtonState[2]) kH4sizedBox,
                      //*All friend, Receive friend request and Pending friend request ui
                      friendHelper.allReceivedPendingFriendsView(),
                    ],
                  ),
                ),
                bottomNavigationBar: CustomBottomNavBar(
                  width: width,
                  isFirstButtonClicked: false,
                  isSecondButtonClicked: true,
                  isThirdButtonClicked: false,
                  isFourthButtonClicked: false,
                  isFifthButtonClicked: false,
                ),
              ),
            ),
            if (friendController.isUnfriendUserRequestLoading.value ||
                friendController.isFollowUserLoading.value ||
                friendController.isUnfollowUserLoading.value ||
                friendController.isAcceptFriendRequestLoading.value ||
                friendController.isRejectFriendRequestLoading.value ||
                friendController.isCancelFriendRequestLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (friendController.isUnfriendUserRequestLoading.value ||
                        friendController.isFollowUserLoading.value ||
                        friendController.isUnfollowUserLoading.value ||
                        friendController.isAcceptFriendRequestLoading.value ||
                        friendController.isRejectFriendRequestLoading.value ||
                        friendController.isCancelFriendRequestLoading.value) {
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
