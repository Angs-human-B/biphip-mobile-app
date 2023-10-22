import 'package:bip_hip/utils/constants/imports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCommon extends StatelessWidget {
  const ShimmerCommon({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: cWhiteColor,
      highlightColor: Colors.grey[500]!,
      child: widget,
    );
  }
}