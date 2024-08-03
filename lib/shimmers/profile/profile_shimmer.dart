import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class ProfilePageShimmer2 extends StatelessWidget {
  const ProfilePageShimmer2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: cGreyBoxColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kAppBarSize),
          //* info:: appBar
          child: CustomAppBar(
            appBarColor: cWhiteColor,
            title: ShimmerCommon(
              widget: Container(decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius), height: h20, width: width * 0.6),
            ),
            hasBackButton: true,
            onBack: () {
              Get.back();
            },
          ),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 225,
                      color: cWhiteColor,
                    ),
                    SizedBox(
                        height: 150,
                        width: width,
                        child: ShimmerCommon(
                          widget: Container(
                            color: cWhiteColor,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: Stack(
                        children: [
                          Container(
                            height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                            width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                            decoration: BoxDecoration(
                              color: cGreyBoxColor,
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(color: cGreyBoxColor.withAlpha(500), width: 2),
                            ),
                            child: ClipOval(
                                child: ShimmerCommon(
                              widget: Container(
                                color: cWhiteColor,
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: cWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH10sizedBox,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: ShimmerCommon(
                            widget: Container(
                              height: h20,
                              width: width * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          )),
                      kH10sizedBox,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: ShimmerCommon(
                            widget: Container(
                              height: h14,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          )),
                      kH12sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ShimmerCommon(
                              widget: Container(
                                height: h32,
                                width: 124,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                            kW16sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                height: h32,
                                width: 124,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      kH16sizedBox,
                    ],
                  ),
                ),
                kH12sizedBox,
                Container(
                  color: cWhiteColor,
                  height: 40,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              ShimmerCommon(
                                widget: Container(
                                  height: h12,
                                  width: (width - 200) / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: k8CircularBorderRadius,
                                    color: cWhiteColor,
                                  ),
                                ),
                              ),
                              ShimmerCommon(
                                widget: Container(
                                  height: 2,
                                  width: (width - 40) / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: k8CircularBorderRadius,
                                    color: cWhiteColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              ShimmerCommon(
                                widget: Container(
                                  height: h12,
                                  width: (width - 200) / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: k8CircularBorderRadius,
                                    color: cWhiteColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                                width: (width - 40) / 2,
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                kH12sizedBox,
                Container(
                  width: width,
                  color: cWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerCommon(
                            widget: Container(
                              height: h20,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                          kH12sizedBox,
                          ShimmerCommon(
                            widget: Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: Container(
                                height: h14,
                                width: width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                          ),
                          ShimmerCommon(
                            widget: Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: Container(
                                height: h14,
                                width: width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                          ),
                          ShimmerCommon(
                            widget: Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: Container(
                                height: h14,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: k8CircularBorderRadius,
                                  color: cWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                kH12sizedBox,
                Container(
                  color: cWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: k12Padding),
                    child: Row(
                      children: [
                        kW20sizedBox,
                        ShimmerCommon(
                          widget: ClipOval(
                            child: Container(
                              height: h40,
                              width: h40,
                              decoration: const BoxDecoration(
                                color: cWhiteColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        kW12sizedBox,
                        ShimmerCommon(
                          widget: Container(
                            height: h20,
                            width: width * 0.6,
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kH12sizedBox,
                Container(
                  color: cWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
                        child: ShimmerCommon(
                          widget: Container(
                            height: h20,
                            width: width * 0.2,
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: 50,
                        child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                              child: ShimmerCommon(
                                widget: CustomChoiceChips(
                                  label: '     ',
                                  isSelected: false,
                                  onSelected: (value) {},
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                kHBottomSizedBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostCommonShimmer extends StatelessWidget {
  const PostCommonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            kH8sizedBox,
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
                            widget:
                                Container(height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                        ],
                      )
                    ],
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width * 0.4, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  Row(
                    children: [
                      ShimmerCommon(
                        widget: Container(
                          height: 160,
                          width: (width - 42) / 2,
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        ),
                      ),
                      const SizedBox(width: 2),
                      ShimmerCommon(
                        widget: Container(
                          height: 160,
                          width: (width - 42) / 2,
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        ),
                      ),
                    ],
                  ),
                  kH12sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      )
                    ],
                  )
                ]),
              ),
            ),
            kH8sizedBox,
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
                            widget:
                                Container(height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                        ],
                      )
                    ],
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width * 0.4, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH16sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      )
                    ],
                  )
                ]),
              ),
            ),
            kH8sizedBox,
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
                            widget:
                                Container(height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                        ],
                      )
                    ],
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(
                      height: 300,
                      width: width - 40,
                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                    ),
                  ),
                  kH8sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      )
                    ],
                  )
                ]),
              ),
            ),
            kH8sizedBox
          ],
        ),
      ),
    );
  }
}