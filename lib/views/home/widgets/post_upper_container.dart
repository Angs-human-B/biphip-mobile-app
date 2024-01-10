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
  });

  final String userName, postTime, userImage;
  final String? category, brandName, kidName, kidAge, title, price, subCategory, secondaryImage;
  final IconData? categoryIcon;
  final IconData privacy;
  final Color? categoryIconColor;
  final bool isCategorized;

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
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        userImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          BipHip.imageFile,
                          size: kIconSize120,
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
                      Environment.imageBaseUrl + secondaryImage!,
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
                            if (isCategorized)
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
                            if (category != null)
                              TextSpan(
                                text: ' ${ksAt.tr} ',
                                style: regular16TextStyle(cSmallBodyTextColor),
                              ),
                            if (category != null)
                              TextSpan(
                                text: '($subCategory)',
                                style: semiBold16TextStyle(cBlackColor),
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
