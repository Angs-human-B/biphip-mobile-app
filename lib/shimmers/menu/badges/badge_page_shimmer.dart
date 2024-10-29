import 'package:bip_hip/utils/constants/imports.dart';

class BadgePageShimmer extends StatelessWidget {
  const BadgePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH16sizedBox,
        ShimmerCommon(
          widget: Container(
            width: 120,
            height: h16,
            decoration: BoxDecoration(
              color: cWhiteColor,
              borderRadius: BorderRadius.circular(k8BorderRadius),
            ),
          ),
        ),
        kH8sizedBox,
        Container(
          width: width - 40,
          height: 64,
          decoration: BoxDecoration(
            color: cWhiteColor,
            border: Border.all(color: cLineColor, width: 1),
            borderRadius: BorderRadius.circular(k8BorderRadius),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ShimmerCommon(
                  widget: Icon(
                    BipHip.giftNew,
                    color: cWhiteColor,
                    size: kIconSize16,
                  ),
                ),
                kW4sizedBox,
                ShimmerCommon(
                  widget: Container(
                    width: h40,
                    height: h20,
                    decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: k16Padding, left: 1),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ShimmerCommon(
                      widget: Container(
                        width: h40,
                        height: h16,
                        decoration: BoxDecoration(
                          color: cWhiteColor,
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        kH16sizedBox,
        ShimmerCommon(
          widget: Container(
            width: 120,
            height: h16,
            decoration: BoxDecoration(
              color: cWhiteColor,
              borderRadius: BorderRadius.circular(k8BorderRadius),
            ),
          ),
        ),
        kH16sizedBox,
        SizedBox(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
              crossAxisCount: 3,
              crossAxisSpacing: k16Padding,
              mainAxisSpacing: k16Padding,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor, border: Border.all(color: cLineColor)),
                child: Padding(
                  padding: const EdgeInsets.all(k8Padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: k8CircularBorderRadius,
                        child: ShimmerCommon(
                          widget: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      kH4sizedBox,
                      ShimmerCommon(
                        widget: Container(
                          width: 60,
                          height: h12,
                          decoration: BoxDecoration(
                            color: cWhiteColor,
                            borderRadius: BorderRadius.circular(k8BorderRadius),
                          ),
                        ),
                      ),
                      kH4sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ShimmerCommon(
                            widget: Icon(
                              BipHip.giftNew,
                              color: cWhiteColor,
                              size: kIconSize16,
                            ),
                          ),
                          kW4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              width: h20,
                              height: h12,
                              decoration: BoxDecoration(
                                color: cWhiteColor,
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
       
        kH20sizedBox,
        Align(
          alignment: Alignment.center,
          child: ShimmerCommon(
            widget: Container(
              width: width * 0.5,
              height: h32,
              decoration: BoxDecoration(
                color: cWhiteColor,
                borderRadius: BorderRadius.circular(k8BorderRadius),
              ),
            ),
          ),
        ),
        kH20sizedBox,
      ],
    );
  }
}

class BadgeBottomSheetShimmer extends StatelessWidget {
  const BadgeBottomSheetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH16sizedBox,
        ShimmerCommon(
          widget: Container(
            width: 120,
            height: h16,
            decoration: BoxDecoration(
              color: cWhiteColor,
              borderRadius: BorderRadius.circular(k8BorderRadius),
            ),
          ),
        ),
        kH16sizedBox,
        SizedBox(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
              crossAxisCount: 3,
              crossAxisSpacing: k16Padding,
              mainAxisSpacing: k16Padding,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor, border: Border.all(color: cLineColor)),
                child: Padding(
                  padding: const EdgeInsets.all(k8Padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: k8CircularBorderRadius,
                        child: ShimmerCommon(
                          widget: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      kH4sizedBox,
                      ShimmerCommon(
                        widget: Container(
                          width: 60,
                          height: h12,
                          decoration: BoxDecoration(
                            color: cWhiteColor,
                            borderRadius: BorderRadius.circular(k8BorderRadius),
                          ),
                        ),
                      ),
                      kH4sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ShimmerCommon(
                            widget: Icon(
                              BipHip.giftNew,
                              color: cWhiteColor,
                              size: kIconSize16,
                            ),
                          ),
                          kW4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              width: h20,
                              height: h12,
                              decoration: BoxDecoration(
                                color: cWhiteColor,
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        kH20sizedBox,
        Align(
          alignment: Alignment.center,
          child: ShimmerCommon(
            widget: Container(
              width: width * 0.5,
              height: h32,
              decoration: BoxDecoration(
                color: cWhiteColor,
                borderRadius: BorderRadius.circular(k8BorderRadius),
              ),
            ),
          ),
        ),
        kH20sizedBox,
      ],
    );
  }
}
