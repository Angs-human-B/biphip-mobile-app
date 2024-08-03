
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class HomePostDetailsScreenShimmer extends StatelessWidget {
  const HomePostDetailsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: height - kAppBarSize - MediaQuery.of(context).padding.top,
            child: Scaffold(
              backgroundColor: cWhiteColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kAppBarSize),
                //* info:: appBar
                child: CustomAppBar(
                  hasBackButton: true,
                  isCenterTitle: true,
                  title: ShimmerCommon(
                    widget: Container(decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius), height: h20, width: width * 0.6),
                  ),
                  onBack: () {
                    Get.back();
                  },
                ),
              ),
              body: SizedBox(
                height: height - kAppBarSize,
                width: width,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        color: cWhiteColor,
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h40,
                                      width: h40,
                                      decoration: const BoxDecoration(
                                        color: cWhiteColor,
                                        shape: BoxShape.circle,
                                      )),
                                ),
                                kW8sizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                          height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                    ),
                                    kH8sizedBox,
                                    ShimmerCommon(
                                      widget: Container(
                                          height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            kH16sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                  height: h10, width: width * 0.4, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH12sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                )
                              ],
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget:
                                  Container(height: 2, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH12sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                height: 300,
                                width: (width - 40),
                                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              ),
                            ),
                            kH12sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                )
                              ],
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget:
                                  Container(height: 2, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH12sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                height: 300,
                                width: (width - 40),
                                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              ),
                            ),
                            kH12sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                              ],
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget:
                                  Container(height: 2, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH12sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                height: 300,
                                width: width - 40,
                                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              ),
                            ),
                            kH12sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                ),
                                ShimmerCommon(
                                  widget: Container(
                                      height: h20, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                                )
                              ],
                            ),
                            kH8sizedBox,
                            ShimmerCommon(
                              widget:
                                  Container(height: 2, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                            ),
                            kH16sizedBox,
                            const ShimmerCommon(widget: CustomDivider()),
                            kH16sizedBox,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
                                  ),
                                ),
                                kW8sizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                        width: width - 130,
                                        height: 60,
                                        decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            kH8sizedBox,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: cWhiteColor),
                                  ),
                                ),
                                kW8sizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                        width: width - 180,
                                        height: 50,
                                        decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
