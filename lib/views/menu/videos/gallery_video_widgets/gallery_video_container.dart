
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryVideoContainer extends StatelessWidget {
  const GalleryVideoContainer({super.key, required this.title, required this.subTitle, required this.video1, this.video2, this.video3, this.onPressed});
  final String title;
  final String subTitle;
  final String video1;
  final String? video2;
  final String? video3;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
          data: ThemeData(
            splashColor: cTransparentColor,
            highlightColor: cTransparentColor,
          ),
          child: InkWell(
            onTap: onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
                    child: SizedBox(
                      width: (width - 50) / 2,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 92,
                            width: (video2 == null && video3 == null) ? (width - 52) / 2 : (width - 52) / 4,
                            child: Image.network(
                              video1,
                              fit: BoxFit.cover,
                              color: cBlackColor.withOpacity(0.5),
                              colorBlendMode: BlendMode.multiply,
                            ),
                          ),
                          (video2 != null || video3 != null)
                              ? const SizedBox(
                                  width: 1,
                                )
                              : const SizedBox(),
                          Column(
                            children: [
                              video2 != null
                                  ? SizedBox(
                                      height: video3 == null ? 92 : 45.5,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        video2!,
                                        fit: BoxFit.cover,
                                        color: cBlackColor.withOpacity(0.5),
                                        colorBlendMode: BlendMode.multiply,
                                      ),
                                    )
                                  : const SizedBox(),
                              (video2 != null && video3 != null)
                                  ? const SizedBox(
                                      height: 1,
                                    )
                                  : const SizedBox(),
                              video3 != null
                                  ? SizedBox(
                                      height: video2 == null ? 92 : 45.5,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        video3!,
                                        fit: BoxFit.cover,
                                        color: cBlackColor.withOpacity(0.5),
                                        colorBlendMode: BlendMode.multiply,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Container(
                  width: (width - 50) / 2,
                  decoration: BoxDecoration(
                    color: cWhiteColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    border: Border.all(width: 1, color: cLineColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH8sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: k4Padding),
                            child: Text(
                              title,
                              style: semiBold14TextStyle(cBlackColor),
                            ),
                          ),
                          const Icon(
                            BipHip.system,
                            size: kIconSize14,
                            color: cIconColor,
                          ),
                        ],
                      ),
                      kH4sizedBox,
                      Padding(
                        padding: const EdgeInsets.only(left: k4Padding),
                        child: Text(
                          subTitle,
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                      ),
                      kH4sizedBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: (width - 52) / 5.25,
          child: const Icon(
            BipHip.play,
            color: cWhiteColor,
            size: kIconSize40,
          ),
        ),
      ],
    );
  }
}
