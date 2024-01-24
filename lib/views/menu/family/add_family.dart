import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/menu/family/family_helper.dart';
import 'package:bip_hip/shimmers/menu/family/relation_content_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/views/menu/family/widgets/relation_content.dart';

class AddFamily extends StatelessWidget {
  AddFamily({super.key});
  final FamilyController familyController = Get.find<FamilyController>();
  final FriendController friendController = Get.find<FriendController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final FamilyHelper familyHelper = FamilyHelper();
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
                        RawAutocomplete(
                          textEditingController: globalController.searchController,
                          focusNode: familyController.addFamilyFocusNode,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return friendController.tempFriendList.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (option) {
                            globalController.searchController.text = option;
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
                                          familyHelper.addFamilySetAutoComplete(option: option);
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
                                ));
                          },
                        ),
                        kH12sizedBox,
                        CustomSelectionButton(
                          hintText: ksSelectRelation.tr,
                          text: familyController.relation.value,
                          onPressed: () async {
                            unFocus(context);
                            familyHelper.setRelationBottomSheetValue();
                            familyController.isFamilyRelationListLoading.value = true;
                            Get.find<GlobalController>().commonBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isSearchShow: false,
                              bottomSheetHeight: height * .9,
                              content: Obx(() => familyController.isFamilyRelationListLoading.value ? const RelationContentShimmer() : RelationContent()),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                familyHelper.selectRelation();
                                unfocus(context);
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
    );
  }
}
