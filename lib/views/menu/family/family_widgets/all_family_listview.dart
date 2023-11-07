import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/shimmer_views/family/all_received_family_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/menu/friends_family/friend_family_button_action.dart';
import 'package:flutter/rendering.dart';

class AllFamilyListView extends StatelessWidget {
  AllFamilyListView({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _familyController.isFamilyListLoading.value
          ? const AllReceivedFamilyShimmer()
          : _familyController.familyList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_familyController.familyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_familyController.familyListScrolled.value) {
                      _familyController.familyListScrolled.value = true;
                      if (_familyController.familyList.isNotEmpty) {
                        _familyController.getMoreFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _familyController.familyListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _familyController.familyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k16Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: FriendFamilyButtonAction(
                                      backgroundImage: _familyController.familyList[index].profilePicture.toString(),
                                      imageSize: h50,
                                      name: _familyController.familyList[index].fullName ?? ksNA.tr,
                                      icon: BipHip.relation,
                                      subTitle: _familyController.familyList[index].familyRelationStatus ?? ksNA.tr,
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
                          if (_familyController.familyList.isNotEmpty && !_familyController.familyListScrolled.value)
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

