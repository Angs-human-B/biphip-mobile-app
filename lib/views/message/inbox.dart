import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:intl/intl.dart';

class Inbox extends StatelessWidget {
  Inbox({super.key});
  final MessengerController messengerController = Get.find<MessengerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                  isCenterTitle: true,
                  title: ksInbox.tr,
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
                          BipHip.setting,
                          color: cIconColor,
                          size: isDeviceScreenLarge() ? 24 : 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      kH16sizedBox,
                      CustomModifiedTextField(
                        borderRadius: h8,
                        controller: messengerController.inboxSearchTextEditingController,
                        // focusNode: searchFocusNode,
                        prefixIcon: BipHip.search,
                        suffixIcon: BipHip.circleCrossNew,
                        hint: ksSearch.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: k12Padding,
                        ),
                        textInputStyle: regular16TextStyle(cBlackColor),
                        onSuffixPress: () {},
                        onSubmit: (value) async {},
                        onChanged: (value) {},
                      ),
                      kH16sizedBox,
                      SizedBox(
                        width: width,
                        height: 50,
                        child: ListView.builder(
                          itemCount: messengerController.inboxFilterCategoryList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, i) {
                            return Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                                  child: CustomChoiceChips(
                                    label: messengerController.inboxFilterCategoryList[i],
                                    isSelected: (messengerController.selectedFilterCategory.value == messengerController.inboxFilterCategoryList[i]),
                                    onSelected: (value) {
                                      messengerController.selectedFilterCategory.value = messengerController.inboxFilterCategoryList[i];
                                    },
                                  ),
                                ));
                          },
                        ),
                      ),
                      if (messengerController.inboxList.isEmpty) const EmptyChatView(),
                      kH16sizedBox,
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => kH16sizedBox,
                          itemCount: messengerController.inboxList.length,
                          itemBuilder: (context, index) {
                            var item = messengerController.inboxList[index];
                            return Container(
                              color: cWhiteColor,
                              width: width,
                              height: h50,
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          height: h50,
                                          width: h50,
                                          decoration: const BoxDecoration(
                                            color: cBlackColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            item["image"],
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Icon(
                                              BipHip.user,
                                              size: kIconSize24,
                                              color: cIconColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (item["isActive"])
                                        Positioned(
                                            bottom: 3,
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
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3),
                                                    child: Container(
                                                      height: 4,
                                                      width: 4,
                                                      decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                    ],
                                  ),
                                  kW12sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: k4Padding),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["name"],
                                          style: item["isSeen"] ? regular16TextStyle(cBlackColor) : semiBold16TextStyle(cBlackColor),
                                        ),
                                        // kH4sizedBox,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                "${item["isLastMessageSelf"] ? "You:" : ""} ${item["message"]}",
                                                style: (item["isSeen"]) ? regular14TextStyle(cSmallBodyTextColor) : semiBold14TextStyle(cBlackColor),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              "  • ${DateFormat('h:mm a').format(item["lastMassageTime"])}",
                                              style: (item["isSeen"]) ? regular14TextStyle(cSmallBodyTextColor) : semiBold14TextStyle(cBlackColor),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  if (item["isMute"])
                                    const Icon(
                                      BipHip.notificationFill,
                                      color: cIconColor,
                                      size: kIconSize14,
                                    ),
                                  if (item["isSeen"])
                                    ClipOval(
                                      child: Container(
                                        height: h14,
                                        width: h14,
                                        decoration: const BoxDecoration(
                                          color: cBlackColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          item["image"],
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => const Icon(
                                            BipHip.user,
                                            size: kIconSize14,
                                            color: cIconColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                      kH16sizedBox
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
