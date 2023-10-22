import 'package:bip_hip/controllers/friend_controller.dart';
import 'package:bip_hip/controllers/friends_family_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/common_shimmer.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:flutter/rendering.dart';

class Friends extends StatelessWidget {
  Friends({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FriendController _friendController = Get.find<FriendController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksFriends.tr,
          hasBackButton: true,
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
                  //*Common bottom sheet for add friend
                  _profileController.searchController.clear();
                  FocusScope.of(context).unfocus();
                  _friendController.addFriendRequestList.clear();
                  Get.toNamed(krAddFriend);
                  // _globalController.commonBottomSheet(
                  //   context: context,
                  //   isSearchShow: true,
                  //   isScrollControlled: true,
                  //   content: BottomSheetContent(),
                  //   onPressCloseButton: () {
                  //     Get.back();
                  //   },
                  //   onPressRightButton: null,
                  //   rightText: '',
                  //   rightTextStyle: semiBold10TextStyle(cWhiteColor),
                  //   title: ksAddFriend.tr,
                  //   isRightButtonShow: false,
                  //   bottomSheetHeight: height * .9,
                  // );
                },
                child: Text(
                  ksAdd.tr,
                  style: medium14TextStyle(cPrimaryColor),
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
                    _profileController.searchController.clear();
                    FocusScope.of(context).unfocus();
                    _profileController.toggleType(0);
                    await _friendController.getFriendList();
                  },
                  () async {
                    _profileController.searchController.clear();
                    FocusScope.of(context).unfocus();
                    _profileController.toggleType(1);
                    await _friendController.getReceivedFriendList();
                  },
                  () async {
                    _profileController.searchController.clear();
                    FocusScope.of(context).unfocus();
                    _profileController.toggleType(2);
                    await _friendController.getSendFriendRequestList();
                  },
                ]),
              ),
            ),
            kH12sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: CustomModifiedTextField(
                borderRadius: h8,
                controller: Get.find<ProfileController>().searchController,

                prefixIcon: BipHip.search,
                suffixIcon: BipHip.voiceFill, // todo:: icon will be changed
                hint: ksSearch.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding),
                textInputStyle: regular16TextStyle(cBlackColor),
              ),
            ),
            if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH4sizedBox,
            if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1])
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                child: _friendController.isFriendListLoading.value || _friendController.isReceivedFriendListLoading.value
                    ? ShimmerCommon(
                        widget: Container(
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                          height: 16,
                          width: 120,
                        ),
                      )
                    : _profileController.tapAbleButtonState[0]
                        ? Text(
                            '${ksTotalFriends.tr}: ${_friendController.receivedFriendListData.value!.users!.total}',
                            style: semiBold14TextStyle(cBlackColor),
                          )
                        : Text(
                            '${ksFriendRequests.tr}: ${_friendController.receivedFriendListData.value!.users!.total}',
                            style: semiBold14TextStyle(cBlackColor),
                          ),
              ),
            if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH12sizedBox,
            if (_profileController.tapAbleButtonState[2]) kH4sizedBox,
            //*All friend, Receive friend request and Pending friend request ui
            Expanded(
              child: SingleChildScrollView(
                child: _profileController.allReceivedPendingFriendsView(),
              ),
            ),
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
    );
  }
}

//*List item content for two button
class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({
    super.key,
    required this.backgroundImage,
    required this.name,
    this.firstButtonText,
    this.secondButtonText,
    this.firstButtonOnPressed,
    this.secondButtonOnPressed,
    this.icon,
    this.subTitle,
    this.imageSize,
  });
  final String backgroundImage;
  final double? imageSize;
  final String name;
  final String? firstButtonText;
  final String? secondButtonText;
  final VoidCallback? firstButtonOnPressed;
  final VoidCallback? secondButtonOnPressed;
  final IconData? icon;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: imageSize ?? h40,
          width: imageSize ?? h40,
          decoration: const BoxDecoration(
            color: cWhiteColor,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(
              backgroundImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(kiProfileDefaultImageUrl);
              },
              loadingBuilder: imageLoadingBuilder,
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
                Text(
                  name,
                  style: medium16TextStyle(cBlackColor),
                ),
                Row(
                  children: [
                    icon == null
                        ? const SizedBox()
                        : Icon(
                            icon,
                            size: h10,
                            color: cRedColor,
                          ),
                    if (icon != null) kW4sizedBox,
                    subTitle == null
                        ? const SizedBox()
                        : Text(
                            subTitle ?? '',
                            style: regular10TextStyle(cSmallBodyTextColor),
                          ),
                  ],
                ),
                kH4sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (firstButtonText != null)
                      CustomElevatedButton(
                        buttonWidth: (width / 2) - h60,
                        buttonHeight: 30,
                        label: firstButtonText!,
                        textStyle: semiBold16TextStyle(cWhiteColor),
                        onPressed: firstButtonOnPressed,
                      ),
                    if (secondButtonText != null)
                      CustomElevatedButton(
                        buttonWidth: (width / 2) - h60,
                        buttonHeight: 30,
                        label: secondButtonText!,
                        onPressed: secondButtonOnPressed,
                        buttonColor: cWhiteColor,
                        borderColor: cRedColor,
                        textStyle: semiBold16TextStyle(cRedColor),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//*List item content for single button
class CustomSingleButtonListViewItem extends StatelessWidget {
  const CustomSingleButtonListViewItem({
    super.key,
    required this.backgroundImage,
    required this.name,
    required this.buttonText,
    required this.buttonOnPressed,
    this.buttonColor,
    this.textStyle,
    this.buttonWidth,
    this.borderColor,
    this.buttonHeight,
    this.subTitle,
    this.imageSize,
  });
  final String backgroundImage;
  final String name;
  final String buttonText;
  final VoidCallback buttonOnPressed;
  final Color? buttonColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? subTitle;
  final double? imageSize;
  // final BoxDecoration boxDecoration;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: imageSize ?? h40,
              width: imageSize ?? h40,
              decoration: const BoxDecoration(
                color: cWhiteColor,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(kiProfileDefaultImageUrl);
                  },
                  loadingBuilder: imageLoadingBuilder,
                ),
              ),
            ),
            kW12sizedBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  subTitle == null
                      ? const SizedBox()
                      : Text(
                          subTitle ?? '',
                          style: regular10TextStyle(cSmallBodyTextColor),
                        ),
                ],
              ),
            ),
            CustomElevatedButton(
              label: buttonText,
              onPressed: buttonOnPressed,
              buttonColor: buttonColor,
              textStyle: textStyle,
              buttonHeight: buttonHeight ?? 32,
              buttonWidth: buttonWidth,
              borderColor: borderColor,
            ),
          ],
        ),
      ],
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
      () => _friendController.isFriendListLoading.value
          ? const AllPendingFriendShimmer()
          : NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (_friendController.friendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                    scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                    !_friendController.friendListScrolled.value) {
                  _friendController.friendListScrolled.value = true;
                  if (_friendController.friendList.isNotEmpty) {
                    _friendController.getMoreFriendList(null);
                  }
                  return true;
                }
                return false;
              },
              child: SingleChildScrollView(
                controller: _friendController.friendListScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
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
                          // var _item = _profileController.allFriendsList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: k16Padding),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                              child: TextButton(
                                style: kTextButtonStyle,
                                onPressed: () async {
                                  // ll(index);
                                },
                                child: CustomListTile(
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
                                            _profileController.friendActionSelect.value = '';
                                          },
                                          rightText: ksDone.tr,
                                          rightTextStyle: regular14TextStyle(cPrimaryColor),
                                          title: ksAction.tr,
                                          isRightButtonShow: true,
                                          bottomSheetHeight: 250,
                                        );
                                      },
                                      icon: BipHip.system),
                                ),
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
          : NotificationListener<ScrollNotification>(
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
              child: SingleChildScrollView(
                controller: _friendController.receivedFriendListScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
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
                              child: TextButton(
                                style: kTextButtonStyle,
                                onPressed: () async {
                                  // ll(index);
                                },
                                child: CustomListViewItem(
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
    );
  }
}

//*Pending Friend Request
class PendingFriendList extends StatelessWidget {
  PendingFriendList({super.key});
  final FriendController _friendController = Get.find<FriendController>();
  final FriendFamilyController _friendFamilyController = Get.find<FriendFamilyController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _friendController.isSendFriendRequestListLoading.value
          ? const AllPendingFriendShimmer()
          : NotificationListener<ScrollNotification>(
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
              child: SingleChildScrollView(
                controller: _friendController.sendFriendListScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: k20Padding, vertical: k4Padding).copyWith(bottom: k0Padding),
                      child: ListView.builder(
                        itemCount: _friendController.sendFriendRequestList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // var _item = _profileController.allFriendsList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: k16Padding),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                              child: TextButton(
                                style: kTextButtonStyle,
                                onPressed: () async {
                                  // ll(index);
                                },
                                child: CustomListTile(
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
                                        _friendFamilyController.pendingFriendActionSelect.value = '';
                                        _globalController.commonBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          content: _PendingFriendActionContent(
                                            friendFamilyController: _friendFamilyController,
                                          ),
                                          onPressCloseButton: () {
                                            Get.back();
                                          },
                                          onPressRightButton: () async {
                                            _friendController.userId.value = _friendController.sendFriendRequestList[index].id!;
                                            Get.back();
                                            if (_friendFamilyController.pendingFriendActionSelect.value == 'Cancel Request') {
                                              await _friendController.cancelFriendRequest();
                                            }
                                            if (_friendFamilyController.pendingFriendActionSelect.value == 'Unfollow') {
                                              await _friendController.unfollowUser();
                                            }
                                            _friendFamilyController.pendingFriendActionSelect.value = '';
                                          },
                                          rightText: ksDone.tr,
                                          rightTextStyle: regular14TextStyle(cPrimaryColor),
                                          title: ksAction.tr,
                                          isRightButtonShow: true,
                                          bottomSheetHeight: 200,
                                        );
                                      },
                                      icon: BipHip.system),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (_friendController.sendFriendRequestList.isNotEmpty && !_friendController.sendFriendListScrolled.value)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
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
                      profileController.friendActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: profileController.friendActionList[index]['action'],
                  subtitle: profileController.friendActionList[index]['actionSubtitle'],
                  trailing: CustomRadioButton(
                    onChanged: () {
                      profileController.friendActionSelect.value = profileController.friendActionList[index]['action'];
                    },
                    isSelected: profileController.friendActionSelect.value == profileController.friendActionList[index]['action'],
                  ),
                  itemColor:
                      profileController.friendActionSelect.value == profileController.friendActionList[index]['action'] ? cPrimaryTint3Color : cWhiteColor,
                  onPressed: () {
                    profileController.friendActionSelect.value = profileController.friendActionList[index]['action'];
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
    required this.friendFamilyController,
  }) : super(key: key);

  final FriendFamilyController friendFamilyController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: friendFamilyController.pendingFriendActionList.length,
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
                      friendFamilyController.pendingFriendActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: friendFamilyController.pendingFriendActionList[index]['action'],
                  subtitle: friendFamilyController.pendingFriendActionList[index]['actionSubtitle'],
                  trailing: CustomRadioButton(
                    onChanged: () {
                      friendFamilyController.pendingFriendActionSelect.value = friendFamilyController.pendingFriendActionList[index]['action'];
                    },
                    isSelected: friendFamilyController.pendingFriendActionSelect.value == friendFamilyController.pendingFriendActionList[index]['action'],
                  ),
                  itemColor: friendFamilyController.pendingFriendActionSelect.value == friendFamilyController.pendingFriendActionList[index]['action']
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    friendFamilyController.pendingFriendActionSelect.value = friendFamilyController.pendingFriendActionList[index]['action'];
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
    return Column(
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
    );
  }
}

//*Received Friend Shimmer
class ReceivedFriendShimmer extends StatelessWidget {
  const ReceivedFriendShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ShimmerCommon(
                                    widget: Container(
                                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                                      height: 30,
                                      width: 120,
                                    ),
                                  ),
                                  ShimmerCommon(
                                    widget: Container(
                                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                                      height: 30,
                                      width: 120,
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
    );
  }
}
