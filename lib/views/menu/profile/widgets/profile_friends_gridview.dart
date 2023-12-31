import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorBuilder.dart';

class FriendFamilyTab extends StatelessWidget {
  FriendFamilyTab({super.key});
  final FamilyController familyController = Get.find<FamilyController>();
  final FriendController friendController = Get.find<FriendController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: cWhiteColor,
          child: FriendsFamilyGridView(
            header: ksFriends.tr,
            count: friendController.friendList.length.toString(),
            friendList: friendController.friendList,
            loading: friendController.isFriendListLoading,
          ),
        ),
        kH12sizedBox,
        if (familyController.familyList.isNotEmpty)
          Container(
            color: cWhiteColor,
            child: FriendsFamilyGridView(
              header: ksFamily.tr,
              count: familyController.familyList.length.toString(),
              friendList: familyController.familyList,
              loading: familyController.isFamilyListLoading,
            ),
          ),
      ],
    );
  }
}

class FriendsFamilyGridView extends StatelessWidget {
  const FriendsFamilyGridView({super.key, required this.header, required this.count, this.seeAll, required this.friendList, required this.loading});

  final String header;
  final String count;
  final VoidCallback? seeAll;
  final List<FriendFamilyUserData> friendList;
  final RxBool loading;

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
                  loading.value
                      ? ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 18,
                            width: 100,
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: header,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              TextSpan(
                                text: '   $count ${header.toLowerCase()}',
                                style: regular12TextStyle(cSmallBodyTextColor),
                              )
                            ],
                          ),
                        ),
                  CustomTextButton(onPressed: seeAll, text: ksSeeAll.tr, textStyle: semiBold14TextStyle(cPrimaryColor)),
                ],
              ),
              kH12sizedBox,
              loading.value
                  ? const FriendFamilyGridViewShimmer()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: friendList.length <= 6 ? friendList.length : 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .8,
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
                item.profilePicture!,
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
    return GridView.builder(
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
    );
  }
}
