import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/menu/kids_controller.dart';
import '../../../../shimmers/profile/gender_shimmer.dart';
import '../../../../utils/constants/imports.dart';

class RegionFormatListPage extends StatefulWidget {

  const RegionFormatListPage({super.key});

  @override
  RegionFormatListPageState createState() => RegionFormatListPageState();
}

class RegionFormatListPageState extends State<RegionFormatListPage> {
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
            title: ksRegionFormat.tr,
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
                ksLanguageAndRegion.tr,
                style: semiBold18TextStyle(cBlackColor),
              ),
              SizedBox(height: 6.h),
              Obx(
                    () => kidsController.isStoreLanguageLoading.value
                    ? const GenderListShimmer()
                    : Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: kidsController.regionList
                        .where((language) => language.region
                        .toLowerCase()
                        .contains(searchQueryCon.text))
                        .map((language) => RadioListTile(
                      title: Text(
                        language.region,
                        style: medium18TextStyle(
                            cBlackGradientColor),
                      ),
                      subtitle: Text(
                        language.number_format,
                        style: regular14TextStyle(
                            csmallBodyTextColor2),
                      ),
                      controlAffinity:
                      ListTileControlAffinity.trailing,
                      value: language.region,
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          // print(value!.region!);
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
