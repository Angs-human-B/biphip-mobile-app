import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/post/create_post.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class EditStorePayment extends StatelessWidget {
  EditStorePayment({super.key});
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
                title: storeController.isEditOrAdd.value ? ksEditPayment.tr : ksAddPayment.tr,
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
                                      Get.back();
                                      Get.back();
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
                    text: storeController.selectedStorePaymentMethod.value == '' ? ksSelectPaymentMethod.tr : storeController.selectedStorePaymentMethod.value,
                    textStyle: regular16TextStyle(storeController.selectedStorePaymentMethod.value == '' ? cPlaceHolderColor : cBlackColor),
                    suffixIcon: BipHip.downArrow,
                    onPressed: () {
                      unfocus(context);
                      storeController.temporarySelectedStorePaymentMethod.value = storeController.selectedStorePaymentMethod.value;
                      if (storeController.temporarySelectedStorePaymentMethod.value == '') {
                        storeController.storePaymentMethodBottomSheetRightButtonState.value = false;
                      } else {
                        storeController.storePaymentMethodBottomSheetRightButtonState.value = true;
                      }
                      Get.find<GlobalController>().commonBottomSheet(
                          isBottomSheetRightButtonActive: storeController.storePaymentMethodBottomSheetRightButtonState,
                          context: context,
                          bottomSheetHeight: isDeviceScreenLarge() ? height * 0.5 : height * 0.6,
                          content: StorePaymentMethodContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {
                            storeController.selectedStorePaymentMethod.value = storeController.temporarySelectedStorePaymentMethod.value;
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
                    controller: storeController.storePaymentTextEditingController,
                    hint: ksAddPayment.tr,
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

class StorePaymentMethodContent extends StatelessWidget {
  StorePaymentMethodContent({super.key});
  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: storeController.storePaymentMethodList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        storeController.temporarySelectedStorePaymentMethod.value = storeController.storePaymentMethodList[index].toString();
                        if (storeController.temporarySelectedStorePaymentMethod.value == '') {
                          storeController.storePaymentMethodBottomSheetRightButtonState.value = false;
                        } else {
                          storeController.storePaymentMethodBottomSheetRightButtonState.value = true;
                        }
                      },
                      buttonText: storeController.storePaymentMethodList[index].toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor: storeController.temporarySelectedStorePaymentMethod.value == storeController.storePaymentMethodList[index].toString()
                          ? cPrimaryColor
                          : cLineColor2,
                      buttonColor: storeController.temporarySelectedStorePaymentMethod.value == storeController.storePaymentMethodList[index].toString()
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
