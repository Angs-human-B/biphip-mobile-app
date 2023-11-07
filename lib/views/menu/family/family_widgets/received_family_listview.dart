import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/shimmer_views/family/all_received_family_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/menu/friends_family/friend_family_button_action.dart';
import 'package:flutter/rendering.dart';

class ReceivedFamilyListView extends StatelessWidget {
  ReceivedFamilyListView({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _familyController.isReceivedFamilyListLoading.value
          ? const AllReceivedFamilyShimmer()
          : _familyController.receivedFamilyList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_familyController.receivedFamilyListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_familyController.receivedFamilyListScrolled.value) {
                      _familyController.receivedFamilyListScrolled.value = true;
                      if (_familyController.receivedFamilyList.isNotEmpty) {
                        _familyController.getMoreReceivedFamilyList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _familyController.receivedFamilyListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _familyController.receivedFamilyList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k16Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: FriendFamilyButtonAction(
                                      backgroundImage: _familyController.receivedFamilyList[index].profilePicture.toString(),
                                      imageSize: h50,
                                      name: _familyController.receivedFamilyList[index].fullName ?? ksNA.tr,
                                      subTitle: '${ksGotRequestToBeA.tr} ${_familyController.receivedFamilyList[index].familyRelationStatus}',
                                      firstButtonText: ksConfirm.tr,
                                      secondButtonText: ksCancel.tr,
                                      firstButtonOnPressed: () async {
                                        _familyController.userId.value = _familyController.receivedFamilyList[index].id!;
                                        await _familyController.acceptFamilyRequest();
                                      },
                                      secondButtonOnPressed: () async {
                                        _familyController.userId.value = _familyController.receivedFamilyList[index].id!;
                                        await _familyController.rejectFamilyRequest();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_familyController.receivedFamilyList.isNotEmpty && !_familyController.receivedFamilyListScrolled.value)
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

