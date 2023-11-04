import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/common_post_widget.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/widgets/post_widgets/post_button_widget.dart';
import 'package:bip_hip/widgets/post_widgets/stories_widget.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: cBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksBipHip.tr,
              titleColor: cPrimaryColor,
              hasBackButton: false,
              isCenterTitle: false,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () async {
                      final spController = SpController();
                      Get.find<GlobalController>().recentSearch.value = await spController.getRecentSearchList();
                      // FirebaseCrashlytics.instance.crash();
                      Get.find<GlobalController>().searchController.clear();
                      Get.to(
                        () => Search(
                          searchController: Get.find<GlobalController>().searchController,
                          recentSearchList: Get.find<GlobalController>().recentSearch,
                          onSubmit: () {},
                        ),
                        transition: Transition.noTransition,
                      );
                    },
                    child: Icon(
                      BipHip.search,
                      color: cIconColor,
                      size: isDeviceScreenLarge() ? 24 : 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {},
                    child: Icon(
                      BipHip.chatOutline,
                      color: cIconColor,
                      size: isDeviceScreenLarge() ? 24 : 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            width: width,
            isFirstButtonClicked: true,
            isSecondButtonClicked: false,
            isThirdButtonClicked: false,
            isFourthButtonClicked: false,
            isFifthButtonClicked: false,
          ),
          body: Obx(
            () => _homeController.isHomePageLoading.value
                ? const HomePageShimmer()
                : SizedBox(
                    height: height,
                    width: width,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: width,
                            color: cWhiteColor,
                            child: CustomPostButton(
                              name: 'Monjurul',
                              profilePic: '',
                              onPressed: () {
                                ll('post');
                                Get.find<CreatePostController>().resetData();
                                Get.toNamed(krCreatePost);
                              },
                              prefixWidget: const Icon(
                                BipHip.imageFile,
                                color: cIconColor,
                              ),
                            ),
                          ),
                          kH8sizedBox,
                          Container(
                            color: cWhiteColor,
                            width: width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kHorizontalPadding,
                              ),
                              child: DefaultTabController(
                                length: 3,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: cLineColor, width: 1),
                                    ),
                                  ),
                                  child: TabBar(
                                    indicatorColor: cPrimaryColor,
                                    indicatorWeight: 1,
                                    unselectedLabelColor: cSmallBodyTextColor,
                                    unselectedLabelStyle: medium14TextStyle(cSmallBodyTextColor),
                                    labelStyle: medium14TextStyle(cPrimaryColor),
                                    labelColor: cPrimaryColor,
                                    tabs: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                        child: Text(
                                          ksSelfie.tr,
                                          // style: semiBold12TextStyle(cPrimaryColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                        child: Text(
                                          ksDailyQuiz.tr,
                                          // style: semiBold12TextStyle(cPrimaryColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                        child: Text(
                                          ksWeeklyWinner.tr,
                                          // style: semiBold12TextStyle(cPrimaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: cWhiteColor,
                            width: width,
                            child: const StoriesWidget(),
                          ),
                          kH8sizedBox,
                          if (_homeController.allPostList.isEmpty) const SizedBox(height: 300, child: const EmptyView(title: ksNoDataAvailable)),
                          if (_homeController.allPostList.isNotEmpty)
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => kH8sizedBox,
                                itemCount: _homeController.allPostList.length,
                                itemBuilder: (context, index) {
                                  var item = _homeController.allPostList[index];
                                  return Container(
                                    color: cWhiteColor,
                                    width: width,
                                    child: CommonPostWidget(
                                      isCommented: false,
                                      isLiked: false,
                                      isSharedPost: false,
                                      showBottomSection: true,
                                      userName: 'Rick Sanchez',
                                      postTime: '3 hrs ago',
                                      isCategorized: true,
                                      isTextualPost: item.content == null ? false : true, //API
                                      category: item.postCategory!.name, //API
                                      categoryIcon: _homeController.getCategoryIcon(item.postCategory!.id), // need change API
                                      categoryIconColor: _homeController.getCategoryColor(item.postCategory!.id), // Based on API
                                      privacy: BipHip.world,
                                      brandName: item.brand == null ? null : item.brand!.name, //API
                                      kidName: item.kid == null ? null : item.kid!.name, //API
                                      kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                                      title: null, //API
                                      price: null, //API
                                      postText: item.content, //API
                                      mediaList: item.imageUrls, //API
                                      isSelfPost: true,
                                      isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
                                    ),
                                  );
                                }),
                          kH8sizedBox,
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Container(
              width: width,
              color: cWhiteColor,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: k12Padding),
                  child: Row(
                    children: [
                      kW20sizedBox,
                      ShimmerCommon(
                        widget: Container(
                          height: h40,
                          width: h40,
                          decoration: const BoxDecoration(
                            color: cWhiteColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      kW12sizedBox,
                      Expanded(
                        child: ShimmerCommon(
                          widget: Container(
                            height: h16,
                            decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                          ),
                        ),
                      ),
                      kW12sizedBox,
                      ShimmerCommon(
                        widget: Container(
                            height: h26,
                            width: h26,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            )),
                      ),
                      kW20sizedBox
                    ],
                  ),
                ),
              ),
            ),
            kH8sizedBox,
            Container(
              color: cWhiteColor,
              height: 40,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ShimmerCommon(
                            widget: Container(
                              height: h12,
                              width: (width - 200) / 3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                          ShimmerCommon(
                            widget: Container(
                              height: 2,
                              width: (width - 40) / 3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ShimmerCommon(
                            widget: Container(
                              height: h12,
                              width: (width - 200) / 3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                            width: (width - 40) / 3,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ShimmerCommon(
                            widget: Container(
                              height: h12,
                              width: (width - 200) / 3,
                              decoration: BoxDecoration(
                                borderRadius: k8CircularBorderRadius,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                            width: (width - 40) / 3,
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              color: cWhiteColor,
              width: width,
              child: SizedBox(
                height: 150,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: k10Padding),
                  child: ListView.builder(
                      padding: const EdgeInsets.only(left: k10Padding),
                      itemCount: 8,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: k8Padding),
                          child: ShimmerCommon(
                              widget: Container(
                            height: 137,
                            width: 90,
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius, border: Border.all(color: cLineColor)),
                          )),
                        );
                      }),
                ),
              ),
            ),
            kH8sizedBox,
            Container(
              color: cWhiteColor,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      ShimmerCommon(
                        widget: Container(
                            height: h40,
                            width: h40,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            )),
                      ),
                      kW8sizedBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                        ],
                      )
                    ],
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width * 0.4, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  Row(
                    children: [
                      ShimmerCommon(
                        widget: Container(
                          height: 160,
                          width: (width - 42) / 2,
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        ),
                      ),
                      const SizedBox(width: 2),
                      ShimmerCommon(
                        widget: Container(
                          height: 160,
                          width: (width - 42) / 2,
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        ),
                      ),
                    ],
                  ),
                  kH12sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      )
                    ],
                  )
                ]),
              ),
            ),
            kH8sizedBox,
            Container(
              color: cWhiteColor,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      ShimmerCommon(
                        widget: Container(
                            height: h40,
                            width: h40,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            )),
                      ),
                      kW8sizedBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                        ],
                      )
                    ],
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width - 40, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(height: h10, width: width * 0.4, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                  ),
                  kH16sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      )
                    ],
                  )
                ]),
              ),
            ),
            kH8sizedBox,
            Container(
              color: cWhiteColor,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      ShimmerCommon(
                        widget: Container(
                            height: h40,
                            width: h40,
                            decoration: const BoxDecoration(
                              color: cWhiteColor,
                              shape: BoxShape.circle,
                            )),
                      ),
                      kW8sizedBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.6, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget:
                                Container(height: h12, width: width * 0.3, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                          ),
                        ],
                      )
                    ],
                  ),
                  kH8sizedBox,
                  ShimmerCommon(
                    widget: Container(
                      height: 300,
                      width: width - 40,
                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                    ),
                  ),
                  kH8sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                      ShimmerCommon(
                        widget: Container(height: h10, width: width * 0.2, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      )
                    ],
                  )
                ]),
              ),
            ),
            kH8sizedBox
          ],
        ),
      ),
    );
  }
}
