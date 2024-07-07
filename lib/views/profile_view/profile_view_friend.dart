import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/widgets/friend_family_single_button_action.dart';

class ProfileViewFriend extends StatelessWidget {
  ProfileViewFriend({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final FriendController friendController = Get.find<FriendController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: Scaffold(
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
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: SizedBox(
                height: height - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH16sizedBox,
                    Text(
                      "${ksTotalFriends.tr}: 557",
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                    kH16sizedBox,
                    CustomModifiedTextField(
                        borderRadius: h8,
                        controller: profileViewController.friendSearchController,
                        prefixIcon: BipHip.search,
                        // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,//! use it later
                        // suffixIcon: friendController.isFriendSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                        hint: ksSearch.tr,
                        contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                        textInputStyle: regular16TextStyle(cBlackColor),
                        onSuffixPress: () {
                          // friendHelper.friendSearchReset();//!craete a new function
                        },
                        onSubmit: (v) {
                          unfocus(context);
                          // friendController.isFriendSuffixIconVisible.value = false;//!Use it later
                        },
                        onChanged: (v) {
                          // friendHelper.searchFriends();//!craete a new function
                        }),
                    Expanded(
                      child: SingleChildScrollView(
                        // controller: .sendFamilyListScrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH16sizedBox,
                            Text(
                              ksMutualFriend.tr,
                              style: semiBold14TextStyle(cBlackColor),
                            ),
                            kH8sizedBox,
                            ListView.separated(
                              itemCount: friendController.friendList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                  child: FriendFamilySingleButtonAction(
                                    backgroundImage: friendController.friendList[index].profilePicture.toString(),
                                    imageSize: h45,
                                    name: friendController.friendList[index].fullName ?? ksNA.tr,
                                    subTitle: "${friendController.friendList[index].mutualFriend.toString()} mutual Friend",
                                    buttonText: ksMessage.tr,
                                    buttonOnPressed: () async {
                                      // familyController.userId.value = familyController.sendFamilyRequestList[index].id!;
                                      // await familyController.cancelFamilyRequest();
                                    },
                                    buttonColor: cPrimaryColor,
                                    textStyle: semiBold12TextStyle(cWhiteColor),
                                  ),
                                );
                              },
                            ),
                            kH16sizedBox,
                            Text(
                              ksAllFriend.tr,
                              style: semiBold14TextStyle(cBlackColor),
                            ),
                            kH8sizedBox,
                            ListView.separated(
                              itemCount: friendController.friendList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                  child: FriendFamilySingleButtonAction(
                                    backgroundImage: friendController.friendList[index].profilePicture.toString(),
                                    imageSize: h45,
                                    name: friendController.friendList[index].fullName ?? ksNA.tr,
                                    subTitle: "${friendController.friendList[index].mutualFriend.toString()} mutual Friend",
                                    buttonText: ksAddFriend.tr,
                                    buttonOnPressed: () async {
                                      // familyController.userId.value = familyController.sendFamilyRequestList[index].id!;
                                      // await familyController.cancelFamilyRequest();
                                    },
                                    buttonColor: cPrimaryColor,
                                    textStyle: semiBold12TextStyle(cWhiteColor),
                                  ),
                                );
                              },
                            ),
                            kH16sizedBox,
                            if (friendController.friendList.isNotEmpty &&
                                friendController.friendListScrolled.value &&
                                friendController.friendListSubLink.value != null)
                              const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),

                    // Column(
                    //   children: [

                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
