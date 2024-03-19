import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class StoreReview extends StatelessWidget {
  StoreReview({super.key});
  final StoreController storeController = Get.find<StoreController>();
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
                            // Text(
                            //   "Do you recommend Genie InfoTech?",
                            //   style: regular20TextStyle(cBlackColor),
                            // ),
                            // kH24sizedBox,
                            // Row(
                            //   children: [
                            //     CustomElevatedButton(
                            //       label: ksYes.tr,
                            //       buttonWidth: (width - 56) / 2,
                            //       onPressed: () {},
                            //       buttonColor: cPrimaryColor,
                            //       textStyle: semiBold14TextStyle(cWhiteColor),
                            //     ),
                            //     kW16sizedBox,
                            //     CustomElevatedButton(
                            //       label: ksNo.tr,
                            //       buttonWidth: (width - 56) / 2,
                            //       onPressed: () {},
                            //       buttonColor: cWhiteColor,
                            //       borderColor: cPrimaryColor,
                            //       textStyle: semiBold14TextStyle(cPrimaryColor),
                            //     ),
                            //   ],
                            // ),
                            if (storeController.storeReviewList.isEmpty)
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
                            if (storeController.storeReviewList.isNotEmpty)
                              Row(
                                children: [
                                  Text(
                                    ksRating.tr,
                                    style: regular20TextStyle(cBlackColor),
                                  ),
                                  kW4sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.only(top: k4Padding),
                                    child: Container(
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        color: cBlackColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  kW4sizedBox,
                                  Text(
                                    "4.8 (36 Reviews)",
                                    style: regular20TextStyle(cBlackColor),
                                  ),
                                ],
                              ),
                            kH16sizedBox,
                            // if (storeController.storeReviewList.isNotEmpty)
                            //   Expanded(
                            //     child: SingleChildScrollView(
                            //       child: Column(
                            //         children: [
                            //           ListView.separated(
                            //               shrinkWrap: true,
                            //               physics: const NeverScrollableScrollPhysics(),
                            //               itemBuilder: (context, index) {
                            //                 return StoreReviewPostView(
                            //                   userImage: storeController.storeReviewList[index]["userImage"],
                            //                   userName: storeController.storeReviewList[index]["userName"],
                            //                 );
                            //               },
                            //               separatorBuilder: (context, index) => kH8sizedBox,
                            //               itemCount: storeController.storeReviewList.length),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
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

class StoreReviewPostView extends StatelessWidget {
  const StoreReviewPostView({super.key, this.userImage, this.userName, this.storeName, this.rating, this.content});
  final String? userImage;
  final String? userName;
  final String? storeName;
  final String? rating;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.network(
                userImage ?? '',
                fit: BoxFit.cover,
                width: h40,
                height: h40,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  BipHip.imageFile,
                  size: kIconSize40,
                  color: cIconColor,
                ),
                loadingBuilder: imageLoadingBuilder,
              ),
            ),
            kW12sizedBox,
            // Padding(
            //   padding: const EdgeInsets.only(top: k4Padding),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           Text(
            //             "Wahid Murad",
            //             style: semiBold16TextStyle(cBlackColor),
            //           ),
            //           kW4sizedBox,
            //           const Icon(
            //             BipHip.rightArrowOutline,
            //             size: kIconSize12,
            //             color: cIconColor,
            //           ),
            //           kW4sizedBox,
            //           Text(
            //             "Wahid Murad",
            //             style: semiBold16TextStyle(cBlackColor),
            //           ),
            //         ],
            //       ),
            //       kH4sizedBox,
            //       Row(
            //         children: [
            //           const Icon(
            //             BipHip.world,
            //             size: kIconSize14,
            //             color: cIconColor,
            //           ),
            //           kW4sizedBox,
            //           Text(
            //             '1 hour ago',
            //             style: regular12TextStyle(cSmallBodyTextColor),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding),
                  child: Text(
                    userName ?? "",
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                ),
                kW4sizedBox,
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding),
                  child: SvgPicture.asset(
                    kiReviewSvgImage,
                    width: h16,
                    height: h16,
                    color: cRedColor,
                  ),
                ),
                kW4sizedBox,
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding),
                  child: Text(
                    ksRecommends.tr,
                    style: regular16TextStyle(cSmallBodyTextColor),
                  ),
                ),
                kW4sizedBox,
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding),
                  child: Text(
                    storeName ?? ksNA,
                    style: regular14TextStyle(cBlackColor),
                  ),
                ),
                kW4sizedBox,
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding),
                  child: Text(
                    ksWith.tr,
                    style: regular16TextStyle(cSmallBodyTextColor),
                  ),
                ),
                kW4sizedBox,
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding),
                  child: Text(
                    rating ?? ksNA,
                    style: regular14TextStyle(cBlackColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: k20Padding),
          child: Row(
            children: [
              const Icon(
                BipHip.world,
                size: kIconSize12,
                color: cIconColor,
              ),
              kW4sizedBox,
              Text(
                "1 h",
                style: regular12TextStyle(cSmallBodyTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
