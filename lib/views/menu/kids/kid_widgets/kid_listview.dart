import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/shimmer/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_widgets/kid_edit_delete_content.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class KidsListView extends StatelessWidget {
  KidsListView({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => kidsController.isKidsListLoading.value
          ? const AllPendingFriendShimmer()
          : kidsController.kidList.isNotEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding).copyWith(bottom: k0Padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: kidsController.kidList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: k12Padding),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                  child: CustomListTile(
                                    padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding).copyWith(right: k0Padding),
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
                                          Environment.imageBaseUrl + kidsController.kidList[index].kidImage.toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(kiProfileDefaultImageUrl);
                                          },
                                          loadingBuilder: imageLoadingBuilder,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      kidsController.kidList[index].name ?? ksNA.tr,
                                      style: semiBold16TextStyle(cBlackColor),
                                    ),
                                    trailing: CustomIconButton(
                                        onPress: () {
                                          kidsController.kidId.value = kidsController.kidList[index].id!;
                                          globalController.commonBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            content: EditDeleteContent(),
                                            onPressCloseButton: () {
                                              Get.back();
                                            },
                                            onPressRightButton: null,
                                            rightText: ksDone.tr,
                                            rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                            title: ksAction.tr,
                                            isRightButtonShow: false,
                                            bottomSheetHeight: 150,
                                          );
                                        },
                                        icon: BipHip.system),
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
              : Expanded(
                  child: Container(alignment: Alignment.center, child: EmptyView(title: ksNoKidsAddedYet.tr)),
                ),
    );
  }
}