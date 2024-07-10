import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_friends_gridview.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class ProfileViewFriendFamilyWidget extends StatelessWidget {
  ProfileViewFriendFamilyWidget({super.key});
  final FriendController friendController = Get.find<FriendController>();
  final FamilyController familyController = Get.find<FamilyController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          friendController.isFriendListLoading.value
              ? const FriendFamilyGridViewShimmer()
              : friendController.friendList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: k16Padding),
                      child: Container(
                        width: width - 40,
                        height: 60,
                        decoration: BoxDecoration(border: Border.all(width: 1, color: cLineColor), borderRadius: BorderRadius.circular(k4BorderRadius)),
                        child: EmptyView(title: ksNoFriendAddedYet.tr),
                      ),
                    )
                  : FriendsFamilyGridView(
                      header: ksFriends.tr,
                      count: friendController.allFriendCount.toString(),
                      friendList: friendController.friendList,
                      isFriendFamilySeeAllShowHide: friendController.friendList.length > 3 ? true : false,
                      seeAllOnPressed: () {
                        Get.toNamed(krProfileViewFriend);
                      },
                    ),
          kH16sizedBox,
          Container(
            height: h8,
            color: cBackgroundColor,
          ),
          // kH16sizedBox,
          familyController.isFamilyListLoading.value
              ? const FriendFamilyGridViewShimmer()
              : familyController.familyList.isEmpty
                  ? Container(
                      width: width - 40,
                      height: 60,
                      decoration: BoxDecoration(border: Border.all(width: 1, color: cLineColor), borderRadius: BorderRadius.circular(k4BorderRadius)),
                      child: EmptyView(title: ksNoFamilyAddedYet.tr),
                    )
                  : FriendsFamilyGridView(
                      header: ksFamily.tr,
                      count: familyController.allFamilyCount.toString(),
                      friendList: familyController.familyList,
                      isFriendFamilySeeAllShowHide: familyController.familyList.length > 3 ? true : false,
                      seeAllOnPressed: () {
                        Get.toNamed(krProfileViewFamily);
                      },
                    ),
        ],
      ),
    );
  }
}

class FriendsFamilyGridView extends StatelessWidget {
  const FriendsFamilyGridView(
      {super.key, required this.header, required this.count, this.seeAllOnPressed, required this.friendList, required this.isFriendFamilySeeAllShowHide});

  final String header;
  final String count;
  final VoidCallback? seeAllOnPressed;
  final List<FriendFamilyUserData> friendList;
  final bool isFriendFamilySeeAllShowHide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Obx(() => Column(
            children: [
              kH12sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: header,
                          style: semiBold18TextStyle(cBlackColor),
                        ),
                        TextSpan(
                          text: '   $count ${header.toLowerCase()}',
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                      ],
                    ),
                  ),
                  if (isFriendFamilySeeAllShowHide)
                    CustomTextButton(onPressed: seeAllOnPressed, text: ksSeeAll.tr, textStyle: semiBold14TextStyle(cPrimaryColor)),
                ],
              ),
              kH12sizedBox,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: friendList.length <= 3 ? friendList.length : 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: isDeviceScreenLarge() ? 0.75 : 0.8,
                  crossAxisCount: 3,
                  crossAxisSpacing: k10Padding,
                  mainAxisSpacing: k4Padding,
                ),
                itemBuilder: (BuildContext context, int index) {
                  var item = friendList[index];
                  return CustomGridViewContainer(
                    item: item,
                  );
                },
              ),
            ],
          )),
    );
  }
}
