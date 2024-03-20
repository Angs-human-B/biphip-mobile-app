import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';

class EditStoreLocation extends StatelessWidget {
  EditStoreLocation({super.key});

  final StoreController storeController = Get.find<StoreController>();
  final FocusNode locationFocusNode = FocusNode();
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
                    appBarColor: cWhiteColor,
                    title: storeController.storeLocationTextEditingController.text == "" ? ksAddLocation.tr : ksEditLocation.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      if (storeController.isEditOrAdd.value)
                        if (storeController.qrCode.value != "")
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
                      RawAutocomplete<String>(
                        textEditingController: storeController.storeLocationTextEditingController,
                        focusNode: locationFocusNode,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return storeController.allLocationList.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                        },
                        onSelected: (option) {
                          storeController.storeLocationTextEditingController.text = option;
                        },
                        optionsViewBuilder: (context, Function(String) onSelected, options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: width - 40,
                              child: Material(
                                elevation: 4,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final option = options.elementAt(index);
                                    return CustomListTile(
                                      title: Text(
                                        option.toString(),
                                        style: medium16TextStyle(cBlackColor),
                                      ),
                                      onPressed: () {
                                        onSelected(option.toString());
                                        storeController.storeLocationTextEditingController.text = option.toString();
                                        storeController.isStoreLocationSuffixIconVisible.value = true;
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
                          return Obx(
                            () => CustomModifiedTextField(
                              focusNode: focusNode,
                              controller: storeController.storeLocationTextEditingController,
                              hint: ksAddLocation.tr,
                              prefixIcon: BipHip.location,
                              suffixIcon: storeController.isStoreLocationSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                              onSuffixPress: () {
                                storeController.isStoreLocationSuffixIconVisible.value = false;
                                storeController.storeLocationTextEditingController.clear();
                              },
                              onChanged: (text) {
                                if (storeController.storeLocationTextEditingController.text.trim() != '') {
                                  storeController.isStoreLocationSuffixIconVisible.value = true;
                                } else {
                                  storeController.isStoreLocationSuffixIconVisible.value = false;
                                }
                              },
                              onSubmit: (text) {
                                storeController.isStoreLocationSuffixIconVisible.value = false;
                              },
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.text,
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                          label: ksSave,
                          textStyle: semiBold14TextStyle(cWhiteColor),
                          buttonHeight: h42,
                          buttonWidth: width - 40,
                          onPressed: () async {
                            if(storeController.isEditOrAdd.value){
                            await storeController.updateStoreLocation();
                            }
                            else{
                            await storeController.storeStoreLocation();
                            }
                          }),
                      kH20sizedBox,
                    ],
                  ),
                ),
              ),
            ),
            if (storeController.isStoreLocationLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (storeController.isStoreLocationLoading.value) {
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
