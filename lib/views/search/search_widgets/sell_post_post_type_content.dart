import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:flutter_svg/svg.dart';

class SellPostPostTypeContent extends StatelessWidget {
  SellPostPostTypeContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => OutLinedButton(
            onPress: () {
              allSearchController.temporarySelectedSellPostType.value = ksRegularPost.tr;
              allSearchController.temporarySelectedSellPostTypeIndex.value = 0;
              allSearchController.isSellPostTypeBottomSheetState.value = true;
            },
            suffixWidget: Padding(
              padding: const EdgeInsets.only(right: k8Padding),
              child: Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: k100CircularBorderRadius,
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          cBlueLinearColor1,
                          cBlueLinearColor2,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 7,
                    bottom: 7,
                    child: SvgPicture.asset(
                      kiRegularPostSvgUrl,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
            buttonText: ksRegularPost.tr,
            buttonTextStyle: medium16TextStyle(cBlackColor),
            borderColor: allSearchController.temporarySelectedSellPostType.value == ksRegularPost.tr ? cPrimaryColor : cLineColor,
            buttonColor: allSearchController.temporarySelectedSellPostType.value == ksRegularPost.tr ? cPrimaryTint2Color : cWhiteColor,
          ),
        ),
        kH16sizedBox,
        Obx(
          () => OutLinedButton(
            onPress: () {
              allSearchController.temporarySelectedSellPostType.value = ksBiddingPost.tr;
              allSearchController.temporarySelectedSellPostTypeIndex.value = 1;
              allSearchController.isSellPostTypeBottomSheetState.value = true;
            },
            suffixWidget: Padding(
              padding: const EdgeInsets.only(right: k8Padding),
              child: Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: k100CircularBorderRadius,
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          cYellowLinearColor1,
                          cYellowLinearColor2,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 7,
                    bottom: 7,
                    child: SvgPicture.asset(
                      kiBiddingPostSvgUrl,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
            buttonText: ksBiddingPost.tr,
            buttonTextStyle: medium16TextStyle(cBlackColor),
            borderColor: allSearchController.temporarySelectedSellPostType.value == ksBiddingPost.tr ? cPrimaryColor : cLineColor,
            buttonColor: allSearchController.temporarySelectedSellPostType.value == ksBiddingPost ? cPrimaryTint2Color : cWhiteColor,
          ),
        ),
      ],
    );
  }
}
