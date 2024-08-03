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
      
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
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
