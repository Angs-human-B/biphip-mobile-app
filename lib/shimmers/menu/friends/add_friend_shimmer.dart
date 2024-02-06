import 'package:bip_hip/utils/constants/imports.dart';

class AddFriendShimmer extends StatelessWidget {
  const AddFriendShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
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
