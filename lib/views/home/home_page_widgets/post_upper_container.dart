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
  });

  final String userName, postTime;
  final String? category, brandName, kidName, kidAge, title, price;
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
              width: (category == "Kids" || category == "Selling") ? 70 : h44,
              child: Row(
                children: [
                  Container(
                    height: h44,
                    width: h44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      kiProfileDefaultImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            if (category == "Kids" || category == "Selling")
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: Container(
                  height: h45,
                  width: h45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    kiProfileDefaultImageUrl,
                    fit: BoxFit.fill,
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
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        maxLines: 3,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: userName,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                            if (isCategorized)
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
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Icon(
                                        categoryIcon,
                                        color: categoryIconColor,
                                        size: kIconSize16,
                                      ),
                                    ),
                                    if (isCategorized)
                                      Text(
                                        " ${category!}",
                                        style: semiBold14TextStyle(categoryIconColor!),
                                      )
                                  ],
                                ),
                              ),
                            const TextSpan(text: '\n'),
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Icon(
                                  privacy,
                                  color: cIconColor,
                                  size: kIconSize14,
                                ),
                              ),
                            ),
                            if (category == 'Selling' && isCategorized) TextSpan(text: ' ($brandName)', style: semiBold14TextStyle(cBlackColor)),
                            if (category == 'Kids' && isCategorized) TextSpan(text: ' ($kidName, $kidAge)', style: semiBold14TextStyle(cBlackColor)),
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
