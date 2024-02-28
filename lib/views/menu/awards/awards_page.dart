import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class AwardsPage extends StatelessWidget {
  AwardsPage({super.key});
  final AwardController awardController = Get.find<AwardController>();

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
              title: ksAwards.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                CustomModifiedTextField(
                    borderRadius: h8,
                    controller: awardController.awardTextEditingController,
                    prefixIcon: BipHip.search,
                    suffixIcon: awardController.isAwardSuffixVisible.value ? BipHip.circleCrossNew : null,
                    hint: ksSearch.tr,
                    contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                    textInputStyle: regular16TextStyle(cBlackColor),
                    onSuffixPress: () {
                      awardController.isAwardSuffixVisible.value = false;
                      awardController.awardTextEditingController.clear();
                    },
                    onSubmit: (v) {
                      unfocus(context);
                      awardController.isAwardSuffixVisible.value = true;
                    },
                    onChanged: (v) {
                      if (awardController.awardTextEditingController.text.toString().trim() != '') {
                        awardController.isAwardSuffixVisible.value = true;
                      } else {
                        awardController.isAwardSuffixVisible.value = false;
                      }
                    }),
                kH16sizedBox,
                Container(
                  color: cWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width,
                        height: 50,
                        child: ListView.builder(
                          itemCount: interestProfile.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, i) {
                            return Obx(
                              () => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                                child: CustomChoiceChips(
                                  label: interestProfile[i],
                                  isSelected: (awardController.selectedCatagoriesIndex.value == i && awardController.isCategoriesSelected.value),
                                  onSelected: (value) {
                                    awardController.selectedCatagoriesIndex.value = i;
                                    awardController.isCategoriesSelected.value = value;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                kH20sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksYouWon.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    CustomElevatedButton(
                      prefixIcon: BipHip.calendarFill,
                      prefixIconColor: cIconColor,
                      buttonWidth: 100,
                      buttonHeight: h28,
                      label: ksSelectDate.tr,
                      textStyle: regular14TextStyle(cSmallBodyTextColor),
                      onPressed: () {},
                      buttonColor: cWhiteColor,
                      borderColor: cLineColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
