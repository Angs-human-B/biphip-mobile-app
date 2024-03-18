import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class StoreReview extends StatelessWidget {
  const StoreReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Stack(
        children: [
          SafeArea(
            top: false,
            child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: ksReview.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ),
                body: Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH16sizedBox,
                            Text(
                              "Do you recommend Genie InfoTech?",
                              style: regular20TextStyle(cBlackColor),
                            ),
                            kH24sizedBox,
                            Row(
                              children: [
                                CustomElevatedButton(
                                  label: ksYes.tr,
                                  buttonWidth: (width - 56) / 2,
                                  onPressed: () {},
                                  buttonColor: cPrimaryColor,
                                  textStyle: semiBold14TextStyle(cWhiteColor),
                                ),
                                kW16sizedBox,
                                CustomElevatedButton(
                                  label: ksNo.tr,
                                  buttonWidth: (width - 56) / 2,
                                  onPressed: () {},
                                  buttonColor: cWhiteColor,
                                  borderColor: cPrimaryColor,
                                  textStyle: semiBold14TextStyle(cPrimaryColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.725,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      kiReviewSvgImage,
                                      width: h60,
                                      height: h60,
                                      color: cIconColor,
                                    ),
                                  ),
                                  kH16sizedBox,
                                  Text(
                                    ksNoReviews.tr,
                                    textAlign: TextAlign.center,
                                    style: semiBold16TextStyle(cBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      // ),
    );
  }
}
