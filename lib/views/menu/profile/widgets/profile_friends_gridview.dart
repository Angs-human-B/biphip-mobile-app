import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorbuilder.dart';

class FriendFamilyTab extends StatelessWidget {
  FriendFamilyTab({super.key});
  final FamilyController familyController = Get.find<FamilyController>();
  final FriendController friendController = Get.find<FriendController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: cWhiteColor,
            child: friendController.isFriendListLoading.value
                ? const FriendFamilyGridViewShimmer()
                : FriendsFamilyGridView(
                    header: ksFriends.tr,
                    count: friendController.allFriendCount.toString(),
                    friendList: friendController.friendList,
                    isFriendFamilySeeAllShowHide: friendController.friendList.length > 6 ? true : false,
                    seeAll: () {
                      Get.toNamed(krFriends);
                    },
                  ),
          ),
          kH12sizedBox,
          familyController.isFamilyListLoading.value
              ? const FriendFamilyGridViewShimmer()
              : Container(
                  color: cWhiteColor,
                  child: FriendsFamilyGridView(
                    header: ksFamily.tr,
                    count: familyController.allFamilyCount.toString(),
                    friendList: familyController.familyList,
                    isFriendFamilySeeAllShowHide: familyController.familyList.length > 6 ? true : false,
                    seeAll: () {
                      Get.toNamed(krFamily);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class FriendsFamilyGridView extends StatelessWidget {
  const FriendsFamilyGridView(
      {super.key, required this.header, required this.count, this.seeAll, required this.friendList, required this.isFriendFamilySeeAllShowHide});

  final String header;
  final String count;
  final VoidCallback? seeAll;
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
                  if (isFriendFamilySeeAllShowHide) CustomTextButton(onPressed: seeAll, text: ksSeeAll.tr, textStyle: semiBold14TextStyle(cPrimaryColor)),
                ],
              ),
              kH12sizedBox,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: friendList.length <= 6 ? friendList.length : 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: isDeviceScreenLarge() ? 0.7 : 0.8,
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

class CustomGridViewContainer extends StatelessWidget {
  const CustomGridViewContainer({Key? key, required this.item}) : super(key: key);

  final FriendFamilyUserData item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: k8CircularBorderRadius,
            child: Container(
              color: cBlackColor,
              height: 100,
              width: ((width - 72) / 3),
              child: Image.network(
                item.profilePicture.toString(),
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: cBlackColor,
                  child: const CommonImageErrorBuilder(
                    icon: BipHip.user,
                    iconSize: kIconSize60,
                  ),
                ),
                loadingBuilder: imageLoadingBuilderCover,
              ),
            ),
          ),
          kH4sizedBox,
          Text(
            item.fullName!,
            style: semiBold14TextStyle(cBlackColor),
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class FriendFamilyGridViewShimmer extends StatelessWidget {
  const FriendFamilyGridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kH12sizedBox,
          ShimmerCommon(
            widget: Container(
              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
              height: 18,
              width: 100,
            ),
          ),
          // kH12sizedBox,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 3,
              crossAxisSpacing: k10Padding,
              mainAxisSpacing: k4Padding,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerCommon(
                      widget: Container(
                        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        height: 100,
                        width: (width - 72) / 3,
                      ),
                    ),
                    kH4sizedBox,
                    ShimmerCommon(
                      widget: Container(
                        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        height: 16,
                        width: 60,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
