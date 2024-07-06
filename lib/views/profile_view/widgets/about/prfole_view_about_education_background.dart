import 'package:bip_hip/utils/constants/imports.dart';

class ProileViewAboutEducationBackground extends StatelessWidget {
  const ProileViewAboutEducationBackground({super.key});

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
              ksEducationBackground.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "studied at ", style: regular16TextStyle(cSmallBodyTextColor)),
                  TextSpan(text: "B.N College Dhaka", style: regular16TextStyle(cBlackColor)),
                ],
              ),
            ),
            kH4sizedBox,
            Text(
              "26 October, 2016 - 26, September, 2023",
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "studied at ", style: regular16TextStyle(cSmallBodyTextColor)),
                  TextSpan(text: "Adamjee Cantonment College", style: regular16TextStyle(cBlackColor)),
                ],
              ),
            ),
            kH4sizedBox,
            Text(
              "12 August, 2014 - 26, September, 2016",
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

