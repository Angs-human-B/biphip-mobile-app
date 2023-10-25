import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/family/family.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class AddFamily extends StatelessWidget {
  AddFamily({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FamilyController _familyController = Get.find<FamilyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksAddFamilyMember.tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
          },
          action: [
            Padding(
              padding: const EdgeInsets.only(right: h20),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () async {
                  unfocus(context);
                  await _familyController.sendFamilyRequest();
                  // Get.back();
                },
                child: Text(
                  ksSend.tr,
                  style: medium14TextStyle(cPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomModifiedTextField(
                borderRadius: h8,
                controller: Get.find<ProfileController>().searchController,
                prefixIcon: BipHip.search,
                suffixIcon: BipHip.voiceFill, // todo:: icon will be changed
                hint: ksSearch.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding),
                textInputStyle: regular16TextStyle(cBlackColor),
              ),
              kH12sizedBox,
              CustomSelectionButton(
                hintText: ksSelectRelation.tr,
                text: Get.find<ProfileController>().relation.value == "" ? '' : Get.find<ProfileController>().relation.value,
                onPressed: () {
                  unFocus(context);
                  Get.find<ProfileController>().initializeSelectedRelationText();
                  Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isSearchShow: false,
                    bottomSheetHeight: height * .9,
                    content: RelationContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      _profileController.selectRelationTextChange();
                      // _familyController.getFamilyRelationList();
                      for (int i = 0; i < _profileController.relationListState.length; i++) {
                        if (_profileController.relationListState[i]) {
                          _familyController.relationStatusId.value = i + 1;
                          break;
                        }
                      }
                      Get.back();
                    },
                    rightText: ksOk.tr,
                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                    title: ksSelectRelation.tr,
                    isRightButtonShow: true,
                  );
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
    );
  }
}

class FamilyRelationListShimmer extends StatelessWidget {
  const FamilyRelationListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: ShimmerCommon(
                widget: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: k8CircularBorderRadius,
                    color: cWhiteColor,
                  ),
                ),
              ),
              contentPadding: EdgeInsets.zero,
            );
          },
        ),
      ],
    );
  }
}
