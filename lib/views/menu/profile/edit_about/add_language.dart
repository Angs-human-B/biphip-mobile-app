import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class AddLanguagePage extends StatelessWidget {
  AddLanguagePage({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();
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
                        textEditingController: profileController.searchLanguageTextEditingController,
                        focusNode: focusNode,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return profileController.allLanguageList.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                        },
                        onSelected: (option) {
                          unFocus(context);
                          profileController.searchLanguageTextEditingController.text = option;
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
                                        profileController.searchLanguageTextEditingController.text = option.toString();
                                        profileController.addedLanguage.value = option.toString();
                                        profileController.isSearchLanguageSuffixIconShowing.value = false;
                                        editProfileHelper.checkCanAddLanguage();
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
                              controller: profileController.searchLanguageTextEditingController,
                              hint: ksSelectLanguage.tr,
                              prefixIcon: BipHip.search,
                              suffixIcon: profileController.isSearchLanguageSuffixIconShowing.value ? BipHip.circleCrossNew : null,
                              inputType: TextInputType.text,
                              borderRadius: k8BorderRadius,
                              onSuffixPress: () {
                                profileController.searchLanguageTextEditingController.clear();
                                profileController.isSearchLanguageSuffixIconShowing.value = false;
                                editProfileHelper.checkCanAddLanguage();
                              },
                              onSubmit: (value) {
                                unFocus(context);
                                profileController.isSearchLanguageSuffixIconShowing.value = true;
                              },
                              onChanged: (value) {
                                profileController.addedLanguage.value = "";
                                profileController.isSearchLanguageSuffixIconShowing.value = true;
                                editProfileHelper.checkCanAddLanguage();
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
                      onPressed: profileController.isAddLanguageButtonEnabled.value
                          ? () async {
                              profileController.userLanguages.clear();
                              profileController.userLanguages.addAll(profileController.userData.value!.languages);
                              profileController.userLanguages.add(profileController.addedLanguage.value);
                              await profileController.storeLanguages(profileController.userLanguages);
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
