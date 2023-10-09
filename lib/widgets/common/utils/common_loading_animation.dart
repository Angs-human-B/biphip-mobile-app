import 'package:bip_hip/utils/constants/imports.dart';

class CommonLoadingAnimation extends StatelessWidget {
  const CommonLoadingAnimation({super.key, required this.onWillPop});
  final Future<bool> Function() onWillPop;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        color: Colors.black.withOpacity(.3),
        child: const Center(
          child: CircularProgressIndicator(
            color: cPrimaryColor,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
