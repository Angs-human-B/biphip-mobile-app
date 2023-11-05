import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/family/family.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class AddFamily extends StatelessWidget {
  AddFamily({super.key});
  final FamilyController _familyController = Get.find<FamilyController>();
  final FriendController _friendController = Get.find<FriendController>();
  final ProfileController profileController = Get.find<ProfileController>();
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
                    },
                    action: [
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(right: h20),
                            child: TextButton(
                              style: kTextButtonStyle,
                              onPressed: (_familyController.relationId.value == -1 || _familyController.userId.value == -1)
                                  ? null
                                  : () async {
                                      unfocus(context);
                                      await _familyController.sendFamilyRequest();
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
                                // height: 200,
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
                                          profileController.searchController.text = option.toString();

                                          for (int i = 0; i < _friendController.friendListForAddFamily.length; i++) {
                                            if (_friendController.friendListForAddFamily[i].fullName == option) {
                                              _familyController.userId.value = _friendController.friendListForAddFamily[i].id!;
                                            }
                                          }
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
                                  suffixIcon:
                                      _familyController.isAddFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null, 
                                  hint: ksSearch.tr,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: k12Padding,
                                  ),
                                  textInputStyle: regular16TextStyle(cBlackColor),
                                  onSuffixPress: () {
                                    profileController.searchController.clear();
                                    _familyController.isAddFamilySuffixIconVisible.value = false;
                                  },
                                  onSubmit: (v) {
                                    unfocus(context);
                                    _familyController.isAddFamilySuffixIconVisible.value = false;
                                  },
                                  onChanged: (v) async {
                                    if (profileController.searchController.text.trim() != '') {
                                      _familyController.isAddFamilySuffixIconVisible.value = true;
                                    } else {
                                      _familyController.isAddFamilySuffixIconVisible.value = false;
                                    }
                                    for (int i = 0; i < _friendController.tempFriendList.length; i++) {
                                      if (_friendController.tempFriendList[i] == profileController.searchController.text.trim()) {
                                        _familyController.userId.value = _friendController.friendList[i].id!;
                                      }
                                      if (_friendController.tempFriendList[i] != profileController.searchController.text) {
                                        _familyController.userId.value = -1;
                                      }
                                    }
                                  },
                                ));
                          },
                        ),

                        kH12sizedBox,
                        CustomSelectionButton(
                          hintText: ksSelectRelation.tr,
                          text: _familyController.relation.value,
                          onPressed: () async {
                            if (_familyController.relationId.value != -1) {
                              _familyController.relationStatusId.value = _familyController.relationId.value - 1;
                            } else {
                              _familyController.relationStatusId.value = -1;
                            }
                              if (_familyController.relationStatusId.value == -1) {
                                    Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                                  } else {
                                    Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                                  }
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
                                _familyController.isFamilyRelationListLoading.value = true;
                                _familyController.relationId.value = _familyController.relationStatusId.value + 1;
                                for (int index = 0; index < _familyController.familyRelationList.length; index++) {
                                  if (_familyController.relationStatusId.value == index) {
                                    _familyController.relation.value = _familyController.familyRelationList[index].name;
                                  }
                                }
                                Get.back();
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

class RelationContentShimmer extends StatelessWidget {
  const RelationContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: k12Padding),
          child: CustomListTile(
            borderColor: cLineColor,
            title: ShimmerCommon(
              widget: Container(
                decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                height: 16,
                width: 120,
              ),
            ),
            trailing: ShimmerCommon(
              widget: Container(
                decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                height: 16,
                width: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
