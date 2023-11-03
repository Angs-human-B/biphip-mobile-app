import 'dart:async';

import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/friends.dart';
import 'package:flutter/rendering.dart';

class AddFriend extends StatelessWidget {
  AddFriend({super.key});
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
                    title: ksAddFriend.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      _profileController.searchController.clear();
                      FocusScope.of(context).unfocus();
                      Get.back();
                    },
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomModifiedTextField(
                        borderRadius: h8,
                        controller: _profileController.searchController,
                        prefixIcon: BipHip.search,
                        suffixIcon: _friendController.isAddFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                        hint: ksSearch.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                        textInputStyle: regular16TextStyle(cBlackColor),
                        onSuffixPress: () {
                          Get.find<ProfileController>().searchController.clear();
                          _friendController.isAddFriendSuffixIconVisible.value = false;
                          _friendController.addFriendRequestList.clear();
                        },
                        onSubmit: (v) {
                          unfocus(context);
                          _friendController.isAddFriendSuffixIconVisible.value = false;
                        },
                        onChanged: (v) async {
                          if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
                          if (_profileController.searchController.text.trim() != '') {
                            _friendController.debounce = Timer(const Duration(milliseconds: 3000), () async {
                              _friendController.isAddFriendSuffixIconVisible.value = true;
                              await _friendController.getAddFriendRequestList();
                            });
                          }
                          if (_profileController.searchController.text.trim() == '') {
                            _friendController.isAddFriendSuffixIconVisible.value = false;
                            _friendController.addFriendRequestList.clear();
                          }
                        },
                      ),
                      kH8sizedBox,
                      Obx(
                        () => _friendController.isAddFriendRequestListLoading.value
                            ? const AddFriendShimmer()
                            : NotificationListener<ScrollNotification>(
                                onNotification: (scrollNotification) {
                                  if (_friendController.addFriendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                      scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                      !_friendController.addFriendListScrolled.value) {
                                    _friendController.addFriendListScrolled.value = true;
                                    if (_friendController.addFriendRequestList.isNotEmpty) {
                                      _friendController.getMoreAddFriendRequestList(null);
                                    }
                                    return true;
                                  }
                                  return false;
                                },
                                child: Expanded(
                                  child: SingleChildScrollView(
                                    controller: _friendController.addFriendListScrollController,
                                    // physics: const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: _friendController.addFriendRequestList.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: k10Padding),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(k8BorderRadius),
                                                child: Obx(
                                                  () => CustomSingleButtonListViewItem(
                                                    backgroundImage:
                                                        Environment.imageBaseUrl + _friendController.addFriendRequestList[index].profilePicture.toString(),
                                                    name: _friendController.addFriendRequestList[index].fullName ?? ksNA.tr,
                                                    buttonText:
                                                        _friendController.addFriendRequestList[index].friendStatus == 0 ? ksSendRequest.tr : ksCancelRequest.tr,
                                                    buttonColor: _friendController.addFriendRequestList[index].friendStatus == 0 ? cPrimaryColor : cWhiteColor,
                                                    borderColor: _friendController.addFriendRequestList[index].friendStatus == 0 ? null : cRedColor,
                                                    textStyle: _friendController.addFriendRequestList[index].friendStatus == 0
                                                        ? semiBold14TextStyle(cWhiteColor)
                                                        : semiBold14TextStyle(cRedColor),
                                                    buttonOnPressed: () async {
                                                      _friendController.userId.value = _friendController.addFriendRequestList[index].id!;

                                                      if (_friendController.addFriendRequestList[index].friendStatus == 0) {
                                                        await _friendController.sendFriendRequest();
                                                      } else if (_friendController.addFriendRequestList[index].friendStatus == 2) {
                                                        await _friendController.cancelFriendRequest();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        if (_friendController.addFriendRequestList.isNotEmpty && !_friendController.addFriendListScrolled.value)
                                          const Center(child: CircularProgressIndicator()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_friendController.isSendFriendRequestLoading.value || _friendController.isCancelFriendRequestLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_friendController.isSendFriendRequestLoading.value || _friendController.isCancelFriendRequestLoading.value) {
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

class AddFriendShimmer extends StatelessWidget {
  const AddFriendShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: k10Padding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ShimmerCommon(
                              widget: Container(
                                decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                                height: h40,
                                width: h40,
                              ),
                            ),
                            kW12sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                height: 16,
                                width: 100,
                              ),
                            ),
                            const Spacer(),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
