
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';

class EditStoreCategory extends StatelessWidget {
  EditStoreCategory({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final FocusNode storeCategoryFocusNode = FocusNode();
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
                        title: ksSelectCategory.tr,
                        hasBackButton: true,
                        isCenterTitle: true,
                        onBack: () {
                    Get.back();
                  },
                  action: [
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
                    RawAutocomplete<String>(
                      textEditingController: storeController.storeCategoryTextEditingController,
                      focusNode: storeCategoryFocusNode,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return storeController.storeCategoryList.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                      },
                      onSelected: (option) {
                        storeController.storeCategoryTextEditingController.text = option;
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
                                      storeController.storeCategoryTextEditingController.text = option.toString();
                                      storeController.isStoreCategorySuffixIconVisible.value = true;
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
                            controller: storeController.storeCategoryTextEditingController,
                            hint: ksSelectCategory.tr,
                            suffixIcon: storeController.isStoreCategorySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                            onSuffixPress: () {
                              storeController.isStoreCategorySuffixIconVisible.value = false;
                              storeController.storeCategoryTextEditingController.clear();
                            },
                            onChanged: (text) {
                              if (storeController.storeCategoryTextEditingController.text.trim() != '') {
                                storeController.isStoreCategorySuffixIconVisible.value = true;
                              } else {
                                storeController.isStoreCategorySuffixIconVisible.value = false;
                              }
                            },
                            onSubmit: (text) {
                              storeController.isStoreCategorySuffixIconVisible.value = false;
                            },
                            inputAction: TextInputAction.done,
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
                        onPressed: ()async {
                          await storeController.updateStoreCategory();
                        }),
                    kH20sizedBox,
                  ],
                ),
              ),
            ),
          ),
          if (storeController.isStoreCategoryLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (storeController.isStoreCategoryLoading.value) {
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
