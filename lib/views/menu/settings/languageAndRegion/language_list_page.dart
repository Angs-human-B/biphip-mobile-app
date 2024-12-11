import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/menu/kids_controller.dart';
import '../../../../shimmers/profile/gender_shimmer.dart';
import '../../../../utils/constants/imports.dart';

class LanguageListPage extends StatefulWidget {

  const LanguageListPage({super.key});

  @override
  LanguageListPageState createState() => LanguageListPageState();
}

class LanguageListPageState extends State<LanguageListPage> {
  final KidsController kidsController = Get.find<KidsController>();
  String selectedLanguage = "";
  final TextEditingController searchQueryCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            title: ksLanguages.tr,
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
                  }),
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
                              .map((language) => RadioListTile(
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
                                    value: language,
                                    groupValue: selectedLanguage,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        selectedLanguage = value!;
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
