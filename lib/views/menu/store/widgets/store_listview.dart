import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class StoreListView extends StatelessWidget {
  StoreListView({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => storeController.isStoreListLoading.value
        ? const AllPendingFriendShimmer()
        : storeController.storeList.isNotEmpty
            ? Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding).copyWith(bottom: k0Padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => kH8sizedBox,
                          itemCount: storeController.storeList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                                child: CustomListTile(
                                  padding: const EdgeInsets.only(left: k8Padding, top: k8Padding, bottom: k8Padding),
                                  borderColor: cLineColor,
                                  leading: Container(
                                    height: h40,
                                    width: h40,
                                    decoration: const BoxDecoration(
                                      color: cWhiteColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        storeController.storeList[index].profilePicture.toString(),
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(kiProfileDefaultImageUrl);
                                        },
                                        loadingBuilder: imageLoadingBuilder,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    storeController.storeList[index].name ?? ksNA.tr,
                                    style: semiBold16TextStyle(cBlackColor),
                                  ),
                                  subtitle: const StoreSubTitleContent(
                                    notificationText: '2 Notification',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : StoreEmptyView(
                emptyViewImage: kiStoreImage,
                emptyText: ksNoStoreAddedYet.tr,
                emptyButtonText: ksAddStore.tr,
                onPressed: () {
                  storeController.resetStoreData();
                  Get.toNamed(krAddStoreBasicInfo);
                },
              ));
  }
}

class StoreSubTitleContent extends StatelessWidget {
  const StoreSubTitleContent({super.key, this.notificationText});
  final String? notificationText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: cPrimaryColor),
        ),
        kW4sizedBox,
        Text(
          notificationText.toString(),
          style: regular14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}

class StoreEmptyView extends StatelessWidget {
  const StoreEmptyView({
    super.key,
    required this.emptyViewImage,
    required this.emptyText,
    required this.emptyButtonText,
    required this.onPressed,
  });
  final String emptyViewImage;
  final String emptyText;
  final String emptyButtonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            emptyViewImage,
            height: 200,
          ),
          kH10sizedBox,
          Text(
            emptyText,
            style: semiBold20TextStyle(cSmallBodyTextColor),
          ),
          kH20sizedBox,
          CustomElevatedButton(
            buttonWidth: 120,
            buttonHeight: h44,
            label: emptyButtonText,
            onPressed: onPressed,
            prefixIcon: BipHip.plus,
          ),
        ],
      ),
    );
  }
}
