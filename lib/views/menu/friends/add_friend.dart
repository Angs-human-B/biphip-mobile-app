import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/friend_helpers/friend_helper.dart';
import 'package:bip_hip/shimmer_views/friends/add_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/menu/friends_family/friend_family_single_button_action.dart';
import 'package:flutter/rendering.dart';

class AddFriend extends StatelessWidget {
  AddFriend({super.key});
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
                    title: ksAddFriend.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      unFocus(context);
                      _friendHelper.addFriendBackButtonPressed();
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
                        suffixIcon: _friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                        hint: ksSearch.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                        textInputStyle: regular16TextStyle(cBlackColor),
                        onSuffixPress: () {
                          _friendHelper.addFriendSuffixPressed();
                        },
                        onSubmit: (v) {
                          unfocus(context);
                          _friendController.isFriendSuffixIconVisible.value = false;
                        },
                        onChanged: (v) {
                          _friendHelper.addFriendOnChanged();
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
                                                  () => FriendFamilySingleButtonAction(
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
                                                    buttonOnPressed: () {
                                                      _friendHelper.addFriendOnPressed(index: index);
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
