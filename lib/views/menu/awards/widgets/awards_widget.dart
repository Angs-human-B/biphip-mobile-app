import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/awards/awards_page.dart';

class AwardsWidget extends StatelessWidget {
  AwardsWidget({super.key});
  final AwardController awardController = Get.find<AwardController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: k10Padding),
        child: ListView.separated(
            padding: const EdgeInsets.only(
              left: k10Padding,
            ),
            itemCount: 7,
            shrinkWrap: true,
            separatorBuilder: (context, index) => kW12sizedBox,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index < 6 && index < awardController.friendAwardList.length) {
                return AwardView(
                  image: awardController.friendAwardList[index].user?.profilePicture,
                  ranking: awardController.friendAwardList[index].rank.toString(),
                  titleText: 'Wahid Murad',
                  awardContainerHeight: 137,
                );
              } else if (index >= 6) {
                return Padding(
                  padding: const EdgeInsets.only(right: k12Padding),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(krAwardsPage);
                    },
                    child: Container(
                      width: (width - 40) / 3,
                      height: 136,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        color: cPrimaryTint2Color,
                        border: Border.all(width: 1, color: cPrimaryColor),
                      ),
                      child: Center(
                        child: Text(
                          ksSeeAll.tr,
                          style: semiBold12TextStyle(cPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return null;
            }),
      ),
    );
  }
}
