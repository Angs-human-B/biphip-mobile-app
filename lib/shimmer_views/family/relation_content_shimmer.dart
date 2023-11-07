import 'package:bip_hip/utils/constants/imports.dart';

class RelationContentShimmer extends StatelessWidget {
  const RelationContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: k12Padding),
          child: CustomListTile(
            borderColor: cLineColor,
            title: ShimmerCommon(
              widget: Container(
                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                height: 16,
                width: 120,
              ),
            ),
            trailing: ShimmerCommon(
              widget: Container(
                decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                height: 16,
                width: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}