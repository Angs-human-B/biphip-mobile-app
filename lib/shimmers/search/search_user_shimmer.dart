import 'package:bip_hip/utils/constants/imports.dart';

class UserSearchShimmer extends StatelessWidget {
  const UserSearchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: ListView.separated(
            itemCount: 20,
            padding: const EdgeInsets.all(k0Padding),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => kH8sizedBox,
            itemBuilder: (context, index) {
              return CustomListTile(
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
                subtitle: ShimmerCommon(
                  widget: Container(
                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                    height: 8,
                    width: 80,
                  ),
                ),
                trailing: ShimmerCommon(
                  widget: Container(
                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                    height: 12,
                    width: 80,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
