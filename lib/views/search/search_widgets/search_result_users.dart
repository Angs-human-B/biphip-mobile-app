import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SearchResultUsers extends StatelessWidget {
  SearchResultUsers({super.key});

  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH12sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: SizedBox(
            width: width,
            child: Text(
              ksPeople.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
          child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(k0Padding),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allSearchController.userList.length,
              separatorBuilder: (context, index) => kH8sizedBox,
              itemBuilder: (context, index) {
                final item = allSearchController.userList[index];
                return Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: h40,
                        height: h40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cWhiteColor,
                        ),
                        child: Image.network(
                          item.profilePicture ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.user,
                            size: kIconSize20,
                            color: cIconColor,
                          ),
                          loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                    ),
                    kW12sizedBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.fullName ?? "",
                            style: semiBold16TextStyle(cBlackColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                          kH4sizedBox,
                          Text(
                            "${item.mutualFriend.toString()} mutual friends",
                            style: regular10TextStyle(cSmallBodyTextColor),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.friendStatus == 1 ? ksMessage.tr : ksAddFriend.tr,
                      style: regular12TextStyle(cPrimaryColor),
                    ),
                  ],
                );
              }),
        ),
        kH16sizedBox,
      ],
    );
  }
}
