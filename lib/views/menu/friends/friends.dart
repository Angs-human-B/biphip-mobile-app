import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/friend_helpers/friend_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class Friends extends StatelessWidget {
  Friends({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FriendController _friendController = Get.find<FriendController>();
  final FriendHelper _friendHelper = FriendHelper();

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
                    hasBackButton: _friendController.isRouteFromBottomNavBar.value ? false : true,
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
                            _friendHelper.friendTapableButtonReset();
                            if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
                            _friendController.addFriendRequestList.clear();
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
                          buttonText: _profileController.tapAbleButtonText,
                          buttonState: _profileController.tapAbleButtonState,
                          buttonPress: RxList([
                            () async {
                              FocusScope.of(context).unfocus();
                              _friendHelper.friendTapableButtonReset();
                              _profileController.toggleType(0);
                              await _friendController.getFriendList();
                            },
                            () async {
                              FocusScope.of(context).unfocus();
                              _friendHelper.friendTapableButtonReset();
                              _profileController.toggleType(1);
                              await _friendController.getReceivedFriendList();
                            },
                            () async {
                              FocusScope.of(context).unfocus();
                              _friendHelper.friendTapableButtonReset();
                              _profileController.toggleType(2);
                              await _friendController.getSendFriendRequestList();
                            },
                          ]),
                        ),
                      ),
                      kH12sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: Obx(() => _profileController.tapAbleButtonState[0]
                            ? CustomModifiedTextField(
                                borderRadius: h8,
                                controller: Get.find<ProfileController>().searchController,
                                prefixIcon: BipHip.search,
                                suffixIcon: _friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                hint: ksSearch.tr,
                                contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                                textInputStyle: regular16TextStyle(cBlackColor),
                                onSuffixPress: () async {
                                  _friendHelper.friendTapableButtonReset();
                                  if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
                                  await _friendController.getFriendList();
                                },
                                onSubmit: (v) {
                                  unfocus(context);
                                  _friendController.isFriendSuffixIconVisible.value = false;
                                },
                                onChanged: (v) {
                                  _friendHelper.friendOnChanged();
                                })
                            : const SizedBox()),
                      ),
                      if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH4sizedBox,
                      if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1])
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                          child: (_friendController.isFriendListLoading.value || _friendController.isReceivedFriendListLoading.value)
                              ? ShimmerCommon(
                                  widget: Container(
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                    height: 16,
                                    width: 120,
                                  ),
                                )
                              : _profileController.tapAbleButtonState[0]
                                  ? _friendController.allFriendCount.value == 0 ||
                                          (_friendController.isFriendSearched.value && _friendController.searchedFriendCount.value == 0)
                                      ? const SizedBox()
                                      : Text(
                                          _friendController.isFriendSearched.value
                                              ? '${ksSearchedFriends.tr}: ${_friendController.searchedFriendCount.value}'
                                              : '${ksTotalFriends.tr}: ${_friendController.allFriendCount.value}',
                                          style: semiBold14TextStyle(cBlackColor),
                                        )
                                  : _friendController.receivedRequestCount.value == 0
                                      ? const SizedBox()
                                      : Text(
                                          '${ksFriendRequests.tr}: ${_friendController.receivedRequestCount.value}',
                                          style: semiBold14TextStyle(cBlackColor),
                                        ),
                        ),
                      if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH12sizedBox,
                      if (_profileController.tapAbleButtonState[2]) kH4sizedBox,
                      //*All friend, Receive friend request and Pending friend request ui
                      _friendHelper.allReceivedPendingFriendsView(),
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
            if (_friendController.isUnfriendUserRequestLoading.value ||
                _friendController.isFollowUserLoading.value ||
                _friendController.isUnfollowUserLoading.value ||
                _friendController.isAcceptFriendRequestLoading.value ||
                _friendController.isRejectFriendRequestLoading.value ||
                _friendController.isCancelFriendRequestLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_friendController.isUnfriendUserRequestLoading.value ||
                        _friendController.isFollowUserLoading.value ||
                        _friendController.isUnfollowUserLoading.value ||
                        _friendController.isAcceptFriendRequestLoading.value ||
                        _friendController.isRejectFriendRequestLoading.value ||
                        _friendController.isCancelFriendRequestLoading.value) {
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
