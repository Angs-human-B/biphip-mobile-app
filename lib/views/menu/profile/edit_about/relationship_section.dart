import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
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
                suffixOnPressed: () async {
                  editProfileHelper.resetRelationshipEditPage();
                  Get.toNamed(krEditRelationship);
                  await Get.find<FriendController>().getFriendList();
                  profileController.temporaryFriendList.addAll(Get.find<FriendController>().friendList);
                },
              ),
              if (profileController.userData.value!.relation != null)
                Padding(
                  padding: const EdgeInsets.only(top: k12Padding),
                  child: InfoContainer2(
                    suffixText: '',
                    prefixText: profileController.relationshipStatus.value != ''
                        ? profileController.relationshipStatus.value
                        : checkNullOrStringNull(profileController.userData.value!.relation) ?? ksSelectRelationshipStatus,
                    isAddButton: false,
                    suffixOnPressed: () async {
                      editProfileHelper.resetRelationshipEditPage();
                      editProfileHelper.setEditRelationshipPageValue();
                      Get.toNamed(krEditRelationship);
                      await Get.find<FriendController>().getFriendList();
                      profileController.temporaryFriendList.addAll(Get.find<FriendController>().friendList);
                    },
                  ),
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
  final FocusNode partnerFocusNode = FocusNode();

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
            () => Stack(
              children: [
                SizedBox(
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
                            unFocus(context);
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
                          RawAutocomplete<FriendFamilyUserData>(
                            textEditingController: profileController.relationshipPartnerTextEditingController,
                            focusNode: partnerFocusNode,
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<FriendFamilyUserData>.empty();
                              }
                              return profileController.temporaryFriendList.where((FriendFamilyUserData option) {
                                return option.fullName!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                              });
                            },
                            onSelected: (option) {
                              unFocus(context);
                              profileController.relationshipPartnerTextEditingController.text = option.fullName!;
                              profileController.relationshipPartnerID.value = option.id!;
                              editProfileHelper.checkCanSaveRelationship();
                            },
                            optionsViewBuilder: (context, AutocompleteOnSelected<FriendFamilyUserData> onSelected, Iterable<FriendFamilyUserData> options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: width - 40,
                                  child: Material(
                                    elevation: 4,
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final option = options.elementAt(index);
                                        return CustomListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(option.profilePicture!),
                                          ),
                                          title: Text(
                                            option.fullName.toString(),
                                            style: medium16TextStyle(cBlackColor),
                                          ),
                                          onPressed: () {
                                            unFocus(context);
                                            onSelected(option);
                                            profileController.relationshipPartnerTextEditingController.text = option.fullName.toString();
                                            profileController.relationshipPartnerID.value = option.id!;
                                            editProfileHelper.checkCanSaveRelationship();
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) => Container(
                                        height: 1,
                                        color: cLineColor,
                                      ),
                                      itemCount: options.length,
                                    ),
                                  ),
                                ),
                              );
                            },
                            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                              return Obx(
                                () => CustomModifiedTextField(
                                  focusNode: focusNode,
                                  controller: profileController.relationshipPartnerTextEditingController,
                                  hint: ksPartner.tr,
                                  suffixIcon: profileController.showRelationshipPartnerSuffixIcon.value ? BipHip.circleCrossNew : null,
                                  inputType: TextInputType.text,
                                  borderRadius: k8BorderRadius,
                                  onSuffixPress: () {
                                    profileController.relationshipPartnerTextEditingController.clear();
                                    profileController.relationshipPartnerID.value = -1;
                                    editProfileHelper.checkCanSaveRelationship();
                                    profileController.showRelationshipPartnerSuffixIcon.value = false;
                                  },
                                  onSubmit: (value) {
                                    unFocus(context);
                                    profileController.showRelationshipPartnerSuffixIcon.value = false;
                                    editProfileHelper.checkCanSaveRelationship();
                                  },
                                  onChanged: (value) {
                                    if (profileController.relationshipPartnerTextEditingController.text != '') {
                                      profileController.showRelationshipPartnerSuffixIcon.value = true;
                                    } else {
                                      profileController.showRelationshipPartnerSuffixIcon.value = false;
                                    }
                                    profileController.relationshipPartnerID.value = -1;
                                    editProfileHelper.checkCanSaveRelationship();
                                  },
                                ),
                              );
                            },
                          ),
                        kH16sizedBox,
                        if (profileController.relationshipStatus.value != 'Single' &&
                            profileController.relationshipStatus.value != 'Separated' &&
                            profileController.relationshipStatus.value != '')
                          CustomSelectionButton(
                            buttonHeight: h60,
                            onPressed: () async {
                              unFocus(context);
                              editProfileHelper.relationshipDateButtonOnPressed(context);
                            },
                            text: profileController.relationshipDate.value != "" ? profileController.relationshipDate.value : "",
                            hintText: ksDate.tr,
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Obx(
                    () => CustomElevatedButton(
                        label: ksSave,
                        textStyle: semiBold14TextStyle(cWhiteColor),
                        buttonHeight: h42,
                        buttonWidth: width - 40,
                        onPressed: profileController.isRelationshipSaveButtonActive.value
                            ? () async {
                                unFocus(context);
                                Get.back();
                                await profileController.storeUserSetting('relationship', profileController.relationshipStatus.value);
                                editProfileHelper.resetRelationshipEditPage();
                              }
                            : null),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
