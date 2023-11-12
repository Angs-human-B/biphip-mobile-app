import 'package:bip_hip/utils/constants/imports.dart';

class AllReceivedFamilyShimmer extends StatelessWidget {
  const AllReceivedFamilyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k16Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: h50,
                          width: h50,
                          decoration: const BoxDecoration(
                            color: cWhiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: ShimmerCommon(
                            widget: Container(
                              decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                              height: h50,
                              width: h50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: k12Padding),
                          child: SizedBox(
                            width: width - 105,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerCommon(
                                  widget: Container(
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                    height: 16,
                                    width: 200,
                                  ),
                                ),
                                kH4sizedBox,
                                ShimmerCommon(
                                  widget: Container(
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                    height: 8,
                                    width: 100,
                                  ),
                                ),
                                kH4sizedBox,
                                Row(
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                                        height: 30,
                                        width: isDeviceScreenLarge() ? 108 : 112,
                                      ),
                                    ),
                                    kW20sizedBox,
                                    ShimmerCommon(
                                      widget: Container(
                                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                                          height: 30,
                                          width: isDeviceScreenLarge() ? 108 : 112),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

