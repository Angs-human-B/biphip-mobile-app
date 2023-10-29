import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/friends.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:flutter/rendering.dart';

class Family extends StatelessWidget {
  Family({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FamilyController _familyController = Get.find<FamilyController>();

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
                    title: ksFamily.tr,
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
                            _profileController.searchController.clear();
                            unfocus(context);
                            // _familyController.addFamilyRequestList.clear();
                            _familyController.clearAddFamilyData();
                            // Get.find<FriendController>().getFriendList();
                            Get.toNamed(krAddFamily);
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
                              _profileController.searchController.clear();
                              FocusScope.of(context).unfocus();
                              _profileController.toggleType(0);
                              await _familyController.getFamilyList();
                            },
                            () async {
                              _profileController.searchController.clear();
                              FocusScope.of(context).unfocus();
                              _profileController.toggleType(1);
                              await _familyController.getReceivedFamilyList();
                            },
                            () async {
                              _profileController.searchController.clear();
                              FocusScope.of(context).unfocus();
                              _profileController.toggleType(2);
                              await _familyController.getSendFamilyRequestList();
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
                        (_familyController.isFamilyListLoading.value || _familyController.isReceivedFamilyListLoading.value)
                            ? Padding(
                                padding: const EdgeInsets.only(left: kHorizontalPadding),
                                child: ShimmerCommon(
                                  widget: Container(
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                    height: 16,
                                    width: 160,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                                child: _profileController.tapAbleButtonState[0]
                                    ? _familyController.allFamilyCount.value == 0
                                        ? const SizedBox()
                                        : Text(
                                            '${ksTotalFamilyMembers.tr}: ${_familyController.allFamilyCount.value}',
                                            style: semiBold14TextStyle(cBlackColor),
                                          )
                                    : _familyController.receivedRequestCount.value == 0
                                        ? const SizedBox()
                                        : Text(
                                            '${ksFamilyRequests.tr}: ${_familyController.receivedRequestCount.value}',
                                            style: semiBold14TextStyle(cBlackColor),
                                          ),
                              ),
                      if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH12sizedBox,
                      if (_profileController.tapAbleButtonState[2]) kH4sizedBox,
                      _profileController.allReceivedPendingFamilyView(),
                    ],
                  ),
                ),
              ),
            ),
            if (_familyController.isCancelFamilyRequestLoading.value == true ||
                _familyController.isAcceptFamilyRequestLoading.value == true ||
                _familyController.isRejectFamilyRequestLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_familyController.isCancelFamilyRequestLoading.value ||
                        _familyController.isAcceptFamilyRequestLoading.value ||
                        _familyController.isRejectFamilyRequestLoading.value) {
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

//*All family list
class AllFamilyList extends StatelessWidget {
  AllFamilyList({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _familyController.isFamilyListLoading.value
          ? const CommonFamilyShimmer()
          : _familyController.familyList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_familyController.familyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_familyController.familyListScrolled.value) {
                      _familyController.familyListScrolled.value = true;
                      if (_familyController.familyList.isNotEmpty) {
                        _familyController.getMoreFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _familyController.familyListScrollController,
                      // physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _familyController.familyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k16Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: CustomListViewItem(
                                      backgroundImage: _familyController.familyList[index].profilePicture.toString(),
                                      imageSize: h50,
                                      name: _familyController.familyList[index].fullName ?? ksNA.tr,
                                      icon: BipHip.relation,
                                      subTitle: _familyController.familyList[index].familyRelationStatus ?? ksNA.tr,
                                      firstButtonText: ksMessage.tr,
                                      secondButtonText: ksBlock.tr,
                                      firstButtonOnPressed: () {},
                                      secondButtonOnPressed: () {},
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_familyController.familyList.isNotEmpty && !_familyController.familyListScrolled.value)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: Container(alignment: Alignment.center, child: EmptyView(title: ksNofamilyAddedYet.tr))),
    );
  }
}

//*Received family list
class ReceivedFamilyList extends StatelessWidget {
  ReceivedFamilyList({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _familyController.isReceivedFamilyListLoading.value
          ? const CommonFamilyShimmer()
          : _familyController.receivedFamilyList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_familyController.receivedFamilyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_familyController.receivedFamilyListScrolled.value) {
                      _familyController.receivedFamilyListScrolled.value = true;
                      if (_familyController.receivedFamilyList.isNotEmpty) {
                        _familyController.getMoreReceivedFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _familyController.receivedFamilyListScrollController,
                      // physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _familyController.receivedFamilyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k16Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: CustomListViewItem(
                                      backgroundImage: _familyController.receivedFamilyList[index].profilePicture.toString(),
                                      imageSize: h50,
                                      name: _familyController.receivedFamilyList[index].fullName ?? ksNA.tr,
                                      subTitle: _familyController.receivedFamilyList[index].familyRelationStatus ?? ksNA,
                                      firstButtonText: ksConfirm.tr,
                                      secondButtonText: ksCancel.tr,
                                      firstButtonOnPressed: () async {
                                        _familyController.userId.value = _familyController.receivedFamilyList[index].id!;
                                        await _familyController.acceptFamilyRequest();
                                      },
                                      secondButtonOnPressed: () async {
                                        _familyController.userId.value = _familyController.receivedFamilyList[index].id!;
                                        await _familyController.rejectFamilyRequest();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_familyController.receivedFamilyList.isNotEmpty && !_familyController.receivedFamilyListScrolled.value)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: Container(alignment: Alignment.center, child: EmptyView(title: ksNofamilyRequestReceivedYet.tr))),
    );
  }
}

//*Pending family request list
class PendingFamilyList extends StatelessWidget {
  PendingFamilyList({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _familyController.isSendFamilyRequestListLoading.value
          ? const PendingFamilyListShimmer()
          : _familyController.sendFamilyRequestList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_familyController.sendFamilyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_familyController.sendFamilyListScrolled.value) {
                      _familyController.sendFamilyListScrolled.value = true;
                      if (_familyController.sendFamilyRequestList.isNotEmpty) {
                        _familyController.getMoreSendFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _familyController.sendFamilyListScrollController,
                      // physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _familyController.sendFamilyRequestList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k10Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: CustomSingleButtonListViewItem(
                                      backgroundImage: _familyController.sendFamilyRequestList[index].profilePicture.toString(),
                                      imageSize: h45,
                                      name: _familyController.sendFamilyRequestList[index].fullName ?? ksNA.tr,
                                      subTitle: _familyController.sendFamilyRequestList[index].familyRelationStatus ?? ksNA.tr,
                                      buttonText: ksCancelRequest.tr,
                                      buttonOnPressed: () async {
                                        _familyController.userId.value = _familyController.sendFamilyRequestList[index].id!;
                                        await _familyController.cancelFamilyRequest();
                                      },
                                      buttonColor: cWhiteColor,
                                      borderColor: cRedColor,
                                      textStyle: semiBold14TextStyle(cRedColor),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_familyController.sendFamilyRequestList.isNotEmpty && !_familyController.sendFamilyListScrolled.value)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: Container(alignment: Alignment.center, child: EmptyView(title: ksNofamilyRequestSendYet.tr))),
    );
  }
}

class RelationContent extends StatelessWidget {
  RelationContent({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _familyController.familyRelationList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: k10Padding),
          child: Obx(
            () => CustomListTile(
              itemColor: _familyController.relationStatusId.value == index ? cPrimaryTint3Color : cWhiteColor,
              onPressed: () {
                _familyController.relationStatusId.value = index;
              },
              title: _familyController.familyRelationList[index].name,
              borderColor: _familyController.relationStatusId.value == index ? cPrimaryColor : cLineColor,
              trailing: CustomRadioButton(
                onChanged: () {
                  _familyController.relationStatusId.value = index;
                },
                isSelected: _familyController.relationStatusId.value == index,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CommonFamilyShimmer extends StatelessWidget {
  const CommonFamilyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k16Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: h50,
                          width: h50,
                          decoration: const BoxDecoration(
                            color: cWhiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: ShimmerCommon(
                            widget: Container(
                              decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                              height: h50,
                              width: h50,
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
                                ShimmerCommon(
                                  widget: Container(
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                    height: 8,
                                    width: 100,
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
                                          width: isDeviceScreenLarge() ? 112 : 120),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

//*Pending family list shimmer
class PendingFamilyListShimmer extends StatelessWidget {
  const PendingFamilyListShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k10Padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: h45,
                              width: h45,
                              decoration: const BoxDecoration(
                                color: cWhiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: ShimmerCommon(
                                widget: Container(
                                  decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                                  height: h50,
                                  width: h50,
                                ),
                              ),
                            ),
                            kW12sizedBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerCommon(
                                    widget: Container(
                                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                      height: 16,
                                      width: 120,
                                    ),
                                  ),
                                  kH4sizedBox,
                                  ShimmerCommon(
                                    widget: Container(
                                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                      height: 8,
                                      width: 80,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
