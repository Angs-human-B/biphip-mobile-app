import 'package:bip_hip/utils/constants/imports.dart';

class PendingFamilyShimmer extends StatelessWidget {
  const PendingFamilyShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: ListView.separated(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => kH16sizedBox,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: cLineColor,
                      ),
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(k12Padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: h45,
                                width: h45,
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
                              kW12sizedBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerCommon(
                                      widget: Container(
                                        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                        height: 16,
                                        width: 120,
                                      ),
                                    ),
                                    kH4sizedBox,
                                    ShimmerCommon(
                                      widget: Container(
                                        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                        height: 8,
                                        width: 80,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ShimmerCommon(
                                widget: Container(
                                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                                  height: 30,
                                  width: isDeviceScreenLarge() ? 112 : 120,
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
          ],
        ),
      ),
    );
  }
}
