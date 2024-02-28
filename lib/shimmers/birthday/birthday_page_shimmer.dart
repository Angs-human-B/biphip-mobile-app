import 'package:bip_hip/utils/constants/imports.dart';

class BirthdayPageShimmer extends StatelessWidget {
  const BirthdayPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH16sizedBox,
        ShimmerCommon(
            widget: Container(
                height: h16,
                width: 120,
                decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                ))),
        kH16sizedBox,
        ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => kH16sizedBox,
          itemBuilder: (context, index) {
            return const BirthdayCommonShimmerView();
          },
        ),
        kH16sizedBox,
        ShimmerCommon(
            widget: Container(
                height: h16,
                width: 120,
                decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                ))),
        kH16sizedBox,
        ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => kH16sizedBox,
          itemBuilder: (context, index) {
            return const BirthdayCommonShimmerView();
          },
        ),
        kH16sizedBox,
        ShimmerCommon(
            widget: Container(
                height: h16,
                width: 120,
                decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                ))),
        kH16sizedBox,
        ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => kH16sizedBox,
          itemBuilder: (context, index) {
            return const BirthdayCommonShimmerView();
          },
        ),
      ],
    );
  }
}

class BirthdayCommonShimmerView extends StatelessWidget {
  const BirthdayCommonShimmerView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: k16Padding,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: k16Padding, right: k8Padding),
                  child: ClipOval(
                    child: ShimmerCommon(
                        widget: Container(
                            height: h50,
                            width: h50,
                            decoration: BoxDecoration(
                              color: cWhiteColor,
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                            ))),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerCommon(
                        widget: Container(
                            height: h16,
                            width: 120,
                            decoration: BoxDecoration(
                              color: cWhiteColor,
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                            ))),
                    kH4sizedBox,
                    Row(
                      children: [
                        ShimmerCommon(
                            widget: Container(
                                height: h12,
                                width: h40,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                ))),
                        kW4sizedBox,
                        ShimmerCommon(
                            widget: Container(
                                height: h12,
                                width: h40,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                ))),
                        kW4sizedBox,
                        ShimmerCommon(
                            widget: Container(
                                height: h12,
                                width: h40,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                ))),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: k16Padding),
                  child: ShimmerCommon(
                    widget: Container(
                      width: 48,
                      height: h32,
                      decoration: BoxDecoration(
                        color: cWhiteColor,
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        border: Border.all(color: cWhiteColor, width: 1),
                      ),
                      child: CustomIconButton(
                        onPress: () {},
                        icon: BipHip.chatOutline,
                        size: kIconSize14,
                        iconColor: cWhiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          kH20sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerCommon(
                    widget: Container(
                        height: h32,
                        width: 220,
                        decoration: BoxDecoration(
                          color: cWhiteColor,
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ))),
                kW12sizedBox,
                ShimmerCommon(
                    widget: Container(
                        height: h32,
                        width: 64,
                        decoration: BoxDecoration(
                          color: cWhiteColor,
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
