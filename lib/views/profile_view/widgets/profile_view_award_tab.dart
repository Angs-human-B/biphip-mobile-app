import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/awards/awards_details_page.dart';
import 'package:bip_hip/views/menu/awards/awards_page.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ProfileViewAwardTab extends StatelessWidget {
  ProfileViewAwardTab({super.key});
  final AwardController awardController = Get.find<AwardController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: (height * 0.42) - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ksAllAwards.tr,
                style: semiBold18TextStyle(cBlackColor),
              ),
              kH16sizedBox,
              awardController.isawardListLoading.value
                  ? const AwardShimmer()
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (awardController.friendAwardList.isEmpty)
                              Container(
                                  width: width - 40,
                                  height: height * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    border: Border.all(width: 1, color: cLineColor),
                                  ),
                                  child: EmptyView(title: ksYouHaveNotWonAnyAwards.tr)),
                            if (awardController.friendAwardList.isNotEmpty)
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: awardController.friendAwardList.length,
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
                                            userImage: awardController.friendAwardList[index].user!.profilePicture,
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
                          ],
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

class AwardShimmer extends StatelessWidget {
  const AwardShimmer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
