import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidAddLanguagePage extends StatelessWidget {
  KidAddLanguagePage({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();
  final FocusNode focusNode = FocusNode();

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
              title: ksAddLanguage.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Stack(
            children: [
              SizedBox(
                height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      kH16sizedBox,
                      RawAutocomplete(
                        textEditingController: kidsController.kidSearchLanguageTextEditingController,
                        focusNode: focusNode,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return kidsController.allLanguageList.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                        },
                        onSelected: (option) {
                          unFocus(context);
                          kidsController.kidSearchLanguageTextEditingController.text = option;
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
                                        unFocus(context);
                                        onSelected(option.toString());
                                        kidsController.kidSearchLanguageTextEditingController.text = option.toString();
                                        kidsController.addedLanguage.value = option.toString();
                                        kidsController.isSearchLanguageSuffixIconShowing.value = false;
                                        kidHelper.checkCanAddLanguage();
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
                              controller: kidsController.kidSearchLanguageTextEditingController,
                              hint: ksSelectLanguage.tr,
                              prefixIcon: BipHip.search,
                              suffixIcon: kidsController.isSearchLanguageSuffixIconShowing.value ? BipHip.circleCrossNew : null,
                              inputType: TextInputType.text,
                              borderRadius: k8BorderRadius,
                              onSuffixPress: () {
                                kidsController.kidSearchLanguageTextEditingController.clear();
                                kidsController.isSearchLanguageSuffixIconShowing.value = false;
                                kidHelper.checkCanAddLanguage();
                              },
                              onSubmit: (value) {
                                unFocus(context);
                                kidsController.isSearchLanguageSuffixIconShowing.value = true;
                              },
                              onChanged: (value) {
                                kidsController.addedLanguage.value = "";
                                kidsController.isSearchLanguageSuffixIconShowing.value = true;
                                kidHelper.checkCanAddLanguage();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Obx(
                  () => CustomElevatedButton(
                      label: ksAdd.tr,
                      textStyle: semiBold14TextStyle(cWhiteColor),
                      buttonHeight: h42,
                      buttonWidth: width - 40,
                      onPressed: kidsController.isAddLanguageButtonEnabled.value
                          ? () async {
                              Get.back();
                              // kidsController.kidLanguageList.clear();//!Api data
                              // kidsController.kidLanguageList.addAll(profileController.userData.value!.languages);//!Api Data
                              // kidsController.kidLanguageList.add(profileController.addedLanguage.value); //!Api Data
                              // await kidsController.storeLanguages(profileController.userLanguages); //!Api call
                            }
                          : null),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
