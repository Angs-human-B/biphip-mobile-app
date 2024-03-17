import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';

class EditStorePhoneNumber extends StatelessWidget {
  EditStorePhoneNumber({super.key});
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
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              // title: '${profileController.commonEditPageTitle}'.tr,
              title: ksEditPhone.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                // if (profileController.functionFlag.contains('EDIT'))
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                kH8sizedBox,
                CustomModifiedTextField(
                  controller: storeController.storePhoneNumberTextEditingController,
                  hint: ksStorePhone.tr,
                  onChanged: (text) {},
                  onSubmit: (text) {},
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 15,
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
    );
  }
}
