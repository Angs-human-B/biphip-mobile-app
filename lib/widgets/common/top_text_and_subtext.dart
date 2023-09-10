import 'package:bip_hip/utils/constants/imports.dart';

class TopTitleAndSubtitle extends StatelessWidget {
  const TopTitleAndSubtitle({
    Key? key,
    required this.title,
    this.subTitle,
  }) : super(key: key);
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: medium24TextStyle(cBlackColor),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                subTitle ?? '',
                style: regular14TextStyle(cSmallBodyTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}