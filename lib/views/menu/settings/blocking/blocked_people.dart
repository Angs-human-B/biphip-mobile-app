import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/menu/friend/friend_helper.dart';
import 'package:bip_hip/shimmers/menu/friends/add_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/widgets/friend_family_single_button_action.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/rendering.dart';

import '../../../../widgets/common/button/custom_tapable_container.dart';
import '../../../../widgets/common/utils/custom_bottom_nav.dart';

class BlockedPeople extends StatelessWidget {
  String title;
  BlockedPeople(this.title,{super.key});
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
                  preferredSize: Size.fromHeight(kAppBarSizeSetting),
                  child: CustomAppBar(
                    onBack: () {
                      Get.back();
                    },
                    title: title,
                  ),
                ),

                body: Obx(
                      () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              friendHelper.friendSearchReset();
                            },
                            onSubmit: (v) {
                              unfocus(context);
                              friendController.isFriendSuffixIconVisible.value = false;
                            },
                            onChanged: (v) {
                              friendHelper.searchFriends();
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
                                : Normalext('All blocked user', color: Colors.grey,)),
                      if (globalController.tapAbleButtonState[0] || globalController.tapAbleButtonState[1]) kH12sizedBox,
                      if (globalController.tapAbleButtonState[2]) kH4sizedBox,
                      //*All friend, Receive friend request and Pending friend request ui
                      friendHelper.blockedListView(title),
                    ],
                  ),
                ),
              ),
            ),
            if (friendController.isFriendViewLoading.value || friendController.isCancelFriendRequestLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (friendController.isFriendViewLoading.value || friendController.isCancelFriendRequestLoading.value) {
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
