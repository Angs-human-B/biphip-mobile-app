import 'package:bip_hip/utils/constants/imports.dart';

class EmptyChatView extends StatelessWidget {
  const EmptyChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: k140Padding),
      child: Column(
        children: [
          const Icon(
            BipHip.report,
            color: cIconColor,
            size: 130,
          ),
          kH16sizedBox,
          Text(
            ksNoChatAvailAble.tr,
            style: semiBold18TextStyle(cSmallBodyTextColor),
          ),
          kH4sizedBox,
          Text(
            ksNoChatDescription.tr,
            style: regular12TextStyle(cSmallBodyTextColor),
          )
        ],
      ),
    );
  }
}
