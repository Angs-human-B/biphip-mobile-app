import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidsPage extends StatelessWidget {
  KidsPage({super.key});
  final KidsController _kidsController = Get.find<KidsController>();
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
              title: ksKids.tr,
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
                    onPressed: () {
                      Get.find<CreatePostController>().resetAddKidPage();
                      Get.toNamed(krAddKid);
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: _kidsController.isKidsListLoading.value
                        ? ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              height: 16,
                              width: 120,
                            ),
                          )
                        : Text(
                            '${ksTotalKids.tr}: ${_kidsController.totalKidsCount.value}',
                            style: semiBold14TextStyle(cBlackColor),
                          ),
                  )),
              // kH4sizedBox,
              AllKids(),
            ],
          ),
        ),
      ),
    );
  }
}

//*All Kids
class AllKids extends StatelessWidget {
  AllKids({super.key});
  final KidsController _kidsController = Get.find<KidsController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _kidsController.isKidsListLoading.value
          ? const AllKidsShimmer()
          : Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding).copyWith(bottom: k0Padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        // itemCount: _friendController.friendList.length,
                        itemCount: _kidsController.kidList.length,
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
                                      Environment.imageBaseUrl + _kidsController.kidList[index].kidImage.toString(),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(kiProfileDefaultImageUrl);
                                      },
                                      loadingBuilder: imageLoadingBuilder,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  _kidsController.kidList[index].name ?? ksNA.tr,
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                trailing: CustomIconButton(
                                    onPress: () {
                                      _kidsController.allKidsActionSelect.value = '';
                                      _kidsController.kidId.value = _kidsController.kidList[index].id!;
                                      if (_kidsController.allKidsActionSelect.value == '') {
                                        _globalController.isBottomSheetRightButtonActive.value = false;
                                      } else {
                                        _globalController.isBottomSheetRightButtonActive.value = true;
                                      }
                                      _globalController.commonBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        content: _AllKidsActionContent(kidsController: _kidsController),
                                        onPressCloseButton: () {
                                          Get.back();
                                        },
                                        onPressRightButton: () async {
                                          Get.back();
                                          if (_kidsController.allKidsActionSelect.value == 'Edit') {
                                            // await .unfriendUserRequest();
                                          }
                                          if (_kidsController.allKidsActionSelect.value == 'Delete') {
                                            await _kidsController.kidDelete();
                                          }
                                          _kidsController.allKidsActionSelect.value == '';
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
                      // if (_friendController.friendList.isNotEmpty && !_friendController.friendListScrolled.value)
                      //   const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _AllKidsActionContent extends StatelessWidget {
  const _AllKidsActionContent({Key? key, required this.kidsController}) : super(key: key);

  final KidsController kidsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: kidsController.allKidsActionList.length,
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
                      kidsController.allKidsActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: kidsController.allKidsActionList[index]['action'],
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subtitle: kidsController.allKidsActionList[index]['actionSubtitle'],
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      kidsController.allKidsActionSelect.value = kidsController.allKidsActionList[index]['action'];
                    },
                    isSelected: kidsController.allKidsActionSelect.value == kidsController.allKidsActionList[index]['action'],
                  ),
                  itemColor: kidsController.allKidsActionSelect.value == kidsController.allKidsActionList[index]['action'] ? cPrimaryTint3Color : cWhiteColor,
                  onPressed: () {
                    kidsController.allKidsActionSelect.value = kidsController.allKidsActionList[index]['action'];
                    // if (friendController.pendingFriendFollowStatus.value == 1) {
                    //   friendController.pendingFriendActionSelect.value = friendController.pendingFriendActionList[index]['action'];
                    // } else if (friendController.pendingFriendFollowStatus.value == 0) {
                    //   friendController.pendingFriendActionSelect.value = friendController.pendingFollowFriendActionList[index]['action'];
                    // }
                    if (kidsController.allKidsActionSelect.value == '') {
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

//*All kids shimmer
class AllKidsShimmer extends StatelessWidget {
  const AllKidsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding, vertical: k12Padding).copyWith(bottom: k0Padding),
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
