import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/message/widgets/chat_textfield.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

import 'widgets/custom_chat_bubble.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});
  final MessengerController messengerController = Get.find<MessengerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          child: Scaffold(
            backgroundColor: cWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                hasBackButton: true,
                isCenterTitle: false,
                leadingWidth: 25,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: Container(
                            height: h36,
                            width: h36,
                            decoration: const BoxDecoration(
                              color: cBlackColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              "image",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.user,
                                size: kIconSize24,
                                color: cIconColor,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: h14,
                            width: h14,
                            decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                height: h12,
                                width: h12,
                                decoration: const BoxDecoration(color: cGreenColor, shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    kW12sizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Manjurul S. Omi",
                          style: semiBold18TextStyle(cBlackColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Active Now",
                          style: regular10TextStyle(cBlackColor),
                        ),
                      ],
                    )
                  ],
                ),
                onBack: () {
                  Get.back();
                },
                action: [
                  Padding(
                    padding: const EdgeInsets.only(right: h20),
                    child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {},
                      child: Icon(
                        BipHip.video,
                        color: cPrimaryColor,
                        size: isDeviceScreenLarge() ? 24 : 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: h20),
                    child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {},
                      child: Icon(
                        BipHip.phoneFill,
                        color: cPrimaryColor,
                        size: isDeviceScreenLarge() ? 24 : 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: h20),
                    child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {},
                      child: Icon(
                        BipHip.info,
                        color: cPrimaryColor,
                        size: isDeviceScreenLarge() ? 24 : 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    CustomDivider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              reverse: true,
                              padding: const EdgeInsets.only(bottom: 54),
                              separatorBuilder: (context, index) {
                                return kH8sizedBox;
                              },
                              shrinkWrap: true,
                              itemCount: 27,
                              itemBuilder: (context, index) {
                                return CustomBubbleNormal(
                                  text: "message $index lkasdjhk lfhdkj kjahsjkfh kjsdhf kldhjkgl kjajkfh jkadshfgkja hjkl l",
                                  isSender: index % 2 == 0 ? false : true,
                                  color: index % 2 == 0 ? cPrimaryColor : cNeutralColor,
                                  tail: false,
                                  textStyle: regular16TextStyle(index % 2 == 0 ? cWhiteColor : cBlackColor),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: ChatTextField(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
