import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/shimmers/profile/link_list_shimmer_view.dart';
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
                                          deleteOnPressed: () async {
                                            await storeController.deleteStoreLink();
                                          }),
                                      title: ksConfirmation.tr);
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
                          text: storeController.selectedStoreSocialLinkSource.value == ''
                              ? ksSelectLinkSource.tr
                              : storeController.selectedStoreSocialLinkSource.value,
                          textStyle: regular16TextStyle(storeController.selectedStoreSocialLinkSource.value == '' ? cPlaceHolderColor : cBlackColor),
                          suffixIcon: BipHip.downArrow,
                          onPressed: () async {
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
                                content: Obx(() => storeController.isLinkListLoading.value ? const LinkListContentShimmer() : StoreSocialLinkSourceContent()),
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
                            await storeController.getLinkList();
                          },
                        ),
                        kH16sizedBox,
                        CustomModifiedTextField(
                          controller: storeController.storeSocialLinkTextEditingController,
                          hint: ksAddSocialLink.tr,
                          onChanged: (text) {
                            if (storeController.selectedStoreSocialLinkSource.value != "" && storeController.storeSocialLinkTextEditingController.text != "") {
                              storeController.isStoreSocialLinkSaveEnabled.value = true;
                            } else {
                              storeController.isStoreSocialLinkSaveEnabled.value = false;
                            }
                          },
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
                            onPressed: storeController.isStoreSocialLinkSaveEnabled.value
                                ? () async {
                                    if (storeController.selectedStoreSocialLinkSource.value == 'Website' &&
                                        storeController.storeSocialLinkTextEditingController.text.toLowerCase().isValidUrl) {
                                      if (storeController.isEditOrAdd.value) {
                                        await storeController.updateStoreLink();
                                      } else {
                                        await storeController.storStoreLink();
                                      }
                                    } else if (commonValidUrlCheck(storeController.selectedStoreSocialLinkSource.value.toLowerCase(),
                                        storeController.storeSocialLinkTextEditingController.text.toLowerCase())) {
                                      if (storeController.isEditOrAdd.value) {
                                        await storeController.updateStoreLink();
                                      } else {
                                        await storeController.storStoreLink();
                                      }
                                    } else {
                                      Get.find<GlobalController>().showSnackBar(title: 'Warning', message: 'Please Enter a valid url', color: cAmberColor);
                                    }
                                  }
                                : null),
                        kH20sizedBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (storeController.isStoreLinkLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (storeController.isStoreLinkLoading.value) {
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
            itemCount: storeController.linkSourceList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        storeController.temporarySelectedStoreSocialLinkSource.value = storeController.linkSourceList[index].toString();
                        if (storeController.temporarySelectedStoreSocialLinkSource.value == '') {
                          storeController.storeSocialLinkBottomSheetRightButtonState.value = false;
                        } else {
                          storeController.storeSocialLinkBottomSheetRightButtonState.value = true;
                        }
                      },
                      buttonText: storeController.linkSourceList[index].toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor: storeController.temporarySelectedStoreSocialLinkSource.value == storeController.linkSourceList[index].toString()
                          ? cPrimaryColor
                          : cLineColor2,
                      buttonColor: storeController.temporarySelectedStoreSocialLinkSource.value == storeController.linkSourceList[index].toString()
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
