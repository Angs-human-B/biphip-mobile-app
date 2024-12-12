import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/menu/kids_controller.dart';
import '../../../../controllers/settings/privacy_settings_controller.dart';
import '../../../../shimmers/profile/gender_shimmer.dart';
import '../../../../utils/constants/imports.dart';

class LanguageListCheckboxPage extends StatefulWidget {
  const LanguageListCheckboxPage({super.key});

  @override
  LanguageListCheckboxPageState createState() =>
      LanguageListCheckboxPageState();
}

class LanguageListCheckboxPageState extends State<LanguageListCheckboxPage> {
  final KidsController kidsController = Get.find<KidsController>();
  final TextEditingController searchQueryCon = TextEditingController();
  final PrivacySettingsController privacySettingsController =
      Get.find<PrivacySettingsController>();

  // Use a List to store selected languages
   List<dynamic> selectedLanguages = [];

  @override
  void initState() {
    initFunc();
    super.initState();
  }

  Future<void> initFunc() async {
    await privacySettingsController.getPrivacySettings();
    selectedLanguages=privacySettingsController.getSelectedLanguageAndRegionSettingsValueFromTitle(privacySettingsController.selectedLanguageAndRegionSettings)??[];
  }

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
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kAppBarSizeSetting),
                  child: CustomAppBar(
                    onBack: () {
                      Get.back();
                    },
                    title: privacySettingsController
                        .selectedLanguageAndRegionSettings.value?.tr,
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomModifiedTextField(
                        borderRadius: h8,
                        controller: searchQueryCon,
                        prefixIcon: BipHip.search,
                        hint: ksSearch.tr,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: k12Padding),
                        textInputStyle: regular16TextStyle(cBlackColor),
                        onChanged: (value) {
                          setState(() {
                            searchQueryCon.text = value.toLowerCase();
                          });
                        },
                      ),
                      SizedBox(height: 22.h),
                      Text(
                        ksAllLanguages.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      SizedBox(height: 6.h),
                      Obx(
                        () => kidsController.isStoreLanguageLoading.value
                            ? const GenderListShimmer()
                            : Expanded(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children: kidsController.allLanguageList
                                      .where((language) => language
                                          .toLowerCase()
                                          .contains(searchQueryCon.text))
                                      .map(
                                        (language) => CheckboxListTile(
                                          title: Text(
                                            language,
                                            style: medium18TextStyle(
                                                cBlackGradientColor),
                                          ),
                                          subtitle: Text(
                                            language,
                                            style: regular14TextStyle(
                                                csmallBodyTextColor2),
                                          ),
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          value: selectedLanguages
                                              .contains(language),
                                          onChanged: (isChecked) {
                                            setState(() {
                                              if (isChecked == true) {
                                                if (!selectedLanguages
                                                    .contains(language)) {
                                                  selectedLanguages
                                                      .add(language);
                                                }
                                              } else {
                                                selectedLanguages
                                                    .remove(language);
                                              }
                                              print(selectedLanguages);
                                              // Update the settings in the controller
                                              privacySettingsController
                                                  .updateLanguageAndRegionSetting(
                                                      privacySettingsController
                                                          .selectedLanguageAndRegionSettings,
                                                      selectedLanguages);
                                            });
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (privacySettingsController.isPrivacySettingsLoading.value ==
                true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (privacySettingsController
                        .isPrivacySettingsLoading.value) {
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
