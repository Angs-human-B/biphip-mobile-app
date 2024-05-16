import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';

class SelectPeoplePage extends StatelessWidget {
  SelectPeoplePage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();
  final FriendController friendController = Get.find<FriendController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksSelectPeople.tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
            ll(selfieController.customPeopleNames);
            ll(selfieController.customPeopleIds);
          },
          // action: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: k20Padding),
          //     child: TextButton(
          //       style: kTextButtonStyle,
          //       onPressed: () {
          //         Get.back();
          //       },
          //       child: Text(
          //         ksDone.tr,
          //         style: semiBold16TextStyle(cPrimaryColor),
          //       ),
          //     ),
          //   ),
          // ],
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            kH16sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: SizedBox(
                height: h50,
                child: CustomModifiedTextField(
                  controller: selfieController.selectPeopleTextEditingController,
                  prefixIcon: BipHip.search,
                  contentPadding: const EdgeInsets.all(k8Padding),
                  hint: ksSearch.tr,
                  suffixIcon: selfieController.isSelectPeopleCrossShow.value ? BipHip.circleCrossNew : null,
                  onChanged: (value) {
                    selfieController.selectPeopleTextEditingController.text = value;
                    if (selfieController.selectPeopleTextEditingController.text.toString().trim() != "") {
                      selfieController.isSelectPeopleCrossShow.value = true;
                    } else {
                      selfieController.isSelectPeopleCrossShow.value = false;
                    }
                  },
                  onSuffixPress: () {
                    selfieController.selectPeopleTextEditingController.text = "";
                    selfieController.isSelectPeopleCrossShow.value = false;
                  },
                ),
              ),
            ),
            Obx(
              () => (friendController.isFriendListLoading.value)
                  ? const AllPendingFriendShimmer()
                  : friendController.friendList.isNotEmpty
                      ? NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (friendController.friendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                !friendController.friendListScrolled.value) {
                              friendController.friendListScrolled.value = true;
                              if (friendController.friendList.isNotEmpty) {
                                friendController.getMoreFriendList(null);
                              }
                              if (friendController.friendList.isNotEmpty && friendController.isFriendSearched.value) {
                                friendController.getMoreFriendSearchList(null);
                              }
                              return true;
                            }
                            return false;
                          },
                          child: Expanded(
                            child: SingleChildScrollView(
                              controller: friendController.friendListScrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    itemCount: friendController.friendList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => kH16sizedBox,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                        child: InkWell(
                                          onTap: () {
                                            selfieController.isCustomPeopleSelected[index] = !selfieController.isCustomPeopleSelected[index];
                                            if (selfieController.isCustomPeopleSelected[index]) {
                                              selfieController.customPeopleNames.add(friendController.friendList[index].fullName);
                                              selfieController.customPeopleIds.add(friendController.friendList[index].id);
                                            } else {
                                              selfieController.customPeopleNames.remove(friendController.friendList[index].fullName);
                                              selfieController.customPeopleIds.remove(friendController.friendList[index].id);
                                            }
                                          },
                                          child: CustomListTile(
                                            // padding: const EdgeInsets.only(left: k8Padding, top: k8Padding, bottom: k8Padding),
                                            // borderColor: cLineColor,
                                            leading: Container(
                                              height: h40,
                                              width: h40,
                                              decoration: const BoxDecoration(
                                                color: cWhiteColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipOval(
                                                child: Image.network(
                                                  friendController.friendList[index].profilePicture.toString(),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(kiProfileDefaultImageUrl);
                                                  },
                                                  loadingBuilder: imageLoadingBuilder,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              friendController.friendList[index].fullName ?? ksNA.tr,
                                              style: semiBold16TextStyle(cBlackColor),
                                            ),
                                            trailing: Obx(() => SizedBox(
                                                  width: 32,
                                                  child: CustomCheckBox(
                                                      value: selfieController.isCustomPeopleSelected[index],
                                                      label: "",
                                                      onChanged: (v) {
                                                        selfieController.isCustomPeopleSelected[index] = !selfieController.isCustomPeopleSelected[index];
                                                        if (selfieController.isCustomPeopleSelected[index]) {
                                                          selfieController.customPeopleNames.add(friendController.friendList[index].fullName);
                                                          selfieController.customPeopleIds.add(friendController.friendList[index].id);
                                                        } else {
                                                          selfieController.customPeopleNames.remove(friendController.friendList[index].fullName);
                                                          selfieController.customPeopleIds.remove(friendController.friendList[index].id);
                                                        }
                                                      },
                                                      textStyle: regular14TextStyle(cBlackColor)),
                                                )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  if (friendController.friendList.isNotEmpty &&
                                      friendController.friendListScrolled.value &&
                                      friendController.friendListSubLink.value != null)
                                    const Center(child: CircularProgressIndicator()),
                                ],
                              ),
                            ),
                          ))
                      : Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                  alignment: Alignment.center,
                                  child:
                                      EmptyView(title: friendController.allFriendCount.value == 0 ? ksNoFriendAddedYet.tr : ksNoSearchedFriendsAvailable.tr)))),
            ),
          ],
        ),
      ),
    );
  }
}
