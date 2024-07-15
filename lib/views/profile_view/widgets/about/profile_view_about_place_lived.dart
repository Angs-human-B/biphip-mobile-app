import 'package:bip_hip/models/menu/profile/profile_overview_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/about/profile_view_about_title_subtitle_text.dart';
import 'package:intl/intl.dart';

class ProileViewAboutPlaceLived extends StatelessWidget {
  const ProileViewAboutPlaceLived({super.key, required this.homeTown, required this.currentCity, required this.placesList});
  final CurrentCity? homeTown,currentCity;
  final List<CurrentCity?> placesList;
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
              ksPlaceLived.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            ProfileViewAboutTitleSubtitleText(
              title: homeTown?.city??"",
              subTitle: ksHomeTown.tr,
            ),
            kH16sizedBox,
             ProfileViewAboutTitleSubtitleText(
              title: currentCity?.city??"",
              subTitle: ksCurrentCity.tr,
            ),
            for(int i=0;i<placesList.length;i++)
             ProfileViewAboutTitleSubtitleText(
              title: placesList[i]?.city??"",
            subTitle: DateFormat("dd MMMM, yyyy").format(placesList[i]!.moved??DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }
}

