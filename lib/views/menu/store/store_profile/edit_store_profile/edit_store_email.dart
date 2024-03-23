import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';

class EditStoreEmail extends StatelessWidget {
  EditStoreEmail({super.key});
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
                      title: storeController.isEditOrAdd.value ? ksEditEmail.tr : ksAddEmail.tr,
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
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      kH16sizedBox,
                      kH8sizedBox,
                      CustomModifiedTextField(
                        controller: storeController.storeEmailTextEditingController,
                        prefixIcon: BipHip.mail,
                        hint: ksStoreEmail.tr,
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
                            if (storeController.isEditOrAdd.value) {
                              storeController.updateContact(storeController.storeContactId.value.toString(), "email");
                            } else {
                              storeController.storStoreContact("email");
                            }
                          }),
                      kH20sizedBox,
                    ],
                  ),
                ),
              ),
            ),
            if (storeController.isStoreContactLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (storeController.isStoreContactLoading.value) {
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
