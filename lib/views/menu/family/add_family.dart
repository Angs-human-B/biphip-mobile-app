import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/menu/family/family_helper.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/shimmers/menu/family/relation_content_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/views/menu/family/widgets/relation_content.dart';

class AddFamily extends StatelessWidget {
  AddFamily({super.key, this.name, this.profilePicture});
  final String? name;
  final String? profilePicture;
  final FamilyController familyController = Get.find<FamilyController>();
  final FriendController friendController = Get.find<FriendController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final FamilyHelper familyHelper = FamilyHelper();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        unFocus(context);
        Get.back();
        Get.find<GlobalController>().searchController.clear();
        Get.find<FamilyController>().isFamilySuffixIconVisible.value = false;
        return true;
      },
      child: Container(
        color: cWhiteColor,
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                top: false,
                child: Scaffold(
                  backgroundColor: cWhiteColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kAppBarSize),
                    //* info:: appBar
                    child: CustomAppBar(
                      title: ksAddFamilyMember.tr,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        globalController.searchController.clear();
                        Get.back();
                        familyController.isFamilySuffixIconVisible.value = false;
                      },
                      action: [
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(right: h20),
                              child: TextButton(
                                style: kTextButtonStyle,
                                onPressed: (familyController.relationId.value == -1 || familyController.userId.value == -1)
                                    ? null
                                    : () {
                                        unfocus(context);
                                        familyHelper.addFamily();
                                      },
                                child: Text(
                                  ksSend.tr,
                                  style: (familyController.relationId.value == -1 || familyController.userId.value == -1)
                                      ? semiBold16TextStyle(cIconColor)
                                      : semiBold16TextStyle(cPrimaryColor),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (name != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Container(
                                width: width - 40,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: cGreyBoxColor,
                                  borderRadius: BorderRadius.circular(k4BorderRadius),
                                ),
                                child: Row(
                                  children: [
                                    kW12sizedBox,
                                    ClipOval(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          profilePicture.toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(kiProfileDefaultImageUrl);
                                          },
                                          loadingBuilder: imageLoadingBuilder,
                                        ),
                                      ),
                                    ),
                                    kW8sizedBox,
                                    Text(
                                      name!,
                                      style: regular16TextStyle(cBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (name == null && familyController.selectedAddFamilyFullName.value == '')
                            RawAutocomplete<FriendFamilyUserData>(
                              textEditingController: globalController.searchController,
                              focusNode: familyController.addFamilyFocusNode,
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return friendController.temporaryFriendList;
                                }
                                return friendController.temporaryFriendList.where((FriendFamilyUserData option) {
                                  return option.fullName!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (option) {
                                unFocus(context);
                                familyController.isFamilySuffixIconVisible.value = false;
                                globalController.searchController.text = option.fullName!;
                                familyController.userId.value = option.id!;
                                familyController.selectedAddFamilyFullName.value = option.fullName.toString();
                                familyController.selectedAddFamilyProfilePicture.value = option.profilePicture.toString();
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
                                            leading: ClipOval(
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.network(
                                                  option.profilePicture.toString(),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Image.asset(kiProfileDefaultImageUrl);
                                                  },
                                                  loadingBuilder: imageLoadingBuilder,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              option.fullName.toString(),
                                              style: medium16TextStyle(cBlackColor),
                                            ),
                                            onPressed: () {
                                              onSelected(option);
                                              globalController.searchController.text = option.fullName.toString();
                                              familyController.userId.value = option.id!;
                                              unfocus(context);
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
                                    borderRadius: h8,
                                    controller: globalController.searchController,
                                    focusNode: focusNode,
                                    prefixIcon: BipHip.search,
                                    suffixIcon: familyController.isFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                    hint: ksSearch.tr,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: k12Padding,
                                    ),
                                    textInputStyle: regular16TextStyle(cBlackColor),
                                    onSuffixPress: () {
                                      familyHelper.familySearchReset();
                                    },
                                    onSubmit: (v) {
                                      unfocus(context);
                                      familyController.isFamilySuffixIconVisible.value = false;
                                    },
                                    onChanged: (v) {
                                      familyHelper.addSearchResultToFamilyList();
                                    },
                                  ),
                                );
                              },
                            ),
                       
                          if (familyController.selectedAddFamilyFullName.value != '' && name == null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Container(
                                width: width - 40,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: cGreyBoxColor,
                                  borderRadius: BorderRadius.circular(k4BorderRadius),
                                ),
                                child: Row(
                                  children: [
                                    kW12sizedBox,
                                    ClipOval(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          familyController.selectedAddFamilyProfilePicture.value.toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(kiProfileDefaultImageUrl);
                                          },
                                          loadingBuilder: imageLoadingBuilder,
                                        ),
                                      ),
                                    ),
                                    kW8sizedBox,
                                    Text(
                                      familyController.selectedAddFamilyFullName.value,
                                      style: regular16TextStyle(cBlackColor),
                                    ),
                                    const Spacer(),
                                    CustomIconButton(
                                      icon: BipHip.circleCrossNew,
                                      size: screenWiseSize(kIconSize20, 4),
                                      iconColor: cIconColor,
                                      onPress: () {
                                        familyController.selectedAddFamilyFullName.value = '';
                                        familyController.selectedAddFamilyProfilePicture.value = '';
                                        globalController.searchController.text = '';
                                        familyController.userId.value = -1;
                                      },
                                    ),
                                    kW8sizedBox,
                                  ],
                                ),
                              ),
                            ),
                          kH12sizedBox,
                          CustomSelectionButton(
                            hintText: ksSelectRelation.tr,
                            text: familyController.relation.value,
                            onPressed: () async {
                              familyHelper.setRelationBottomSheetValue();
                              familyController.isFamilyRelationListLoading.value = true;
                              Get.find<GlobalController>().commonBottomSheet(
                                context: context,
                                isBottomSheetRightButtonActive: familyController.familyRelationBottomSheetRightButtonState,
                                isScrollControlled: true,
                                isSearchShow: false,
                                bottomSheetHeight: height * .9,
                                content: Obx(() => familyController.isFamilyRelationListLoading.value ? const RelationContentShimmer() : RelationContent()),
                                onPressCloseButton: () {
                                  unFocus(context);
                                  Get.back();
                                },
                                onPressRightButton: () {
                                  unfocus(context);
                                  familyHelper.selectRelation();
                                },
                                rightText: ksDone.tr,
                                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                title: ksSelectRelation.tr,
                                isRightButtonShow: true,
                              );
                              await familyController.getFamilyRelationList();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (familyController.isSendFamilyRequestLoading.value == true)
                Positioned(
                  child: CommonLoadingAnimation(
                    onWillPop: () async {
                      if (familyController.isSendFamilyRequestLoading.value) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
