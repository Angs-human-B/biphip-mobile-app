
import 'package:bip_hip/utils/constants/imports.dart';

class SearchVideosContent extends StatelessWidget {
  const SearchVideosContent({
    super.key,
    this.image,
    required this.title,
    this.name,
    this.onPressed,
    this.date,
    this.totalView,
    this.time,
  });
  final String? image;
  final String title;
  final String? name;
  final String? date;
  final String? totalView;
  final String? time;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: SizedBox(
                    width: 120,
                    height: 90,
                    child: Image.network(
                      image ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.imageFile,
                        size: kIconSize70,
                        color: cIconColor,
                      ),
                      loadingBuilder: imageLoadingBuilder,
                    ),
                  ),
                ),
                Positioned(
                  right: h10,
                  bottom: h10,
                  child: Text(
                    time ?? ksNA.tr,
                    style: semiBold12TextStyle(cWhiteColor),
                  ),
                ),
              ],
            ),
          kW12sizedBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: semiBold18TextStyle(cBlackColor),
                  overflow: TextOverflow.clip,
                ),
                kH8sizedBox,
                Text(
                  name ?? ksNA.tr,
                  style: regular16TextStyle(cSmallBodyTextColor),
                  textAlign: TextAlign.left,
                ),
                kH8sizedBox,
                Row(
                  children: [
                    Text(
                      date ?? ksNA.tr,
                      style: regular12TextStyle(cSmallBodyTextColor),
                    ),
                    kW4sizedBox,
                    Text(
                      totalView ?? ksNA.tr,
                      style: regular12TextStyle(cSmallBodyTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

