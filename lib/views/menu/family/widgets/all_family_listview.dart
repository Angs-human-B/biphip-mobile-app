import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/shimmers/menu/family/all_received_family_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/views/menu/friends/widgets/friend_family_button_action.dart';
import 'package:flutter/rendering.dart';

class AllFamilyListView extends StatelessWidget {
  AllFamilyListView({super.key});
  final FamilyController familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => familyController.isFamilyListLoading.value
          ? const AllReceivedFamilyShimmer()
          : familyController.familyList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (familyController.familyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !familyController.familyListScrolled.value) {
                      familyController.familyListScrolled.value = true;
                      if (familyController.familyList.isNotEmpty) {
                        familyController.getMoreFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: familyController.familyListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.separated(
                              itemCount: familyController.familyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                  child: Obx(() => FriendFamilyButtonAction(
                                        backgroundImage: familyController.familyList[index].profilePicture.toString(),
                                        imageSize: h50,
                                        name: familyController.familyList[index].fullName ?? ksNA.tr,
                                        icon: BipHip.relation,
                                        subTitle: familyController.familyList[index].familyRelationStatus ?? ksNA.tr,
                                        firstButtonText: ksMessage.tr,
                                        secondButtonText: familyController.familyBlockList[index] ? ksUnBlock.tr : ksBlock.tr,
                                        firstButtonOnPressed: () {
                                          unFocus(context);
                                        },
                                        secondButtonOnPressed: () async {
                                          unFocus(context);
                                          familyController.userId.value = familyController.familyList[index].id!;
                                          if (familyController.familyBlockList[index]) {
                                            await familyController.unBlockUser();
                                          } else {
                                            await familyController.blockUser();
                                          }
                                        },
                                      )),
                                );
                              },
                            ),
                          ),
                          if (familyController.familyList.isNotEmpty &&
                              familyController.familyListScrolled.value &&
                              familyController.familyListSubLink.value != null)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: Container(alignment: Alignment.center, child: EmptyView(title: ksNoFamilyAddedYet.tr))),
    );
  }
}
