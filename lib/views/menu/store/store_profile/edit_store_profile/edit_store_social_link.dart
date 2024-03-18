import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/post/create_post.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class EditStoreSocialLink extends StatelessWidget {
  EditStoreSocialLink({super.key});
  final StoreController storeController = Get.find<StoreController>();
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
            child: Obx(
              () => CustomAppBar(
                appBarColor: cWhiteColor,
                // title: '${profileController.commonEditPageTitle}'.tr,
                title: storeController.isEditOrAdd.value ? ksEditSocialLink.tr : ksAddSocialLink.tr,
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  Get.back();
                },
                action: [
                  if (storeController.isEditOrAdd.value)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomTextButton(
                          onPressed: () {
                            deleteAlertDialog(
                                context: context,
                                content: DeletePopupContent(
                                    text: ksDeleteConfirmation.tr,
                                    deleteOnPressed: () {
                                      // editProfileHelper.selectFunction("${profileController.functionFlag.value} DELETE", profileController.deleteIndex.value);
                                      Get.back();
                                      Get.back();
                                    }),
                                title: ksConfirmation.tr);
                            // editProfileHelper.selectFunction("${profileController.functionFlag.value} DELETE", profileController.deleteIndex.value);
                            // Get.back();
                          },
                          text: ksDelete,
                          textStyle: semiBold14TextStyle(cRedColor)),
                    )
                ],
              ),
            ),
          ),
          body: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                children: [
                  kH16sizedBox,
                  TextAndIconRowSellingPost(
                    text:
                        storeController.selectedStoreSocialLinkSource.value == '' ? ksSelectLinkSource.tr : storeController.selectedStoreSocialLinkSource.value,
                    textStyle: regular16TextStyle(storeController.selectedStoreSocialLinkSource.value == '' ? cPlaceHolderColor : cBlackColor),
                    suffixIcon: BipHip.downArrow,
                    onPressed: () {
                      unfocus(context);
                      storeController.temporarySelectedStoreSocialLinkSource.value = storeController.selectedStoreSocialLinkSource.value;
                      if (storeController.temporarySelectedStoreSocialLinkSource.value == '') {
                        storeController.storeSocialLinkBottomSheetRightButtonState.value = false;
                      } else {
                        storeController.storeSocialLinkBottomSheetRightButtonState.value = true;
                      }
                      Get.find<GlobalController>().commonBottomSheet(
                          isBottomSheetRightButtonActive: storeController.storeSocialLinkBottomSheetRightButtonState,
                          context: context,
                          bottomSheetHeight: isDeviceScreenLarge() ? height * 0.5 : height * 0.6,
                          content: StoreSocialLinkSourceContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {
                            storeController.selectedStoreSocialLinkSource.value = storeController.temporarySelectedStoreSocialLinkSource.value;
                            Get.back();
                          },
                          rightText: ksDone.tr,
                          rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                          title: ksSelectRelation.tr,
                          isRightButtonShow: true);
                    },
                  ),
                  kH16sizedBox,
                  CustomModifiedTextField(
                    controller: storeController.storeSocialLinkTextEditingController,
                    hint: ksAddSocialLink.tr,
                    onChanged: (text) {},
                    onSubmit: (text) {},
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                    maxLength: 50,
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                      label: ksSave,
                      textStyle: semiBold14TextStyle(cWhiteColor),
                      buttonHeight: h42,
                      buttonWidth: width - 40,
                      onPressed: () {
                        Get.back();
                      }),
                  kH20sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StoreSocialLinkSourceContent extends StatelessWidget {
  StoreSocialLinkSourceContent({super.key});
  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: storeController.storeSocialLinkSourceList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        storeController.temporarySelectedStoreSocialLinkSource.value = storeController.storeSocialLinkSourceList[index].toString();
                        if (storeController.temporarySelectedStoreSocialLinkSource.value == '') {
                          storeController.storeSocialLinkBottomSheetRightButtonState.value = false;
                        } else {
                          storeController.storeSocialLinkBottomSheetRightButtonState.value = true;
                        }
                      },
                      buttonText: storeController.storeSocialLinkSourceList[index].toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor: storeController.temporarySelectedStoreSocialLinkSource.value == storeController.storeSocialLinkSourceList[index].toString()
                          ? cPrimaryColor
                          : cLineColor2,
                      buttonColor: storeController.temporarySelectedStoreSocialLinkSource.value == storeController.storeSocialLinkSourceList[index].toString()
                          ? cPrimaryTint3Color
                          : cWhiteColor,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )),
              );
            }),
      ],
    ));
  }
}
