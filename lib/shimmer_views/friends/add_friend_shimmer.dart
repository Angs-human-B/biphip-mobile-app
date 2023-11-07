import 'package:bip_hip/utils/constants/imports.dart';

class AddFriendShimmer extends StatelessWidget {
  const AddFriendShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: k10Padding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ShimmerCommon(
                              widget: Container(
                                decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                                height: h40,
                                width: h40,
                              ),
                            ),
                            kW12sizedBox,
                            ShimmerCommon(
                              widget: Container(
                                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                height: 16,
                                width: 100,
                              ),
                            ),
                            const Spacer(),
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
          ],
        ),
      ),
    );
  }
}
