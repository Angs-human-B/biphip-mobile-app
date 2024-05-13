import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';

class MessengerSettingsContent extends StatelessWidget {
  const MessengerSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconWithTextRow(
          actionIcon: BipHip.setting,
          actionText: ksPreferences,
          actionOnPressed: () {},
        ),
        IconWithTextRow(
          actionIcon: BipHip.setting,
          actionText: ksMessageRequests,
          actionOnPressed: () {},
        ),
        IconWithTextRow(
          actionIcon: BipHip.setting,
          actionText: ksArchivedChat,
          actionOnPressed: () {},
        ),
        IconWithTextRow(
          actionIcon: BipHip.setting,
          actionText: ksSpamBox,
          actionOnPressed: () {},
        ),
        IconWithTextRow(
          actionIcon: BipHip.setting,
          actionText: ksRestrictedAccount,
          actionOnPressed: () {},
        ),
        IconWithTextRow(
          actionIcon: BipHip.info,
          actionText: ksHelp,
          actionOnPressed: () {},
        ),
      ],
    );
  }
}
