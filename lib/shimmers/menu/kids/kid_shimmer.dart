import 'package:bip_hip/utils/constants/imports.dart';

class KidsShimmer extends StatelessWidget {
  const KidsShimmer({super.key});

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
                      child: CustomListTile(
                        borderColor: cLineColor,
                        leading: ShimmerCommon(
                          widget: Container(
                            decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                            height: h40,
                            width: h40,
                          ),
                        ),
                        title: ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 12,
                            width: 120,
                          ),
                        ),
                        subtitle: ShimmerCommon(
                          widget: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                              ),
                              kW4sizedBox,
                              Container(
                                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                height: 12,
                                width: 120,
                              ),
                            ],
                          ),
                        ),
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
