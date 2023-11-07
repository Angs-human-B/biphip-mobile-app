import 'package:bip_hip/utils/constants/imports.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.title, this.height});
  final String title;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Text(
          title,
          style: semiBold16TextStyle(cPlaceHolderColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}