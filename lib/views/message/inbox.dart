import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:bip_hip/models/messenger/room_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/message/bottom_sheets/settings_content.dart';
import 'package:bip_hip/views/message/widgets/empty_chat_view.dart';
import 'package:bip_hip/views/message/widgets/inbox_widget.dart';
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
                        onPressed: () {
                          Get.find<GlobalController>()
                              .blankBottomSheet(context: context, content: MessengerSettingsContent(), bottomSheetHeight: height * 0.35);
                        },
                        child: Icon(
                          BipHip.manage,
                          color: cIconColor,
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
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              children: [
                                messengerController.isInternetConnectionAvailable.value ? kH16sizedBox : kH24sizedBox,
                                CustomModifiedTextField(
                                  borderRadius: h8,
                                  controller: messengerController.inboxSearchTextEditingController,
                                  prefixIcon: BipHip.search,
                                  suffixIcon: messengerController.isSearchFieldCrossButtonShown.value ? BipHip.circleCrossNew : null,
                                  hint: ksSearch.tr,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: k12Padding,
                                  ),
                                  textInputStyle: regular16TextStyle(cBlackColor),
                                  onSuffixPress: () {
                                    messengerController.inboxSearchTextEditingController.clear();
                                    messengerController.isSearchFieldCrossButtonShown.value = false;
                                  },
                                  onSubmit: (value) async {},
                                  onChanged: (value) {
                                    if (messengerController.inboxSearchTextEditingController.text.trim() != "") {
                                      messengerController.isSearchFieldCrossButtonShown.value = true;
                                    }
                                  },
                                ),
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
                                if (messengerController.roomList.isEmpty) const EmptyChatView(),
                                kH16sizedBox,
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => kH16sizedBox,
                                    itemCount: messengerController.roomList.length,
                                    itemBuilder: (context, index) {
                                      RoomData item = messengerController.roomList[index];
                                      return InboxContainer(
                                          userID: item.id!,
                                          userName: item.roomName!,
                                          userImage: item.roomImage![0],
                                          message: "Test message",
                                          isActive: true,
                                          isMute: false,
                                          isLastMessageSelf: false,
                                          isSeen: true,
                                          receiverData: item,
                                          lastMessageTime: item.updatedAt!);
                                    }),
                                kH16sizedBox
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!messengerController.isInternetConnectionAvailable.value)
                    Positioned(
                      top: 1,
                      child: Container(
                        color: cPlaceHolderColor,
                        width: width,
                        height: 20,
                        child: Center(
                          child: Text(
                            "$ksWaitingForNetwork...",
                            style: regular10TextStyle(cBlackColor),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
