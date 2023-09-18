
import 'package:bip_hip/utils/constants/imports.dart';

class CommonRefreshIndicator extends StatelessWidget {
  const CommonRefreshIndicator({Key? key, required this.child, required this.onRefresh}) : super(key: key);

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: cPrimaryColor,
      backgroundColor: cWhiteColor,
      strokeWidth: 2.0,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
