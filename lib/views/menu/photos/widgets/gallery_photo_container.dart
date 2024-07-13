import 'package:bip_hip/utils/constants/imports.dart';

class GalleryPhotoContainer extends StatelessWidget {
  const GalleryPhotoContainer({super.key, this.title, required this.subTitle, this.onPressed, required this.image, this.threeDotOnPressed, this.isThreeDotButtonShow=true});
  final String? title;
  final String subTitle;
  final List image;
  final VoidCallback? onPressed;
  final VoidCallback? threeDotOnPressed;
  final bool? isThreeDotButtonShow;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: cTransparentColor,
        highlightColor: cTransparentColor,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: cLineColor),
            borderRadius: k8CircularBorderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image.isEmpty
                  ? SizedBox(
                      width: (width - 60) / 2,
                      height: 101,
                      child: const Icon(
                        BipHip.imageFile,
                        size: kIconSize70,
                        color: cIconColor,
                      ),
                    )
                  : Row(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
                        child: SizedBox(
                          width: (width - 50) / 2,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 101,
                                width: (image.length < 2) ? (width - 50) / 2 : (width - 52) / 4,
                                child: Image.network(
                                  image[0],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize70,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                ),
                              ),
                              (image.length > 1)
                                  ? const SizedBox(
                                      width: 1,
                                    )
                                  : const SizedBox(),
                              Column(
                                children: [
                                  if (image.length > 1)
                                    SizedBox(
                                      height: image.length > 2 ? 50 : 101,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        image[1],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize70,
                                          color: cIconColor,
                                        ),
                                        loadingBuilder: imageLoadingBuilder,
                                      ),
                                    ),
                                  if (image.length > 2)
                                    const SizedBox(
                                      height: 1,
                                    ),
                                  if (image.length > 2)
                                    SizedBox(
                                      height: image.length > 2 ? 50 : 101,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        image[2],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize70,
                                          color: cIconColor,
                                        ),
                                        loadingBuilder: imageLoadingBuilder,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              SizedBox(
                width: (width - 50) / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH8sizedBox,
                          Padding(
                            padding: const EdgeInsets.only(left: k4Padding + k2Padding),
                            child: Text(
                              title!,
                              overflow: TextOverflow.ellipsis,
                              style: semiBold14TextStyle(cBlackColor),
                            ),
                          ),
                          kH4sizedBox,
                          Padding(
                            padding: const EdgeInsets.only(left: k4Padding + k2Padding),
                            child: Text(
                              subTitle,
                              style: regular12TextStyle(cSmallBodyTextColor),
                            ),
                          ),
                          kH4sizedBox,
                        ],
                      ),
                    ),
                    if(isThreeDotButtonShow==true)
                    CustomIconButton(
                      onPress: threeDotOnPressed,
                      icon: BipHip.system,
                      size: kIconSize20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
