import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/awards/awards_details_page.dart';
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
            child: Obx(
              () => Column(
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
                              return Obx(() => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                                    child: CustomChoiceChips(
                                      label: interestProfile[i],
                                      isSelected: (awardController.selectedCatagoriesIndex.value == i && awardController.isCategoriesSelected.value),
                                      onSelected: (value) {
                                        awardController.selectedCatagoriesIndex.value = i;
                                        awardController.isCategoriesSelected.value = value;
                                      },
                                    ),
                                  ));
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
                  kH16sizedBox,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: awardController.youWonAwardList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                              crossAxisCount: 3,
                              crossAxisSpacing: k16Padding,
                              mainAxisSpacing: k16Padding,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  awardController.isOthersWinner.value = false;
                                  Get.to(() => AwardDetailsPage(
                                        userImage: awardController.youWonAwardList[index]['image'],
                                        ranking: awardController.youWonAwardList[index]['ranking'],
                                        certificateImage: awardController.youWonAwardList[index]['certificate'],
                                        winningDate: awardController.youWonAwardList[index]['WinningDate'],
                                      ));
                                },
                                child: AwardView(
                                  image: awardController.youWonAwardList[index]['image'],
                                  ranking: awardController.youWonAwardList[index]['ranking'],
                                  titleText: awardController.youWonAwardList[index]['WinningDate'],
                                ),
                              );
                            },
                          ),
                          kH16sizedBox,
                          Text(
                            ksOthersWinner.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          kH16sizedBox,
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: awardController.othersWinnerAwardList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                              crossAxisCount: 3,
                              crossAxisSpacing: k16Padding,
                              mainAxisSpacing: k16Padding,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  awardController.isOthersWinner.value = true;
                                  Get.to(() => AwardDetailsPage(
                                        userImage: awardController.othersWinnerAwardList[index]['image'],
                                        ranking: awardController.othersWinnerAwardList[index]['ranking'],
                                        certificateImage: awardController.othersWinnerAwardList[index]['certificate'],
                                        winningDate: awardController.othersWinnerAwardList[index]['WinningDate'],
                                      ));
                                },
                                child: AwardView(
                                  image: awardController.othersWinnerAwardList[index]['image'],
                                  ranking: awardController.othersWinnerAwardList[index]['ranking'],
                                  titleText: awardController.othersWinnerAwardList[index]['WinningDate'],
                                ),
                              );
                            },
                          ),
                          kH20sizedBox,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AwardView extends StatelessWidget {
  const AwardView({super.key, this.image, this.ranking, this.titleText, this.awardContainerHeight});
  final String? image;
  final String? ranking;
  final String? titleText;
  final double? awardContainerHeight;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width - 40) / 3,
      height: awardContainerHeight ?? 120,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(k8BorderRadius),
            child: Image.network(
              image!,
              width: (width - 40) / 3,
              height: awardContainerHeight ?? 120,
              fit: BoxFit.cover,
              loadingBuilder: imageLoadingBuilder,
              errorBuilder: (context, error, stackTrace) => const Icon(
                BipHip.imageFile,
                size: kIconSize120,
                color: cIconColor,
              ),
            ),
          ),
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
                      ranking ?? "",
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
            child: SizedBox(
              width: ((width - 40) / 3) / 1.5,
              child: Text(
                titleText ?? "",
                style: semiBold12TextStyle(cWhiteColor),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: SvgPicture.asset(kiAward),
          ),
        ],
      ),
    );
  }
}
