import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/shimmers/menu/family/all_received_family_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/views/menu/friends/widgets/friend_family_button_action.dart';
import 'package:flutter/rendering.dart';

class ReceivedFamilyListView extends StatelessWidget {
  ReceivedFamilyListView({super.key});
  final FamilyController familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => familyController.isReceivedFamilyListLoading.value
          ? const AllReceivedFamilyShimmer()
          : familyController.receivedFamilyList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (familyController.receivedFamilyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !familyController.receivedFamilyListScrolled.value) {
                      familyController.receivedFamilyListScrolled.value = true;
                      if (familyController.receivedFamilyList.isNotEmpty) {
                        familyController.getMoreReceivedFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: familyController.receivedFamilyListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: familyController.receivedFamilyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k16Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: FriendFamilyButtonAction(
                                      backgroundImage: familyController.receivedFamilyList[index].profilePicture.toString(),
                                      imageSize: h50,
                                      name: familyController.receivedFamilyList[index].fullName ?? ksNA.tr,
                                      subTitle: '${ksGotRequestToBeA.tr} ${familyController.receivedFamilyList[index].familyRelationStatus}',
                                      firstButtonText: ksConfirm.tr,
                                      secondButtonText: ksCancel.tr,
                                      firstButtonOnPressed: () async {
                                        familyController.userId.value = familyController.receivedFamilyList[index].id!;
                                        await familyController.acceptFamilyRequest();
                                      },
                                      secondButtonOnPressed: () async {
                                        familyController.userId.value = familyController.receivedFamilyList[index].id!;
                                        await familyController.rejectFamilyRequest();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (familyController.receivedFamilyList.isNotEmpty &&
                              familyController.receivedFamilyListScrolled.value &&
                              familyController.receivedFamilyListSubLink.value != null)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: Container(alignment: Alignment.center, child: EmptyView(title: ksNoFamilyRequestReceivedYet.tr))),
    );
  }
}
