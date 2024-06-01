import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';

class MessengerSettingsContent extends StatelessWidget {
  const MessengerSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k12Padding),
      child: Column(
        children: [
          IconWithTextRow(
            actionIcon: BipHip.setting,
            actionText: ksPreferences,
            iconColor: cBlackColor,
            actionOnPressed: () {},
          ),
          kH4sizedBox,
          IconWithTextRow(
            actionIcon: BipHip.setting,
            actionText: ksMessageRequests,
            iconColor: cBlackColor,
            actionOnPressed: () {},
          ),
          kH4sizedBox,
          IconWithTextRow(
            actionIcon: BipHip.setting,
            actionText: ksArchivedChat,
            iconColor: cBlackColor,
            actionOnPressed: () {},
          ),
          kH4sizedBox,
          IconWithTextRow(
            actionIcon: BipHip.setting,
            actionText: ksSpamBox,
            iconColor: cBlackColor,
            actionOnPressed: () {},
          ),
          kH4sizedBox,
          IconWithTextRow(
            actionIcon: BipHip.setting,
            actionText: ksRestrictedAccount,
            iconColor: cBlackColor,
            actionOnPressed: () {},
          ),
          kH4sizedBox,
          IconWithTextRow(
            actionIcon: BipHip.info,
            actionText: ksHelp,
            iconColor: cBlackColor,
            actionOnPressed: () {},
          ),
        ],
      ),
    );
  }
}
