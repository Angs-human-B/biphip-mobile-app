import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/family/family.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class AddFamily extends StatelessWidget {
  const AddFamily({super.key});

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
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Obx(() => Column(
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
                          Get.find<ProfileController>().selectRelationTextChange();
                          Get.back();
                        },
                        rightText: ksOk.tr,
                        rightTextStyle: medium14TextStyle(cPrimaryColor),
                        title: ksSelectRelation.tr,
                        isRightButtonShow: true,
                      );
                    },
                  ),
                  kH20sizedBox,
                  Row(
                    children: [
                      Obx(
                        () => CustomElevatedButton(
                          isCustomButton: true,
                          label: Get.find<CreatePostController>().postType.value,
                          prefixIcon: Get.find<CreatePostController>().postTypeIcon.value,
                          onPressed: () {
                            unFocus(context);
                            Get.find<CreatePostController>().initializeAudienceText();
                            Get.find<CreatePostController>().showAudienceSheet(context);
                          },
                          buttonHeight: 40,
                          buttonWidth: width * .5,
                          suffixIcon: BipHip.downArrow,
                          buttonColor: cGreyBoxColor,
                          prefixIconColor: cBlackColor,
                          suffixIconColor: cBlackColor,
                          textStyle: medium14TextStyle(cBlackColor),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
