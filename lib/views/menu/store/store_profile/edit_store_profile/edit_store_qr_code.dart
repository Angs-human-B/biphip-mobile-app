import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';

class EditStoreQrCode extends StatelessWidget {
  EditStoreQrCode({super.key});
  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(() => Stack(
              children: [
                SafeArea(
                  top: false,
                  child: Scaffold(
                    backgroundColor: cWhiteColor,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kAppBarSize),
                      //* info:: appBar
                      child: CustomAppBar(
                        appBarColor: cWhiteColor,
                      title: storeController.qrCode.value == ""? ksAddQrCode : ksEditQrCode.tr,
                  hasBackButton: true,
                  isCenterTitle: true,
                  onBack: () {
                    Get.back();
                  },
                  action: [
                    if(storeController.qrCode.value != "")
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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    kH16sizedBox,
                    kH8sizedBox,
                    CustomModifiedTextField(
                      controller: storeController.storeQrCodeTextEditingController,
                      hint: "${ksQrCodeHere.tr}...",
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
                        onPressed: () async{
                          await storeController.updateStoreQrCode();
                        }),
                    kH20sizedBox,
                  ],
                ),
              ),
            ),
          ),
            if (storeController.isStoreQrCodeLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (storeController.isStoreQrCodeLoading.value) {
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
