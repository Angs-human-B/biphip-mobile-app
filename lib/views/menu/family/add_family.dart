import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/family_helpers/family_helper.dart';
import 'package:bip_hip/shimmer_views/family/relation_content_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/menu/friends_family/relation_content.dart';

class AddFamily extends StatelessWidget {
  AddFamily({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  final FriendController _friendController = Get.find<FriendController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final FamilyHelper _familyHelper = FamilyHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Get.find<ProfileController>().searchController.clear();
                      Get.back();
                      _familyController.isFamilySuffixIconVisible.value = false;
                    },
                    action: [
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(right: h20),
                            child: TextButton(
                              style: kTextButtonStyle,
                              onPressed: (_familyController.relationId.value == -1 || _familyController.userId.value == -1)
                                  ? null
                                  : () {
                                      unfocus(context);
                                      _familyHelper.addFamilySendOnPressed();
                                    },
                              child: Text(
                                ksSend.tr,
                                style: (_familyController.relationId.value == -1 || _familyController.userId.value == -1)
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
                        RawAutocomplete(
                          textEditingController: profileController.searchController,
                          focusNode: _familyController.addFamilyFocusNode,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return _friendController.tempFriendList.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (option) {
                            profileController.searchController.text = option;
                          },
                          optionsViewBuilder: (context, Function(String) onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: width - 40,
                                child: Material(
                                  elevation: 4,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return CustomListTile(
                                        title: Text(
                                          option.toString(),
                                          style: medium16TextStyle(cBlackColor),
                                        ),
                                        onPressed: () {
                                          onSelected(option.toString());
                                          _familyHelper.addFamilyRawAutoCompleteOnPressed(option);
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
                            return Obx(() => CustomModifiedTextField(
                                  borderRadius: h8,
                                  controller: Get.find<ProfileController>().searchController,
                                  focusNode: focusNode,
                                  prefixIcon: BipHip.search,
                                  suffixIcon: _familyController.isFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                  hint: ksSearch.tr,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: k12Padding,
                                  ),
                                  textInputStyle: regular16TextStyle(cBlackColor),
                                  onSuffixPress: () {
                                    _familyHelper.addFamilySuffixPressed();
                                  },
                                  onSubmit: (v) {
                                    unfocus(context);
                                    _familyController.isFamilySuffixIconVisible.value = false;
                                  },
                                  onChanged: (v) {
                                    _familyController.addFamilyOnPressed();
                                  },
                                ));
                          },
                        ),
                        kH12sizedBox,
                        CustomSelectionButton(
                          hintText: ksSelectRelation.tr,
                          text: _familyController.relation.value,
                          onPressed: () async {
                            _familyHelper.addFamilyOnPressed();
                            unFocus(context);
                            _familyController.isFamilyRelationListLoading.value = true;
                            Get.find<GlobalController>().commonBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isSearchShow: false,
                              bottomSheetHeight: height * .9,
                              content: Obx(() => _familyController.isFamilyRelationListLoading.value ? const RelationContentShimmer() : RelationContent()),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                _familyHelper.addFamilyOnPressedRightButton();
                                unfocus(context);
                              },
                              rightText: ksDone.tr,
                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                              title: ksSelectRelation.tr,
                              isRightButtonShow: true,
                            );
                            await _familyController.getFamilyRelationList();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_familyController.isSendFamilyRequestLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_familyController.isSendFamilyRequestLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
