import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class AddStoreBasicInfo extends StatelessWidget {
  AddStoreBasicInfo({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final FocusNode businessTypeFocusNode = FocusNode();
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
              title: ksCreateStore.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                unFocus(context);
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: height - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
              child: Column(
                children: [
                  const CustomDivider(
                    thickness: 1,
                  ),
                  KidTopTitleSubtitleAndCircularProgressBar(
                    title: ksBasicInfo.tr,
                    subTitle: ksOtherKnowAboutYourStore.tr,
                    circularCenterText: ks1of5.tr,
                    percent: 0.2,
                  ),
                  kH16sizedBox,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: CustomDivider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => CustomModifiedTextField(
                              controller: storeController.storeNameController,
                              hint: ksStoreName.tr,
                              errorText: storeController.storeNameErrorText.value,
                              onChanged: (text) {
                                storeController.storeNameOnChanged();
                              },
                              onSubmit: (text) {},
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.text,
                              maxLength: 50,
                            )),
                        kH8sizedBox,
                        RawAutocomplete<String>(
                          textEditingController: storeController.businessTypeTextEditingController,
                          focusNode: businessTypeFocusNode,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return storeController.businessType.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (option) {
                            storeController.businessTypeTextEditingController.text = option;
                            storeController.businessTypeErrorText();
                            storeController.checkNextButtonEnable();
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
                                          storeController.businessTypeTextEditingController.text = option.toString();
                                          storeController.isBusinessTypeSuffixIconVisible.value = true;
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
                                controller: storeController.businessTypeTextEditingController,
                                hint: ksSelectBusinessType.tr,
                                errorText: storeController.storeBusinessTypeErrorText.value,
                                suffixIcon: storeController.isBusinessTypeSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                onSuffixPress: () {
                                  storeController.isBusinessTypeSuffixIconVisible.value = false;
                                  storeController.businessTypeTextEditingController.clear();
                                  storeController.businessTypeErrorText();
                                  storeController.checkNextButtonEnable();
                                },
                                onChanged: (text) {
                                  storeController.businessTypeErrorText();
                                  storeController.checkNextButtonEnable();
                                  if (storeController.businessTypeTextEditingController.text.trim() != '') {
                                    storeController.isBusinessTypeSuffixIconVisible.value = true;
                                  } else {
                                    storeController.isBusinessTypeSuffixIconVisible.value = false;
                                  }
                                },
                                onSubmit: (text) {
                                  storeController.isBusinessTypeSuffixIconVisible.value = false;
                                },
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                            );
                          },
                        ),
                    
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Obx(() => CustomElevatedButton(
                        buttonWidth: width - 40,
                        buttonHeight: h40,
                        label: ksNext.tr,
                        onPressed: storeController.isNextButtonEnable.value
                            ? () {
                                unFocus(context);
                                Get.toNamed(krAddStoreContactInfo);
                              }
                            : null,
                        textStyle: semiBold16TextStyle(cWhiteColor),
                      )),
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
