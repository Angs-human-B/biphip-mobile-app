import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/menu/kids_controller.dart';
import '../../../../shimmers/profile/gender_shimmer.dart';
import '../../../../utils/constants/imports.dart';
import '../../../../widgets/common/utils/common_headertext.dart';

class RegionFormatListPage extends StatefulWidget {

  const RegionFormatListPage({super.key});

  @override
  RegionFormatListPageState createState() => RegionFormatListPageState();
}

class RegionFormatListPageState extends State<RegionFormatListPage> {
  final KidsController kidsController = Get.find<KidsController>();
  String selectedLanguage = "";
  String userSelectedLanguage = "";
  final TextEditingController searchQueryCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: cWhiteColor,
      child: Obx(
              () =>Stack(
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
                    // if(kidsController.userRegion.region.isNotEmpty)
                      Obx(
                              () => kidsController.isStoreRegionLoading.value
                              ? const GenderListShimmer(): kidsController.userRegion.region.isNotEmpty? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ksLanguagesYouMayKnow.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          SizedBox(height: 22.h),
                          RadioListTile(
                            title: Text(
                              kidsController.userRegion.region,
                              style: medium18TextStyle(
                                  cBlackGradientColor),
                            ),
                            subtitle: Text(
                              kidsController.userRegion.number_format,
                              style: regular14TextStyle(
                                  csmallBodyTextColor2),
                            ),
                            controlAffinity:
                            ListTileControlAffinity.trailing,
                            value: kidsController.userRegion.region,
                            groupValue: kidsController.selectedRegion,
                            onChanged: (value) {
                              setState(() {
                                // print(value!.region!);
                                kidsController.selectedRegion = value!;
                              });
                            },
                          )
                        ],
                      ): Container()),
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
                            groupValue: kidsController.selectedRegion,
                            onChanged: (value) {
                              setState(() {
                                print(value!);
                                kidsController.selectedRegion = value!;
                                kidsController.storeUserRegion(kidsController.selectedRegion);

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
          ),
          if (kidsController.isStoreUserRegionLoading.value ==
              true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (kidsController
                      .isStoreUserRegionLoading.value) {
                    return false;
                  }
                  return true;
                },
              ),
            ),
        ],
      )),
    );
  }
}
