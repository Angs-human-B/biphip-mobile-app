import 'dart:math';

import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/notification/notification_controller.dart';
import 'package:bip_hip/views/menu/friends/widgets/friend_family_button_action.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  final NotificationController notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksNotification.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k12Padding),
                  child: CustomIconButton(
                    onPress: () {},
                    icon: BipHip.setting,
                    iconColor: cBlackColor,
                    size: kIconSize20,
                  ),
                ),
              ],
            ),
          ),
          body: Obx(() => Column(
                children: [
                  kH16sizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: SizedBox(
                      height: h50,
                      child: CustomModifiedTextField(
                        controller: notificationController.notificationTextEditingController,
                        prefixIcon: BipHip.search,
                        hint: ksSearch,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: SizedBox(
                      width: width,
                      height: 50,
                      child: ListView.builder(
                        itemCount: notificationController.notificationFilterCategoryList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, i) {
                          return Obx(() => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                                child: CustomChoiceChips(
                                  label: notificationController.notificationFilterCategoryList[i],
                                  isSelected: (notificationController.selectedNotificationFilterCategory.value ==
                                      notificationController.notificationFilterCategoryList[i]),
                                  onSelected: (value) {
                                    notificationController.selectedNotificationFilterCategory.value = notificationController.notificationFilterCategoryList[i];
                                  },
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                  if (notificationController.selectedNotificationFilterCategory.value == "Marketplace") const EmptyNotificationView(),
                  if (notificationController.selectedNotificationFilterCategory.value != "Marketplace")
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            kH16sizedBox,
                            ListView.separated(
                                separatorBuilder: (context, index) => kH12sizedBox,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: notificationController.allNotificationList.length,
                                itemBuilder: (context, index) {
                                  return AllNotification(
                                    userImage: notificationController.allNotificationList[index]["userImage"],
                                    mentionUserName: notificationController.allNotificationList[index]["mentionUserName"],
                                    postUserName: notificationController.allNotificationList[index]["postUserName"],
                                    firstText: notificationController.allNotificationList[index]["firstText"],
                                    lastText: notificationController.allNotificationList[index]["lastText"],
                                    notificationTime: notificationController.allNotificationList[index]["notificationTime"],
                                    notificationOnPressed: () {
                                      Get.find<GlobalController>().blankBottomSheet(
                                          context: context,
                                          bottomSheetHeight: isDeviceScreenLarge() ? height * 0.2 : height * 0.3,
                                          content: NotificationBottomSheetContent(
                                            postType: notificationController.allNotificationList[index]["postType"],
                                          ));
                                    },
                                  );
                                }),
                            kH12sizedBox,
                            ListView.separated(
                              itemCount: notificationController.receivedFamilyRequestList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH8sizedBox,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: FriendFamilyButtonAction(
                                      backgroundImage: notificationController.receivedFamilyRequestList[index]["backgroundImage"],
                                      imageSize: h50,
                                      name: notificationController.receivedFamilyRequestList[index]["userName"],
                                      subTitle: '${ksGotRequestToBeA.tr} ${notificationController.receivedFamilyRequestList[index]["subtitle"]}',
                                      firstButtonText: ksConfirm.tr,
                                      secondButtonText: ksCancel.tr,
                                      firstButtonOnPressed: () async {
                                        // familyController.userId.value = familyController.receivedFamilyList[index].id!;
                                        // await familyController.acceptFamilyRequest();
                                      },
                                      secondButtonOnPressed: () async {
                                        // familyController.userId.value = familyController.receivedFamilyList[index].id!;
                                        // await familyController.rejectFamilyRequest();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            kH8sizedBox,
                          ],
                        ),
                      ),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}

class EmptyNotificationView extends StatelessWidget {
  const EmptyNotificationView({super.key});

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
            ksNoNotificationAvailable.tr,
            style: semiBold18TextStyle(cSmallBodyTextColor),
          ),
          kH4sizedBox,
          Text(
            "${ksYouDontHaveAnyNotification.tr}.",
            style: regular12TextStyle(cSmallBodyTextColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          )
        ],
      ),
    );
  }
}

class AllNotification extends StatelessWidget {
  const AllNotification(
      {super.key, this.userImage, this.mentionUserName, this.postUserName, this.firstText, this.lastText, this.notificationTime, this.notificationOnPressed});
  final String? userImage, mentionUserName, postUserName, firstText, lastText, notificationTime;
  final VoidCallback? notificationOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.network(
                    userImage ?? "",
                    width: h44,
                    height: h44,
                    fit: BoxFit.cover,
                    loadingBuilder: mediumImageLoadingBuilder,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      kiProfileDefaultImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: h20,
                  height: h20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: cGreyBoxColor,
                  ),
                  child: const Icon(
                    BipHip.chatFill,
                    size: kIconSize12,
                    color: cPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          kW8sizedBox,
          Expanded(
            child: RichText(
              maxLines: 4,
              textAlign: TextAlign.start,
              softWrap: true,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: mentionUserName,
                    style: semiBold14TextStyle(cBlackColor),
                  ),
                  TextSpan(text: " $firstText", style: regular14TextStyle(cBlackColor)),
                  TextSpan(
                    text: " $postUserName",
                    style: semiBold14TextStyle(cBlackColor),
                  ),
                  TextSpan(text: " $lastText.", style: regular14TextStyle(cBlackColor)),
                  TextSpan(text: "\n$notificationTime", style: semiBold12TextStyle(cPrimaryColor)),
                ],
              ),
            ),
          ),
          Transform.rotate(
              angle: pi / 2,
              child: CustomIconButton(
                onPress: notificationOnPressed,
                icon: BipHip.system,
                size: kIconSize20,
              )),
        ],
      ),
    );
  }
}

class NotificationBottomSheetContent extends StatelessWidget {
  const NotificationBottomSheetContent({super.key, required this.postType});
  final String postType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (postType == "Post")
          CustomListTile(
            leading: const Icon(BipHip.notificationOutline, size: kIconSize20, color: cBlackColor),
            title: Text(
              ksTurnOffNotificationForThisPost.tr,
              style: semiBold14TextStyle(cBlackColor),
            ),
          ),
        if (postType == "Birthday")
          CustomListTile(
            leading: const Icon(BipHip.notificationOutline, size: kIconSize20, color: cBlackColor),
            title: Text(
              "Turn off notification from Birthday".tr,
              style: semiBold14TextStyle(cBlackColor),
            ),
          ),
        if (postType == "Person")
          CustomListTile(
            leading: const Icon(BipHip.notificationOutline, size: kIconSize20, color: cBlackColor),
            title: Text(
              "Turn off notification from Aminul islam Rana".tr,
              style: semiBold14TextStyle(cBlackColor),
            ),
          ),
        CustomListTile(
          leading: const Icon(BipHip.notificationFill, size: kIconSize20, color: cBlackColor),
          title: Text(
            ksRemoveFromNotification.tr,
            style: semiBold14TextStyle(cBlackColor),
          ),
        ),
      ],
    );
  }
}
