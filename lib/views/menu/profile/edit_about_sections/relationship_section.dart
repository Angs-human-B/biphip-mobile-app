import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/shimmer_views/profile/relation_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class RelationshipSection extends StatelessWidget {
  RelationshipSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          kH16sizedBox,
          Text(
            ksRelationshipStatus.tr,
            style: semiBold18TextStyle(cBlackColor),
          ),
          kH12sizedBox,
          CustomSelectionButton(
            prefixIcon: BipHip.love,
            onPressed: () async {
              _profileController.isRelationListLoading.value = true;
              _profileController.tempRelationshipStatus.value = '';
              if (_profileController.relationshipStatus.value != '') {
                _profileController.tempRelationshipStatus.value = _profileController.relationshipStatus.value;
              } else if (_profileController.userData.value!.relation != null) {
                _profileController.tempRelationshipStatus.value = checkNullOrStringNull(_profileController.userData.value!.relation);
              }
              if (_profileController.tempRelationshipStatus.value == '') {
                _globalController.isBottomSheetRightButtonActive.value = false;
              } else {
                _globalController.isBottomSheetRightButtonActive.value = true;
              }
              _globalController.commonBottomSheet(
                context: context,
                content: Obx(
                  () => _profileController.isRelationListLoading.value
                      ? const RelationshipStatusListShimmer()
                      : _RelationshipStatusListContent(
                          profileController: _profileController,
                        ),
                ),
                isScrollControlled: true,
                bottomSheetHeight: height * 0.6,
                onPressCloseButton: () {
                  Get.back();
                },
                onPressRightButton: () {
                  if (_profileController.tempRelationshipStatus.value != '') {
                    _profileController.relationshipStatus.value = _profileController.tempRelationshipStatus.value;
                    _profileController.showEditRelationshipStatus.value = true;
                  }
                  Get.back();
                },
                rightText: ksDone.tr,
                rightTextStyle: medium14TextStyle(cPrimaryColor),
                title: ksSelectRelationshipStatus.tr,
                isRightButtonShow: true,
              );
              await _profileController.getRelationshipList();
            },
            text: _profileController.relationshipStatus.value != ''
                ? _profileController.relationshipStatus.value
                : checkNullOrStringNull(_profileController.userData.value!.relation) ?? ksSelectRelationshipStatus,
            hintText: ksSelectRelationshipStatus.tr,
          ),
          if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value) kH12sizedBox,
          if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value)
            CancelSaveButton(
              onPressedCancel: () {
                _profileController.relationshipStatus.value = '';
                _profileController.showEditRelationshipStatus.value = false;
              },
              onPressedSave: () async {
                _profileController.storeUserSetting('relationship', _profileController.relationshipStatus.value);
                _profileController.showEditRelationshipStatus.value = false;
                _profileController.relationshipStatus.value = '';
              },
            ),
          kH16sizedBox,
        ]),
      ),
    );
  }
}

class _RelationshipStatusListContent extends StatelessWidget {
  const _RelationshipStatusListContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            profileController.relationshipStatusList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.relationshipStatusList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(bottom: k8Padding),
                          child: CustomListTile(
                            title: profileController.relationshipStatusList[index],
                            borderColor:
                                profileController.tempRelationshipStatus.value == profileController.relationshipStatusList[index] ? cPrimaryColor : cLineColor,
                            trailing: CustomRadioButton(
                              onChanged: () {
                                profileController.tempRelationshipStatus.value = profileController.relationshipStatusList[index];
                              },
                              isSelected: profileController.tempRelationshipStatus.value == profileController.relationshipStatusList[index],
                            ),
                            itemColor: profileController.tempRelationshipStatus.value == profileController.relationshipStatusList[index]
                                ? cPrimaryTint3Color
                                : cWhiteColor,
                            onPressed: () {
                              profileController.tempRelationshipStatus.value = profileController.relationshipStatusList[index];
                              if (profileController.tempRelationshipStatus.value == '') {
                                Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                              } else {
                                Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
                : EmptyView(
                    height: height * 0.45,
                    title: ksNoDataAvailable.tr,
                  ),
          ],
        ));
  }
}
