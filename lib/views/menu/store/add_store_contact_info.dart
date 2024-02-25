import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class AddStoreContactInfo extends StatelessWidget {
  AddStoreContactInfo({super.key});
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
              title: ksCreateStore.tr,
              hasBackButton: false,
              leadingWidth: 80,
              leadingWidget: Center(
                child: InkWell(
                  onTap: () {
                    unFocus(context);
                    Get.back();
                  },
                  child: Text(
                    ksPrevious.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              ),
              isCenterTitle: true,
              onBack: () {},
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      unFocus(context);
                      storeController.resetStoreContactInfo();
                      Get.toNamed(krAddStoreSocialLinks);
                    },
                    child: Text(
                      ksSkip.tr,
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
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
                    title: ksContactInfo.tr,
                    subTitle: ksStoreInfoVisibleAllUser.tr,
                    circularCenterText: ks2of5.tr,
                    percent: 0.4,
                  ),
                  kH16sizedBox,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: CustomDivider(
                      thickness: 1,
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomModifiedTextField(
                            controller: storeController.storeEmailController,
                            hint: ksStoreEmail.tr,
                            errorText: storeController.storeEmailErrorText.value,
                            onChanged: (text) {
                              storeController.storeEmailValidation();
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.text,
                            maxLength: 50,
                          ),
                          kH8sizedBox,
                          CustomModifiedTextField(
                            controller: storeController.storePhoneController,
                            hint: ksStorePhone.tr,
                            onChanged: (text) {
                              storeController.checkContactInfoNextButtonEnabled();
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 15,
                          ),
                          kH8sizedBox,
                          CustomModifiedTextField(
                            controller: storeController.storeAddressController,
                            hint: ksStoreAddress.tr,
                            onChanged: (text) {
                              storeController.checkContactInfoNextButtonEnabled();
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.text,
                            maxLength: 50,
                          ),
                          kH8sizedBox,
                          CustomModifiedTextField(
                            controller: storeController.storeBioController,
                            hint: ksStoreBio.tr,
                            onChanged: (text) {
                              storeController.storeBioCount.value = text.length;
                              storeController.checkContactInfoNextButtonEnabled();
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.newline,
                            inputType: TextInputType.multiline,
                            maxLines: 5,
                            maxLength: 255,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${storeController.storeBioCount.value}/255',
                                style: regular14TextStyle(cIconColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Obx(() => CustomElevatedButton(
                        buttonWidth: width - 40,
                        buttonHeight: h40,
                        label: ksNext.tr,
                        onPressed: storeController.isStoreContactInfoNextButtonEnabled.value
                            ? () {
                                unFocus(context);
                                Get.toNamed(krAddStoreSocialLinks);
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
