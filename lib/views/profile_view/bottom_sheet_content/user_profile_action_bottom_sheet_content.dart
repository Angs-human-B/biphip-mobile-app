import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/common_list_tile.dart';

class UserProfileActionBottomSheetContent extends StatelessWidget {
  const UserProfileActionBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Get.find<ProfileViewController>().isKidOrStoreProfile.value == false)
          CommonListTile(
            titleText: ksUnfollow.tr,
            subTitleText: ksUnfollowFromYourFollowersList.tr,
            leadingIcon: BipHip.unFollow,
            onPressed: () {
              Get.back();
            },
          ),
        if (Get.find<ProfileViewController>().isKidOrStoreProfile.value == false)
          CommonListTile(
            titleText: ksUnFriend.tr,
            subTitleText: ksRemoveFromYourFriendList.tr,
            leadingIcon: BipHip.unfriend,
            onPressed: () {
              Get.back();
            },
          ),
        CommonListTile(
          titleText: ksReportProfile.tr,
          subTitleText: ksReportThisProfile.tr,
          leadingIcon: BipHip.report,
          onPressed: () {
            Get.back();
          },
        ),
        CommonListTile(
          titleText: ksBlock.tr,
          subTitleText: ksBlockFromYourFriendList.tr,
          leadingIcon: BipHip.removeFamily, //!Block icon
          onPressed: () {
            Get.back();
          },
        ),
        CommonListTile(
          titleText: ksCopyLink.tr,
          subTitleText: ksCopyThisProfileLink.tr,
          leadingIcon: BipHip.addLink,
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
