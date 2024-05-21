import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:intl/intl.dart';

class InboxContainer extends StatelessWidget {
  InboxContainer(
      {super.key,
      required this.userName,
      required this.userImage,
      required this.message,
      required this.isActive,
      required this.isSeen,
      required this.isMute,
      required this.isLastMessageSelf,
      required this.userID,
      required this.receiverData});
  final String userName, userImage, message;
  final bool isActive, isSeen, isMute, isLastMessageSelf;
  final int userID;
  final FriendFamilyUserData receiverData;
  final MessengerController messengerController = Get.find<MessengerController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        messengerController.messages.clear();
        int index = messengerController.allFriendMessageList.indexWhere((user) => user['userID'] == userID);
        if (index != -1 && messengerController.allFriendMessageList[index]["messages"].isNotEmpty) {
          messengerController.messages.addAll(messengerController.allFriendMessageList[index]["messages"]);
        }
        messengerController.selectedReceiver.value = receiverData;
        if (!messengerController.connectedUserID.contains(userID)) {
          messengerController.exchangePeerID(userID);
        }
        Get.toNamed(krMessages);
      },
      child: Container(
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
                      userImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.user,
                        size: kIconSize24,
                        color: cIconColor,
                      ),
                    ),
                  ),
                ),
                if (isActive)
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
                    ),
                  )
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
                    userName,
                    style: isSeen ? regular16TextStyle(cBlackColor) : semiBold16TextStyle(cBlackColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(
                          "${isLastMessageSelf ? "You:" : ""} ${message}",
                          style: isSeen ? regular14TextStyle(cSmallBodyTextColor) : semiBold14TextStyle(cBlackColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "  • ${DateFormat('h:mm a').format(DateTime.now())}",
                        style: isSeen ? regular14TextStyle(cSmallBodyTextColor) : semiBold14TextStyle(cBlackColor),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (isMute)
              const Icon(
                Icons.notifications_off_rounded,
                color: cIconColor,
                size: kIconSize14,
              ),
            if (isSeen)
              ClipOval(
                child: Container(
                  height: h14,
                  width: h14,
                  decoration: const BoxDecoration(
                    color: cBlackColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    userImage,
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
      ),
    );
  }
}
