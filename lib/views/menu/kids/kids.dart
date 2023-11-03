import 'package:bip_hip/controllers/menu/kids_controller.dart';
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
                    onPressed: () async {
                      // Get.toNamed(krAddFriend);
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Text(
                  '${ksTotalKids.tr}: ${_kidsController.totalKidsCount.value}',
                  style: semiBold14TextStyle(cBlackColor),
                ),
              ),
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
    return Expanded(
      child: SingleChildScrollView(
        // controller: _friendController.friendListScrollController,
        // physics: const AlwaysScrollableScrollPhysics(),
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
                              _globalController.commonBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                content: Container(),
                                onPressRightButton: () {},
                                // content: _FriendActionContent(
                                //       profileController: _profileController,
                                //       friendController: _friendController,
                                //     ),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                //     onPressRightButton: () async {
                                //       _friendController.userId.value = _friendController.friendList[index].id!;
                                //       Get.back();
                                //       if (_profileController.friendActionSelect.value == 'Unfriend') {
                                //         await _friendController.unfriendUserRequest();
                                //       }
                                //       if (_profileController.friendActionSelect.value == 'Unfollow') {
                                //         await _friendController.unfollowUser();
                                //       }
                                //       if (_profileController.friendActionSelect.value == 'Follow') {
                                //         await _friendController.followUser();
                                //       }
                                //       _profileController.friendActionSelect.value = '';
                                //     },
                                rightText: ksDone.tr,
                                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                title: ksAction.tr,
                                isRightButtonShow: true,
                                bottomSheetHeight: 250,
                              );
                            },
                            // },
                            // onPress: () {
                            //   _profileController.friendActionSelect.value = '';
                            //   _friendController.allFriendFollowStatus.value = _friendController.friendList[index].followStatus!;
                            //   if (_profileController.friendActionSelect.value == '') {
                            //     _globalController.isBottomSheetRightButtonActive.value = false;
                            //   } else {
                            //     _globalController.isBottomSheetRightButtonActive.value = true;
                            //   }
                            //   _globalController.commonBottomSheet(
                            //     context: context,
                            //     isScrollControlled: true,
                            //     content: _FriendActionContent(
                            //       profileController: _profileController,
                            //       friendController: _friendController,
                            //     ),
                            //     onPressCloseButton: () {
                            //       Get.back();
                            //     },
                            //     onPressRightButton: () async {
                            //       _friendController.userId.value = _friendController.friendList[index].id!;
                            //       Get.back();
                            //       if (_profileController.friendActionSelect.value == 'Unfriend') {
                            //         await _friendController.unfriendUserRequest();
                            //       }
                            //       if (_profileController.friendActionSelect.value == 'Unfollow') {
                            //         await _friendController.unfollowUser();
                            //       }
                            //       if (_profileController.friendActionSelect.value == 'Follow') {
                            //         await _friendController.followUser();
                            //       }
                            //       _profileController.friendActionSelect.value = '';
                            //     },
                            //     rightText: ksDone.tr,
                            //     rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                            //     title: ksAction.tr,
                            //     isRightButtonShow: true,
                            //     bottomSheetHeight: 250,
                            //   );
                            // },
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
    );
  }
}
