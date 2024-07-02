import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/awards/awards_details_page.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

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
                  awardController.isawardListLoading.value
                      ? const AwardViewShimmer()
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (awardController.myAwardList.isEmpty)
                                  Container(
                                      width: width - 40,
                                      height: height * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(k8BorderRadius),
                                        border: Border.all(width: 1, color: cLineColor),
                                      ),
                                      child: EmptyView(title: ksYouHaveNotWonAnyAwards.tr)),
                                if (awardController.myAwardList.isNotEmpty)
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: awardController.myAwardList.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.75,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: k16Padding,
                                      mainAxisSpacing: k16Padding,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          awardController.isOthersWinner.value = false;
                                          Get.to(() => AwardDetailsPage(
                                                userImage: awardController.myAwardList[index].user!.profilePicture,
                                                userName: awardController.myAwardList[index].user!.fullName,
                                                ranking: awardController.myAwardList[index].rank.toString(),
                                                certificateImage: "",
                                                winningDate: DateFormat('d MMM, yyyy').format(awardController.myAwardList[index].winDate!),
                                              ));
                                        },
                                        child: AwardView(
                                          image: awardController.myAwardList[index].user?.profilePicture,
                                          ranking: awardController.myAwardList[index].rank.toString(),
                                          titleText: DateFormat('d MMM, yyyy').format(awardController.myAwardList[index].winDate!),
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
                                  itemCount: awardController.friendAwardList.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: k16Padding,
                                    mainAxisSpacing: k16Padding,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        awardController.isOthersWinner.value = true;
                                        Get.to(() => AwardDetailsPage(
                                              userImage: awardController.friendAwardList[index].user?.profilePicture,
                                              userName: awardController.friendAwardList[index].user!.fullName,
                                              ranking: awardController.friendAwardList[index].rank.toString(),
                                              certificateImage: "",
                                              winningDate: DateFormat('d MMM, yyyy').format(awardController.friendAwardList[index].winDate!),
                                            ));
                                      },
                                      child: AwardView(
                                        image: awardController.friendAwardList[index].user?.profilePicture,
                                        ranking: awardController.friendAwardList[index].rank.toString(),
                                        titleText: DateFormat('d MMM, yyyy').format(awardController.friendAwardList[index].winDate!),
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
      height: awardContainerHeight ?? 137,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(k8BorderRadius),
            child: Image.network(
              image ?? "",
              width: (width - 40) / 3,
              height: awardContainerHeight ?? 137,
              fit: BoxFit.cover,
              loadingBuilder: imageLoadingBuilder,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                kiProfileDefaultImageUrl,
                width: (width - 40) / 3,
                height: awardContainerHeight ?? 137,
                fit: BoxFit.cover,
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
                "$ksWinningDate: $titleText",
                style: semiBold12TextStyle(cWhiteColor),
              ),
            ),
          ),
          Positioned(
            right: 6,
            bottom: 10,
            child: SvgPicture.asset(kiAward),
          ),
        ],
      ),
    );
  }
}

class AwardViewShimmer extends StatelessWidget {
  const AwardViewShimmer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.75,
        crossAxisCount: 3,
        crossAxisSpacing: k16Padding,
        mainAxisSpacing: k16Padding,
      ),
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: (width - 40) / 3,
          height: 137,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: ShimmerCommon(
                    widget: Container(
                        height: 145,
                        width: 120,
                        decoration: BoxDecoration(
                          color: cWhiteColor,
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ))),
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
                      color: cWhiteColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: SvgPicture.asset(
                  kiWinner,
                  color: cWhiteColor,
                ),
              ),
              Positioned(
                left: 6,
                bottom: 6,
                child: SizedBox(
                  width: ((width - 40) / 3) / 1.5,
                  child: ShimmerCommon(
                      widget: Container(
                          height: h8,
                          width: 30,
                          decoration: BoxDecoration(
                            color: cWhiteColor,
                            borderRadius: BorderRadius.circular(k8BorderRadius),
                          ))),
                ),
              ),
              Positioned(
                right: 6,
                bottom: 10,
                child: SvgPicture.asset(
                  kiAward,
                  color: cWhiteColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
