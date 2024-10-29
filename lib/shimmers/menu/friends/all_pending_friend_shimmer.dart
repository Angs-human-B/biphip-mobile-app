import 'package:bip_hip/utils/constants/imports.dart';

class AllPendingFriendShimmer extends StatelessWidget {
  const AllPendingFriendShimmer({super.key, this.isBottomSheetShimmer = false});
  final bool isBottomSheetShimmer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: isBottomSheetShimmer ? const EdgeInsets.all(k0Padding) : const EdgeInsets.symmetric(horizontal: k20Padding),
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
                            width: 80,
                          ),
                        ),
                        subtitle: isBottomSheetShimmer
                            ? ShimmerCommon(
                                widget: Container(
                                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                  height: 12,
                                  width: h40,
                                ),
                              )
                            : const SizedBox(),
                        trailing: isBottomSheetShimmer
                            ? const SizedBox()
                            : ShimmerCommon(
                                widget: Container(
                                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                  height: 20,
                                  width: 12,
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
