import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

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
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => kH8sizedBox,
                          itemCount: messengerController.inboxList.length,
                          itemBuilder: (context, index) {
                            var item = messengerController.inboxList[index];
                            return Container(
                              color: cWhiteColor,
                              width: width,
                              height: h50,
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      height: h44,
                                      width: h44,
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
                                ],
                              ),
                            );
                          }),
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
