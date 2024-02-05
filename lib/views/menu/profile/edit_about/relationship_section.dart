import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class RelationshipSection extends StatelessWidget {
  RelationshipSection({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

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
              InfoContainer2(
                suffixText: ksRelationshipStatus.tr,
                suffixTextStyle: semiBold18TextStyle(cBlackColor),
                isAddButton: profileController.userData.value!.relation == null ? true : null,
                suffixOnPressed: () {
                  Get.toNamed(krEditRelationship);
                },
              ),
              // Text(
              //   ksRelationshipStatus.tr,
              //   style: semiBold18TextStyle(cBlackColor),
              // ),
              // kH12sizedBox,
              if (profileController.userData.value!.relation != null)
                Padding(
                  padding: const EdgeInsets.only(top: k12Padding),
                  child: InfoContainer2(
                    suffixText: '',
                    prefixText: profileController.relationshipStatus.value != ''
                        ? profileController.relationshipStatus.value
                        : checkNullOrStringNull(profileController.userData.value!.relation) ?? ksSelectRelationshipStatus,
                    isAddButton: false,
                    suffixOnPressed: () {},
                  ),
                ),
              // CustomSelectionButton(
              //   prefixIcon: BipHip.love,
              //   onPressed: () async {
              //     editProfileHelper.setRelationshipStatus(context);
              //   },
              //   text: profileController.relationshipStatus.value != ''
              //       ? profileController.relationshipStatus.value
              //       : checkNullOrStringNull(profileController.userData.value!.relation) ?? ksSelectRelationshipStatus,
              //   hintText: ksSelectRelationshipStatus.tr,
              // ),
              if (profileController.relationshipStatus.value != '' && profileController.showEditRelationshipStatus.value) kH12sizedBox,
              if (profileController.relationshipStatus.value != '' && profileController.showEditRelationshipStatus.value)
                CancelSaveButton(
                  onPressedCancel: () {
                    editProfileHelper.resetRelationshipStatus();
                  },
                  onPressedSave: () {
                    editProfileHelper.saveRelationshipStatus();
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
  final EditProfileHelper editProfileHelper = EditProfileHelper();

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
                            borderColor: profileController.temporaryRelationshipStatus.value == profileController.relationshipStatusList[index]
                                ? cPrimaryColor
                                : cLineColor,
                            onPressed: () {
                              editProfileHelper.selectBottomSheetRelationshipContent(index);
                            },
                            trailing: CustomRadioButton(
                              onChanged: () {
                                // profileController.tempRelationshipStatus.value = profileController.relationshipStatusList[index];
                                editProfileHelper.selectBottomSheetRelationshipContent(index);
                              },
                              isSelected: profileController.temporaryRelationshipStatus.value == profileController.relationshipStatusList[index],
                            ),
                            itemColor: profileController.temporaryRelationshipStatus.value == profileController.relationshipStatusList[index]
                                ? cPrimaryTint3Color
                                : cWhiteColor,
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

class EditRelationshipPage extends StatelessWidget {
  EditRelationshipPage({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: profileController.userData.value!.relation != null ? ksAddRelationship.tr : ksEditRelationship.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Obx(
            () => SizedBox(
              height: height - kAppBarSize - MediaQuery.of(context).padding.top,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    kH16sizedBox,
                    CustomSelectionButton(
                      buttonHeight: h60,
                      prefixIcon: BipHip.love,
                      onPressed: () async {
                        editProfileHelper.setRelationshipStatus(context);
                      },
                      text: profileController.relationshipStatus.value != ''
                          ? profileController.relationshipStatus.value
                          : checkNullOrStringNull(profileController.userData.value!.relation) ?? ksSelectRelationshipStatus,
                      hintText: ksSelectRelationshipStatus.tr,
                    ),
                    kH16sizedBox,
                    if (profileController.relationshipStatus.value != 'Single' &&
                        profileController.relationshipStatus.value != 'Separated' &&
                        profileController.relationshipStatus.value != '')
                      CustomSelectionButton(
                        buttonHeight: h60,
                        onPressed: () async {},
                        text: '',
                        hintText: ksPartner.tr,
                      ),
                    kH16sizedBox,
                    if (profileController.relationshipStatus.value != 'Single' &&
                        profileController.relationshipStatus.value != 'Separated' &&
                        profileController.relationshipStatus.value != '')
                      CustomSelectionButton(
                        buttonHeight: h60,
                        onPressed: () async {
                          editProfileHelper.relationshipDateButtonOnPressed(context);
                        },
                        text: profileController.relationshipDate.value != "" ? profileController.relationshipDate.value : "",
                        hintText: ksDate.tr,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
