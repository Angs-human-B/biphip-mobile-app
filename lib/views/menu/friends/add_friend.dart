import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/menu/friend/friend_helper.dart';
import 'package:bip_hip/shimmers/menu/friends/add_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/menu/common/friend_family_single_button_action.dart';
import 'package:flutter/rendering.dart';

class AddFriend extends StatelessWidget {
  AddFriend({super.key});
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
                    title: ksAddFriend.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      unFocus(context);
                      friendHelper.addFriendBackButtonPressed();
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
                        controller: Get.find<GlobalController>().searchController,
                        prefixIcon: BipHip.search,
                        suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                        hint: ksSearch.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                        textInputStyle: regular16TextStyle(cBlackColor),
                        onSuffixPress: () {
                          friendHelper.addFriendSuffixPressed();
                        },
                        onSubmit: (v) {
                          unfocus(context);
                          friendController.isFriendSuffixIconVisible.value = false;
                        },
                        onChanged: (v) {
                          friendHelper.addFriendOnChanged();
                        },
                      ),
                      kH8sizedBox,
                      Obx(
                        () => friendController.isAddFriendRequestListLoading.value
                            ? const AddFriendShimmer()
                            : NotificationListener<ScrollNotification>(
                                onNotification: (scrollNotification) {
                                  if (friendController.addFriendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                      scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                      !friendController.addFriendListScrolled.value) {
                                    friendController.addFriendListScrolled.value = true;
                                    if (friendController.addFriendRequestList.isNotEmpty) {
                                      friendController.getMoreAddFriendRequestList(null);
                                    }
                                    return true;
                                  }
                                  return false;
                                },
                                child: Expanded(
                                  child: SingleChildScrollView(
                                    controller: friendController.addFriendListScrollController,
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: friendController.addFriendRequestList.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: k10Padding),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(k8BorderRadius),
                                                child: Obx(
                                                  () => FriendFamilySingleButtonAction(
                                                    backgroundImage:
                                                        Environment.imageBaseUrl + friendController.addFriendRequestList[index].profilePicture.toString(),
                                                    name: friendController.addFriendRequestList[index].fullName ?? ksNA.tr,
                                                    buttonText:
                                                        friendController.addFriendRequestList[index].friendStatus == 0 ? ksSendRequest.tr : ksCancelRequest.tr,
                                                    buttonColor: friendController.addFriendRequestList[index].friendStatus == 0 ? cPrimaryColor : cWhiteColor,
                                                    borderColor: friendController.addFriendRequestList[index].friendStatus == 0 ? null : cRedColor,
                                                    textStyle: friendController.addFriendRequestList[index].friendStatus == 0
                                                        ? semiBold14TextStyle(cWhiteColor)
                                                        : semiBold14TextStyle(cRedColor),
                                                    buttonOnPressed: () {
                                                      friendHelper.addFriendOnPressed(index: index);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        if (friendController.addFriendRequestList.isNotEmpty && !friendController.addFriendListScrolled.value)
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
            if (friendController.isSendFriendRequestLoading.value || friendController.isCancelFriendRequestLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (friendController.isSendFriendRequestLoading.value || friendController.isCancelFriendRequestLoading.value) {
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
