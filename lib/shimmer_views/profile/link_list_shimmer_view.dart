import 'package:bip_hip/utils/constants/imports.dart';

class LinkListContentShimmer extends StatelessWidget {
  const LinkListContentShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
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
        ),
      ],
    );
  }
}