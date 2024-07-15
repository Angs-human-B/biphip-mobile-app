import 'package:bip_hip/utils/constants/imports.dart';
import 'package:intl/intl.dart';

class InboxContainer extends StatelessWidget {
  const InboxContainer({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
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
                Icons.notifications_off_rounded,
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
      ),
    );
  }
}
