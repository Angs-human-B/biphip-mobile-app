import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PostUpperContainer extends StatelessWidget {
  const PostUpperContainer({
    super.key,
    required this.userName,
    required this.isCategorized,
    this.category,
    this.categoryIcon,
    this.categoryIconColor,
    required this.privacy,
    this.brandName,
    this.kidName,
    this.kidAge,
    required this.postTime,
    this.title,
    this.price,
    this.subCategory,
    required this.userImage,
    this.secondaryImage,
    required this.taggedFriend,
  });

  final String userName, postTime, userImage;
  final String? category, brandName, kidName, kidAge, title, price, subCategory, secondaryImage;
  final IconData? categoryIcon;
  final IconData privacy;
  final Color? categoryIconColor;
  final bool isCategorized;
  final List<TaggedFriend>? taggedFriend;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: (secondaryImage != null) ? 70 : h44,
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      height: h44,
                      width: h44,
                      decoration: const BoxDecoration(
                        color: cBlackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        userImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          BipHip.user,
                          size: kIconSize24,
                          color: cIconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (secondaryImage != null)
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: ClipOval(
                  child: Container(
                    height: h45,
                    width: h45,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                    child: Image.network(
                      secondaryImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.user,
                        size: kIconSize24,
                        color: cIconColor,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        kW8sizedBox,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: RichText(
                        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        maxLines: 3,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style.copyWith(height: 1.4),
                          children: [
                            TextSpan(
                              text: userName,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                            if (category != null)
                              TextSpan(
                                text: ' ${ksPostedOn.tr} ',
                                style: regular16TextStyle(cSmallBodyTextColor),
                              ),
                            if (category != null)
                              WidgetSpan(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Icon(
                                        categoryIcon,
                                        color: categoryIconColor,
                                        size: kIconSize14,
                                      ),
                                    ),
                                    if (category != null)
                                      Text(
                                        " ${category!}",
                                        style: semiBold14TextStyle(categoryIconColor!),
                                      ),
                                  ],
                                ),
                              ),
                            if (subCategory != null)
                              TextSpan(
                                text: ' ${ksAt.tr} ',
                                style: regular16TextStyle(cSmallBodyTextColor),
                              ),
                            if (subCategory != null)
                              TextSpan(
                                text: '($subCategory)',
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                            if (taggedFriend!.isNotEmpty)
                              TextSpan(
                                text: ' ${ksWith.tr} ',
                                style: regular16TextStyle(cSmallBodyTextColor),
                              ),
                            if (taggedFriend!.isNotEmpty)
                              TextSpan(
                                text: '${taggedFriend![0].fullName}',
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                            if (taggedFriend!.isNotEmpty && taggedFriend!.length == 2)
                              TextSpan(
                                text: ' & ${taggedFriend?[1].fullName}',
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                            if (taggedFriend!.isNotEmpty && taggedFriend!.length > 2)
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    Get.find<GlobalController>().commonBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        bottomSheetHeight: taggedFriend!.length > 10 ? height * 0.6 : null,
                                        content: TaggedFriendContent(
                                          taggedFriend: taggedFriend!,
                                        ),
                                        onPressCloseButton: () {
                                          Get.back();
                                        },
                                        onPressRightButton: () {},
                                        rightText: ksDone.tr,
                                        rightTextStyle: regular14TextStyle(cPrimaryColor),
                                        title: ksTaggedFreinds.tr,
                                        isRightButtonShow: false);
                                  },
                                  child: Text(
                                    ' & ${taggedFriend!.length - 1} others',
                                    style: semiBold16TextStyle(cBlackColor),
                                  ),
                                ),
                              ),
                            const TextSpan(text: '\n'),
                            WidgetSpan(
                              baseline: TextBaseline.alphabetic,
                              alignment: PlaceholderAlignment.baseline,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Icon(
                                  privacy,
                                  color: cIconColor,
                                  size: kIconSize12,
                                ),
                              ),
                            ),
                            if (category == 'Selling' && isCategorized && brandName != null)
                              TextSpan(text: ' ($brandName)', style: semiBold14TextStyle(cBlackColor)),
                            if (category == 'Kids' && isCategorized && kidName != null)
                              TextSpan(text: ' ($kidName, $kidAge)', style: semiBold14TextStyle(cBlackColor)),
                            TextSpan(text: ' $postTime', style: regular14TextStyle(cSmallBodyTextColor))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TaggedFriendContent extends StatelessWidget {
  const TaggedFriendContent({super.key, required this.taggedFriend});
  final List<TaggedFriend> taggedFriend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taggedFriend.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                leading: Container(
                  height: h26,
                  width: h26,
                  decoration: const BoxDecoration(
                    color: cWhiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      taggedFriend[index].profilePicture.toString(),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.user,
                        size: kIconSize24,
                        color: cIconColor,
                      ),
                      // loadingBuilder: imageLoadingBuilder,
                    ),
                  ),
                ),
                title: taggedFriend[index].fullName,
              );
            })
      ],
    );
  }
}
