import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/shimmers/menu/family/pending_family_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/views/menu/friends/widgets/friend_family_single_button_action.dart';
import 'package:flutter/rendering.dart';

class PendingFamilyListView extends StatelessWidget {
  PendingFamilyListView({super.key});
  final FamilyController familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => familyController.isSendFamilyRequestListLoading.value
          ? const PendingFamilyShimmer()
          : familyController.sendFamilyRequestList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (familyController.sendFamilyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !familyController.sendFamilyListScrolled.value) {
                      familyController.sendFamilyListScrolled.value = true;
                      if (familyController.sendFamilyRequestList.isNotEmpty) {
                        familyController.getMoreSendFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: familyController.sendFamilyListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.separated(
                              itemCount: familyController.sendFamilyRequestList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                  child: FriendFamilySingleButtonAction(
                                    backgroundImage: familyController.sendFamilyRequestList[index].profilePicture.toString(),
                                    imageSize: h45,
                                    name: familyController.sendFamilyRequestList[index].fullName ?? ksNA.tr,
                                    subTitle: familyController.sendFamilyRequestList[index].familyRelationStatus ?? ksNA.tr,
                                    buttonText: ksCancelRequest.tr,
                                    buttonOnPressed: () async {
                                      familyController.userId.value = familyController.sendFamilyRequestList[index].id!;
                                      await familyController.cancelFamilyRequest();
                                    },
                                    buttonColor: cWhiteColor,
                                    borderColor: cRedColor,
                                    textStyle: semiBold14TextStyle(cRedColor),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (familyController.sendFamilyRequestList.isNotEmpty &&
                              familyController.sendFamilyListScrolled.value &&
                              familyController.sendFamilyListSubLink.value != null)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: Container(alignment: Alignment.center, child: EmptyView(title: ksNoFamilyRequestSendYet.tr))),
    );
  }
}
