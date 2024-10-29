import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewAbotInterestContent extends StatelessWidget {
  const ProfileViewAbotInterestContent({super.key, required this.title, required this.subTitle});
  final String title;
  final List<String> subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(k20Padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            Text(
              subTitle.join(', '),
              style: regular16TextStyle(cBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}
