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
          },
          action: [
            Padding(
              padding: const EdgeInsets.only(right: k20Padding),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () {
                  unFocus(context);
                },
                child: Text(
                  ksDone.tr,
                  style: semiBold16TextStyle(cPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              kH16sizedBox,
              SizedBox(
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
                                        return CustomListTile(
                                          padding: const EdgeInsets.only(left: k8Padding, top: k8Padding, bottom: k8Padding),
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
                                          // trailing: Obx(() => SizedBox(
                                          //       width: 32,
                                          //       child: CustomCheckBox(
                                          //           value: selfieController.isPeopleSelect.value,
                                          //           label: "",
                                          //           onChanged: (v) {
                                          //             selfieController.isPeopleSelect.value = !selfieController.isPeopleSelect.value;
                                          //           },
                                          //           textStyle: regular14TextStyle(cBlackColor)),
                                          //     )),
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
                                    child: EmptyView(
                                        title: friendController.allFriendCount.value == 0 ? ksNoFriendAddedYet.tr : ksNoSearchedFriendsAvailable.tr)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
