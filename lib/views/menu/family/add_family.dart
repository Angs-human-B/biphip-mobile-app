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
                                height: 200,
                                child: Material(
                                  elevation: 4,
                                  child: ListView.separated(
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
                                          for (int i = 0; i < _friendController.friendList.length; i++) {
                                            if (_friendController.friendList[i].fullName == option) {
                                              _familyController.userId.value = _friendController.friendList[i].id!;
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
                            return CustomModifiedTextField(
                              borderRadius: h8,
                              controller: Get.find<ProfileController>().searchController,
                              focusNode: focusNode,
                              prefixIcon: BipHip.search,
                              suffixIcon: BipHip.voiceFill, // todo:: icon will be changed
                              hint: ksSearch.tr,
                              contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding),
                              textInputStyle: regular16TextStyle(cBlackColor),
                              onChanged: (v) {
                                for (int i = 0; i < _friendController.tempFriendList.length; i++) {
                                  if (_friendController.tempFriendList[i] == profileController.searchController.text.trim()) {
                                    _familyController.userId.value = _friendController.friendList[i].id!;
                                  }
                                  if (_friendController.tempFriendList[i] != profileController.searchController.text) {
                                    _familyController.userId.value = -1;
                                  }
                                }
                              },
                            );
                          },
                        ),

                        kH12sizedBox,
                        CustomSelectionButton(
                          hintText: ksSelectRelation.tr,
                          text: _familyController.relation.value,
                          onPressed: () async {
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
                              },
                              rightText: ksDone.tr,
                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                              title: ksSelectRelation.tr,
                              isRightButtonShow: true,
                            );
                            await _familyController.getFamilyRelationList();
                          },
                        ),
                        // kH20sizedBox,
                        // Row(
                        //   children: [
                        //     Obx(
                        //       () => CustomElevatedButton(
                        //         isCustomButton: true,
                        //         label: Get.find<CreatePostController>().postType.value,
                        //         prefixIcon: Get.find<CreatePostController>().postTypeIcon.value,
                        //         onPressed: () {
                        //           unFocus(context);
                        //           Get.find<CreatePostController>().initializeAudienceText();
                        //           Get.find<CreatePostController>().showAudienceSheet(context);
                        //         },
                        //         buttonHeight: 40,
                        //         buttonWidth: width * .5,
                        //         suffixIcon: BipHip.downArrow,
                        //         buttonColor: cGreyBoxColor,
                        //         prefixIconColor: cBlackColor,
                        //         suffixIconColor: cBlackColor,
                        //         textStyle: medium14TextStyle(cBlackColor),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
        return ListTile(
          title: ShimmerCommon(
            widget: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: k8CircularBorderRadius,
                color: cWhiteColor,
              ),
            ),
          ),
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }
}
