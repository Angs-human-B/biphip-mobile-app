import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/shimmer/menu/family/all_received_family_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/menu/friends_family/friend_family_button_action.dart';
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
                            child: ListView.builder(
                              itemCount: familyController.familyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k16Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: FriendFamilyButtonAction(
                                      backgroundImage: familyController.familyList[index].profilePicture.toString(),
                                      imageSize: h50,
                                      name: familyController.familyList[index].fullName ?? ksNA.tr,
                                      icon: BipHip.relation,
                                      subTitle: familyController.familyList[index].familyRelationStatus ?? ksNA.tr,
                                      firstButtonText: ksMessage.tr,
                                      secondButtonText: ksBlock.tr,
                                      firstButtonOnPressed: () {},
                                      secondButtonOnPressed: () {},
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (familyController.familyList.isNotEmpty && !familyController.familyListScrolled.value)
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

