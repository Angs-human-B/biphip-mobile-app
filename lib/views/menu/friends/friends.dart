import 'dart:async';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:flutter/rendering.dart';

class Friends extends StatelessWidget {
  Friends({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FriendController _friendController = Get.find<FriendController>();

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
                            _friendController.friendTapableButtonReset();
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
                            _friendController.friendTapableButtonReset();
                              _profileController.toggleType(0);
                              await _friendController.getFriendList();
                            },
                            () async {
                              FocusScope.of(context).unfocus();
                               _friendController.friendTapableButtonReset();
                              _profileController.toggleType(1);
                              await _friendController.getReceivedFriendList();
                            },
                            () async {
                              FocusScope.of(context).unfocus();
                               _friendController.friendTapableButtonReset();
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
                                  Get.find<ProfileController>().searchController.clear();
                                  _friendController.isFriendSuffixIconVisible.value = false;
                                  _friendController.isFriendSearched.value = false;
                                  await _friendController.getFriendList();
                                },
                                onSubmit: (v) {
                                  unfocus(context);
                                  _friendController.isFriendSuffixIconVisible.value = false;
                                },
                                onChanged: (v) async {
                                  if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
                                  if (Get.find<ProfileController>().searchController.text.trim() != '') {
                                    _friendController.debounce = Timer(const Duration(milliseconds: 3000), () async {
                                      _friendController.isFriendSearched.value = true;
                                      _friendController.isFriendSuffixIconVisible.value = true;
                                      await _friendController.getFriendSearchList();
                                    });
                                  } else {
                                    _friendController.isFriendSuffixIconVisible.value = false;
                                    _friendController.isFriendSearched.value = false;
                                    await _friendController.getFriendList();
                                  }
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
                      _profileController.allReceivedPendingFriendsView(),
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
//*All friend list
class AllFriendList extends StatelessWidget {
  AllFriendList({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FriendController _friendController = Get.find<FriendController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_friendController.isFriendListLoading.value)
          ? const AllPendingFriendShimmer()
          : _friendController.friendList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_friendController.friendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_friendController.friendListScrolled.value) {
                      _friendController.friendListScrolled.value = true;
                      if (_friendController.friendList.isNotEmpty) {
                        _friendController.getMoreFriendList(null);
                      }
                      if (_friendController.friendList.isNotEmpty && _friendController.isFriendSearched.value) {
                        _friendController.getMoreFriendSearchList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _friendController.friendListScrollController,
                   
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _friendController.friendList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k12Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: CustomListTile(
                                      padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding).copyWith(right: k0Padding),
                                      borderColor: cLineColor,
                                      leading: Container(
                                        height: h40,
                                        width: h40,
                                        decoration: const BoxDecoration(
                                          color: cWhiteColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            Environment.imageBaseUrl + _friendController.friendList[index].profilePicture.toString(),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(kiProfileDefaultImageUrl);
                                            },
                                            loadingBuilder: imageLoadingBuilder,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        _friendController.friendList[index].fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      trailing: CustomIconButton(
                                          onPress: () {
                                            _profileController.friendActionSelect.value = '';
                                            _friendController.allFriendFollowStatus.value = _friendController.friendList[index].followStatus!;
                                            if (_profileController.friendActionSelect.value == '') {
                                              _globalController.isBottomSheetRightButtonActive.value = false;
                                            } else {
                                              _globalController.isBottomSheetRightButtonActive.value = true;
                                            }
                                            _globalController.commonBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              content: _FriendActionContent(
                                                profileController: _profileController,
                                                friendController: _friendController,
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () async {
                                                _friendController.userId.value = _friendController.friendList[index].id!;
                                                Get.back();
                                                if (_profileController.friendActionSelect.value == 'Unfriend') {
                                                  await _friendController.unfriendUserRequest();
                                                }
                                                if (_profileController.friendActionSelect.value == 'Unfollow') {
                                                  await _friendController.unfollowUser();
                                                }
                                                if (_profileController.friendActionSelect.value == 'Follow') {
                                                  await _friendController.followUser();
                                                }
                                                _profileController.friendActionSelect.value = '';
                                              },
                                              rightText: ksDone.tr,
                                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                              title: ksAction.tr,
                                              isRightButtonShow: true,
                                              bottomSheetHeight: 250,
                                            );
                                          },
                                          icon: BipHip.system),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_friendController.friendList.isNotEmpty && !_friendController.friendListScrolled.value)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Container(
                          alignment: Alignment.center,
                          child: EmptyView(title: _friendController.allFriendCount.value == 0 ? ksNoFriendAddedYet.tr : ksNoSearchedFriendsAvailable.tr)))),
    );
  }
}

//*Received friend list
class ReceivedFriendList extends StatelessWidget {
  ReceivedFriendList({super.key});
  final FriendController _friendController = Get.find<FriendController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _friendController.isReceivedFriendListLoading.value
          ? const ReceivedFriendShimmer()
          : _friendController.receivedFriendList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_friendController.receivedFriendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_friendController.receivedFriendListScrolled.value) {
                      _friendController.receivedFriendListScrolled.value = true;
                      if (_friendController.receivedFriendList.isNotEmpty) {
                        _friendController.getMoreReceivedFriendList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _friendController.receivedFriendListScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _friendController.receivedFriendList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k16Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: FriendFamilyButtonAction(
                                      backgroundImage: Environment.imageBaseUrl + _friendController.receivedFriendList[index].profilePicture.toString(),
                                      name: _friendController.receivedFriendList[index].fullName ?? ksNA.tr,
                                      firstButtonText: ksConfirm.tr,
                                      secondButtonText: ksCancel.tr,
                                      firstButtonOnPressed: () async {
                                        _friendController.userId.value = _friendController.receivedFriendList[index].id!;
                                        await _friendController.acceptFriendRequest();
                                      },
                                      secondButtonOnPressed: () async {
                                        _friendController.userId.value = _friendController.receivedFriendList[index].id!;
                                        await _friendController.rejectFriendRequest();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_friendController.receivedFriendList.isNotEmpty && !_friendController.receivedFriendListScrolled.value)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(alignment: Alignment.center, child: EmptyView(title: ksNoFriendRequestReceivedYet.tr)),
                ),
    );
  }
}

//*Pending Friend Request
class PendingFriendList extends StatelessWidget {
  PendingFriendList({super.key});
  final FriendController _friendController = Get.find<FriendController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _friendController.isSendFriendRequestListLoading.value
          ? const AllPendingFriendShimmer()
          : _friendController.sendFriendRequestList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_friendController.sendFriendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_friendController.sendFriendListScrolled.value) {
                      _friendController.sendFriendListScrolled.value = true;
                      if (_friendController.sendFriendRequestList.isNotEmpty) {
                        _friendController.getMoreSendFriendRequestList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _friendController.sendFriendListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding, vertical: k4Padding).copyWith(bottom: k0Padding),
                            child: ListView.builder(
                              itemCount: _friendController.sendFriendRequestList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k12Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: CustomListTile(
                                      padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding).copyWith(right: k0Padding),
                                      borderColor: cLineColor,
                                      leading: Container(
                                        height: h40,
                                        width: h40,
                                        decoration: const BoxDecoration(
                                          color: cWhiteColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            Environment.imageBaseUrl + _friendController.sendFriendRequestList[index].profilePicture.toString(),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(kiProfileDefaultImageUrl);
                                            },
                                            loadingBuilder: imageLoadingBuilder,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        _friendController.sendFriendRequestList[index].fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      trailing: CustomIconButton(
                                          onPress: () {
                                            _friendController.pendingFriendActionSelect.value = '';
                                            _friendController.pendingFriendFollowStatus.value = _friendController.sendFriendRequestList[index].followStatus!;
                                            if (_friendController.pendingFriendActionSelect.value == '') {
                                              _globalController.isBottomSheetRightButtonActive.value = false;
                                            } else {
                                              _globalController.isBottomSheetRightButtonActive.value = true;
                                            }
                                            _globalController.commonBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              content: _PendingFriendActionContent(
                                                friendController: _friendController,
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () async {
                                                _friendController.userId.value = _friendController.sendFriendRequestList[index].id!;
                                                Get.back();
                                                if (_friendController.pendingFriendActionSelect.value == 'Cancel Request') {
                                                  await _friendController.cancelFriendRequest();
                                                }
                                                if (_friendController.pendingFriendActionSelect.value == 'Unfollow') {
                                                  await _friendController.unfollowUser();
                                                }
                                                if (_friendController.pendingFriendActionSelect.value == 'Follow') {
                                                  await _friendController.followUser();
                                                }
                                                _friendController.pendingFriendActionSelect.value = '';
                                              },
                                              rightText: ksDone.tr,
                                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                              title: ksAction.tr,
                                              isRightButtonShow: true,
                                              bottomSheetHeight: 200,
                                            );
                                          },
                                          icon: BipHip.system),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: EmptyView(title: ksNoFriendRequestSendYet.tr)),
    );
  }
}

class _FriendActionContent extends StatelessWidget {
  const _FriendActionContent({
    Key? key,
    required this.profileController,
    required this.friendController,
  }) : super(key: key);

  final ProfileController profileController;
  final FriendController friendController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: profileController.friendActionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: k8Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      friendController.allFriendFollowStatus.value == 1
                          ? profileController.friendActionList[index]['icon']
                          : friendController.friendFollowActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: friendController.allFriendFollowStatus.value == 1
                      ? profileController.friendActionList[index]['action']
                      : friendController.friendFollowActionList[index]['action'],
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subtitle: friendController.allFriendFollowStatus.value == 1
                      ? profileController.friendActionList[index]['actionSubtitle']
                      : friendController.friendFollowActionList[index]['actionSubtitle'],
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      if (friendController.allFriendFollowStatus.value == 1) {
                        profileController.friendActionSelect.value = profileController.friendActionList[index]['action'];
                      } else if (friendController.allFriendFollowStatus.value == 0) {
                        profileController.friendActionSelect.value = friendController.friendFollowActionList[index]['action'];
                      }
                    },
                    isSelected: friendController.allFriendFollowStatus.value == 1
                        ? (profileController.friendActionSelect.value == profileController.friendActionList[index]['action'])
                        : profileController.friendActionSelect.value == friendController.friendFollowActionList[index]['action'],
                  ),
                  itemColor: friendController.allFriendFollowStatus.value == 1
                      ? (profileController.friendActionSelect.value == profileController.friendActionList[index]['action'] ? cPrimaryTint3Color : cWhiteColor)
                      : (profileController.friendActionSelect.value == friendController.friendFollowActionList[index]['action']
                          ? cPrimaryTint3Color
                          : cWhiteColor),
                  onPressed: () {
                    if (friendController.allFriendFollowStatus.value == 1) {
                      profileController.friendActionSelect.value = profileController.friendActionList[index]['action'];
                    } else if (friendController.allFriendFollowStatus.value == 0) {
                      profileController.friendActionSelect.value = friendController.friendFollowActionList[index]['action'];
                    }
                    if (profileController.friendActionSelect.value == '') {
                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                    } else {
                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PendingFriendActionContent extends StatelessWidget {
  const _PendingFriendActionContent({
    Key? key,
    required this.friendController,
  }) : super(key: key);

  final FriendController friendController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: friendController.pendingFriendActionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: k8Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      friendController.pendingFriendFollowStatus.value == 1
                          ? friendController.pendingFriendActionList[index]['icon']
                          : friendController.pendingFollowFriendActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: friendController.pendingFriendFollowStatus.value == 1
                      ? friendController.pendingFriendActionList[index]['action']
                      : friendController.pendingFollowFriendActionList[index]['action'],
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subtitle: friendController.pendingFriendFollowStatus.value == 1
                      ? friendController.pendingFriendActionList[index]['actionSubtitle']
                      : friendController.pendingFollowFriendActionList[index]['actionSubtitle'],
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      if (friendController.pendingFriendFollowStatus.value == 1) {
                        friendController.pendingFriendActionSelect.value = friendController.pendingFriendActionList[index]['action'];
                      } else if (friendController.pendingFriendFollowStatus.value == 0) {
                        friendController.pendingFriendActionSelect.value = friendController.pendingFollowFriendActionList[index]['action'];
                      }
                    },
                    isSelected: friendController.pendingFriendFollowStatus.value == 1
                        ? (friendController.pendingFriendActionSelect.value == friendController.pendingFriendActionList[index]['action'])
                        : (friendController.pendingFriendActionSelect.value == friendController.pendingFollowFriendActionList[index]['action']),
                  ),
                  itemColor: friendController.pendingFriendFollowStatus.value == 1
                      ? (friendController.pendingFriendActionSelect.value == friendController.pendingFriendActionList[index]['action']
                          ? cPrimaryTint3Color
                          : cWhiteColor)
                      : (friendController.pendingFriendActionSelect.value == friendController.pendingFollowFriendActionList[index]['action']
                          ? cPrimaryTint3Color
                          : cWhiteColor),
                  onPressed: () {
                    if (friendController.pendingFriendFollowStatus.value == 1) {
                      friendController.pendingFriendActionSelect.value = friendController.pendingFriendActionList[index]['action'];
                    } else if (friendController.pendingFriendFollowStatus.value == 0) {
                      friendController.pendingFriendActionSelect.value = friendController.pendingFollowFriendActionList[index]['action'];
                    }
                    if (friendController.pendingFriendActionSelect.value == '') {
                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                    } else {
                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

//*All and Pending Friend Shimmer
class AllPendingFriendShimmer extends StatelessWidget {
  const AllPendingFriendShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k16Padding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      child: CustomListTile(
                        borderColor: cLineColor,
                        leading: ShimmerCommon(
                          widget: Container(
                            decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                            height: h40,
                            width: h40,
                          ),
                        ),
                        title: ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 12,
                            width: 80,
                          ),
                        ),
                        trailing: ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 20,
                            width: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//*Received Friend Shimmer
class ReceivedFriendShimmer extends StatelessWidget {
  const ReceivedFriendShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k16Padding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: h40,
                            width: h40,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: ShimmerCommon(
                              widget: Container(
                                decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: k12Padding),
                            child: SizedBox(
                              width: width - 105,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerCommon(
                                    widget: Container(
                                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                      height: 16,
                                      width: 200,
                                    ),
                                  ),
                                  kH4sizedBox,
                                  Row(
                                    children: [
                                      ShimmerCommon(
                                        widget: Container(
                                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                                          height: 30,
                                          width: isDeviceScreenLarge() ? 112 : 120,
                                        ),
                                      ),
                                      kW20sizedBox,
                                      ShimmerCommon(
                                        widget: Container(
                                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                                          height: 30,
                                          width: isDeviceScreenLarge() ? 112 : 120,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
