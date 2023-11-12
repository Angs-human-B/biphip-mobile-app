import 'package:bip_hip/utils/constants/imports.dart';

class ReceivedFriendShimmer extends StatelessWidget {
  const ReceivedFriendShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k16Padding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: h40,
                            width: h40,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: ShimmerCommon(
                              widget: Container(
                                decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                                height: 40,
                                width: 40,
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
                                          width: isDeviceScreenLarge() ? 108 : 112,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
