import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class PendentPageShimmer extends StatelessWidget {
  const PendentPageShimmer({super.key});

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
          height: 108,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(k8BorderRadius),
            border: Border.all(
              color: cLineColor,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: k16Padding, top: k16Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kH4sizedBox,
                    ShimmerCommon(
                      widget: Container(
                        width: 200,
                        height: h12,
                        decoration: BoxDecoration(
                          color: cWhiteColor,
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ),
                      ),
                    ),
                    kH4sizedBox,
                    ShimmerCommon(
                      widget: Container(
                        width: 200,
                        height: h12,
                        decoration: BoxDecoration(
                          color: cWhiteColor,
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ),
                      ),
                    ),
                    kH12sizedBox,
                    Row(
                      children: [
                        ShimmerCommon(
                          widget: Container(
                            width: 70,
                            height: h24,
                            decoration: BoxDecoration(
                              color: cWhiteColor,
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                            ),
                          ),
                        ),
                        kW12sizedBox,
                        ShimmerCommon(
                          widget: Container(
                            width: 70,
                            height: h24,
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
                Padding(
                  padding: const EdgeInsets.only(right: k16Padding),
                  child: Column(
                    children: [
                      kH8sizedBox,
                      ShimmerCommon(
                        widget: SvgPicture.asset(
                          kiPendentSvgImageUrl,
                          color: cWhiteColor,
                          width: 40,
                          height: 40,
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
                    ],
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
                          ShimmerCommon(
                            widget: Container(
                              width: h8,
                              height: h12,
                              decoration: BoxDecoration(
                                color: cWhiteColor,
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                              ),
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
