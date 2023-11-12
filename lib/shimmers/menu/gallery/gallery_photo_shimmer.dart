import 'package:bip_hip/utils/constants/imports.dart';

class GalleryPhotoShimmer extends StatelessWidget {
  const GalleryPhotoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH12sizedBox,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: k10Padding,
                  mainAxisSpacing: k4Padding,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: k8CircularBorderRadius,
                            child: ShimmerCommon(
                              widget: Container(
                                color: cWhiteColor,
                                height: 100,
                                width: ((width - 52) / 2),
                              ),
                            ),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              height: 12,
                              width: 80,
                            ),
                          ),
                          kH4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              height: 12,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
