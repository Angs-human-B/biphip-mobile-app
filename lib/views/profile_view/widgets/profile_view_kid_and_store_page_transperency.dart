import 'package:bip_hip/utils/constants/imports.dart';
import 'package:intl/intl.dart';

class ProfileViewKidAndStorePageTransperency extends StatelessWidget {
  const ProfileViewKidAndStorePageTransperency({super.key, this.pageId, required this.dateTimeValue});
  final String? pageId;
  final DateTime dateTimeValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Text(
              ksPageTransparency,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            Text(
              "BipHip is showing informatino to help people understand the purpose of your page. You won't be able to edit what is shown here.",
              style: regular14TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              pageId ?? ksNA.tr,
              style: regular16TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Text(
              ksPageId.tr,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              DateFormat('dd MMM, yyyy').format(dateTimeValue),
              style: regular16TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Text(
              ksCreatingDate.tr,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              "Admin Info",
              style: regular16TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Text(
              "This page can't have admin right now. We will add admin feature in coming updates.",
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              "This page is currently not running ads",
              style: regular16TextStyle(cBlackColor),
            ),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}
