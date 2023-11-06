import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profiler_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class RelationshipSection extends StatelessWidget {
  RelationshipSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH16sizedBox,
              Text(
                ksRelationshipStatus.tr,
                style: semiBold18TextStyle(cBlackColor),
              ),
              kH12sizedBox,
              CustomSelectionButton(
                prefixIcon: BipHip.love,
                onPressed: () async {
                  _editProfileHelper.setRelationshipStatus(context);
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
                    _editProfileHelper.resetRelationshipStatus();
                  },
                  onPressedSave: () {
                    _editProfileHelper.saveRelationshipStatus();
                  },
                ),
              kH16sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}

class RelationshipStatusListContent extends StatelessWidget {
  RelationshipStatusListContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
                              _editProfileHelper.selectBottomSheetRelationshipContent(index);
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
