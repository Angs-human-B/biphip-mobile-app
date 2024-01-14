import 'package:bip_hip/utils/constants/imports.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Container(
              width: width,
              color: cWhiteColor,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: k12Padding),
                  child: Row(
                    children: [
                      kW20sizedBox,
                      ShimmerCommon(
                        widget: Container(
                          height: h40,
                          width: h40,
                          decoration: const BoxDecoration(
                            color: cWhiteColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      kW12sizedBox,
                      Expanded(
                        child: ShimmerCommon(
                          widget: Container(
                            height: h16,
                            decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                          ),
                        ),
                      ),
                      kW12sizedBox,
                      ShimmerCommon(
                        widget: Container(
                            height: h26,
                            width: h26,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            )),
                      ),
                      kW20sizedBox
                    ],
                  ),
                ),
              ),
            ),
            kH8sizedBox,
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
                              width: (width - 200) / 3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                          ShimmerCommon(
                            widget: Container(
                              height: 2,
                              width: (width - 40) / 3,
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
                              width: (width - 200) / 3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                            width: (width - 40) / 3,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ShimmerCommon(
                            widget: Container(
                              height: h12,
                              width: (width - 200) / 3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                            width: (width - 40) / 3,
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              color: cWhiteColor,
              width: width,
              child: SizedBox(
                height: 150,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: k10Padding),
                  child: ListView.builder(
                      padding: const EdgeInsets.only(left: k10Padding),
                      itemCount: 8,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: k8Padding),
                          child: ShimmerCommon(
                              widget: Container(
                            height: 137,
                            width: 90,
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius, border: Border.all(color: cLineColor)),
                          )),
                        );
                      }),
                ),
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

class HomePagePaginationShimmer extends StatelessWidget {
  const HomePagePaginationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        widget: Container(height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      kH8sizedBox,
                      ShimmerCommon(
                        widget: Container(height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
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
      ],
    );
  }
}
