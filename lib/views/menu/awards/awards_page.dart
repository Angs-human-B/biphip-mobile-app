import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:flutter_svg/svg.dart';

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
                AwardView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AwardView extends StatelessWidget {
  const AwardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width - 40) / 3,
      height: 120,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(k8BorderRadius),
            child: Image.network(
              'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
              width: (width - 40) / 3,
              height: 120,
              fit: BoxFit.contain,
              loadingBuilder: imageLoadingBuilder,
              errorBuilder: (context, error, stackTrace) => const Icon(
                BipHip.imageFile,
                size: kIconSize120,
                color: cIconColor,
              ),
            ),
          ),
          // Positioned(
          //   top: 6,
          //   left: 6,
          //   child: SvgPicture.asset(kiPositionBadge),
          // ),
          Positioned(
            top: 6,
            left: 6,
            child: Stack(
              children: [
                Container(),
                SvgPicture.asset(
                  kiPositionBadge,
                  width: h24,
                  height: h24,
                ),
                Positioned(
                    top: 6,
                    left: 6,
                    child: Text(
                      '10',
                      style: regular12TextStyle(cWhiteColor),
                    )),
              ],
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: SvgPicture.asset(kiWinner),
          ),
          Positioned(
            left: 6,
            bottom: 6,
            child: Text(
              'Wining Date: 14 Sep, 2023',
              style: semiBold12TextStyle(cWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
