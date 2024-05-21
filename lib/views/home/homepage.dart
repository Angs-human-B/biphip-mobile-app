import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/controllers/menu/quiz_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/quiz/quiz_top_widget.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/menu/awards/widgets/awards_widget.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/post/post_button_widget.dart';
import 'package:bip_hip/widgets/post/stories_widget.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
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
                            Get.find<AllSearchController>().resetSearchData();
                            Get.toNamed(krSearchPage);
                            Get.find<AllSearchController>().getSearchHistory();
                            Get.find<AllSearchController>().getSearchFilterData();
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
                          onPressed: () async {
                            await Get.find<FriendController>().getFriendList();
                            Get.toNamed(krInbox);
                          },
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
                  () => homeController.isHomePageLoading.value
                      ? const HomePageShimmer()
                      : NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (homeController.postListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                                scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                                !homeController.postListScrolled.value) {
                              homeController.postListScrolled.value = true;
                              if (globalController.commonPostList.isNotEmpty) {
                                homeController.getMorePostList();
                              }
                              return true;
                            }
                            return false;
                          },
                          child: SingleChildScrollView(
                            controller: homeController.postListScrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  width: width,
                                  color: cWhiteColor,
                                  child: CustomPostButton(
                                    name: checkNullOrStringNull(Get.find<GlobalController>().userLastName.value.toString().trim()) != null
                                        ? Get.find<GlobalController>().userLastName.value.toString()
                                        : Get.find<GlobalController>().userName.value.toString(),
                                    profilePic: Get.find<GlobalController>().userImage.value.toString(),
                                    onPressed: () async {
                                      Get.find<CreatePostController>().isPostedFromProfile.value = false;
                                      CreatePostHelper().resetCreatePostData();
                                      Get.find<KidsController>().isRouteFromKid.value = false;
                                      Get.toNamed(krCreatePost);
                                      await Get.find<CreatePostController>().getCreatePost();
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
                                          onTap: (value) async {
                                            homeController.homeTabIndex.value = value;
                                            if (homeController.homeTabIndex.value == 1) {
                                              await Get.find<QuizController>().getQuestionList();
                                            }
                                          },
                                          unselectedLabelColor: cSmallBodyTextColor,
                                          unselectedLabelStyle: medium14TextStyle(cSmallBodyTextColor),
                                          labelStyle: medium14TextStyle(cPrimaryColor),
                                          labelColor: cPrimaryColor,
                                          tabs: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    ksSelfie.tr,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                              child: Text(
                                                ksDailyQuiz.tr,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                              child: Text(
                                                ksAwardWinner.tr,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (homeController.homeTabIndex.value == 0)
                                  Container(
                                    color: cWhiteColor,
                                    width: width,
                                    child: StoriesWidget(),
                                  ),
                                if (homeController.homeTabIndex.value == 1)
                                  Container(
                                    color: cWhiteColor,
                                    width: width,
                                    child: Get.find<QuizController>().isQuestionLoading.value ? const HomePageTopTapableQuizShimmer() : QuizTopWidget(),
                                  ),
                                if (homeController.homeTabIndex.value == 2)
                                  Container(
                                    color: cWhiteColor,
                                    width: width,
                                    child: AwardsWidget(),
                                  ),
                                kH8sizedBox,
                                //!This part must be changed, it for just birthday test post
                                // Container(
                                //   color: cWhiteColor,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(left: kHorizontalPadding, top: k16Padding, right: kHorizontalPadding),
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Row(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             ClipOval(
                                //               child: Container(
                                //                 height: h44,
                                //                 width: h44,
                                //                 decoration: const BoxDecoration(
                                //                   color: cBlackColor,
                                //                   shape: BoxShape.circle,
                                //                 ),
                                //                 child: Image.network(
                                //                   "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
                                //                   fit: BoxFit.cover,
                                //                   errorBuilder: (context, error, stackTrace) => const Icon(
                                //                     BipHip.user,
                                //                     size: kIconSize24,
                                //                     color: cIconColor,
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             kW12sizedBox,
                                //             Padding(
                                //               padding: const EdgeInsets.only(top: k4Padding),
                                //               child: Column(
                                //                 crossAxisAlignment: CrossAxisAlignment.start,
                                //                 children: [
                                //                   Row(
                                //                     children: [
                                //                       Text(
                                //                         "Wahid Murad",
                                //                         style: semiBold16TextStyle(cBlackColor),
                                //                       ),
                                //                       kW4sizedBox,
                                //                       const Icon(
                                //                         BipHip.rightArrowOutline,
                                //                         size: kIconSize12,
                                //                         color: cIconColor,
                                //                       ),
                                //                       kW4sizedBox,
                                //                       Text(
                                //                         "Wahid Murad",
                                //                         style: semiBold16TextStyle(cBlackColor),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                   kH4sizedBox,
                                //                   Row(
                                //                     children: [
                                //                       const Icon(
                                //                         BipHip.world,
                                //                         size: kIconSize14,
                                //                         color: cIconColor,
                                //                       ),
                                //                       kW4sizedBox,
                                //                       Text(
                                //                         '1 hour ago',
                                //                         style: regular12TextStyle(cSmallBodyTextColor),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),

                                //             const Spacer(),
                                //             // CustomIconButton(
                                //             //   icon: BipHip.system,
                                //             //   size: kIconSize14,
                                //             //   iconColor: cIconColor,
                                //             //   onPress: () {},
                                //             // ),
                                //             Padding(
                                //               padding: const EdgeInsets.only(top: k4Padding),
                                //               child: InkWell(
                                //                 onTap: () {
                                //                   homeController.birthdaySelectedAction.value = "";
                                //                   Get.find<GlobalController>().commonBottomSheet(
                                //                     context: context,
                                //                     isScrollControlled: true,
                                //                     content: BirthdayActionContent(),
                                //                     onPressCloseButton: () {
                                //                       Get.back();
                                //                     },
                                //                     onPressRightButton: null,
                                //                     rightText: "",
                                //                     rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                //                     title: ksAction.tr,
                                //                     isRightButtonShow: false,
                                //                     bottomSheetHeight: 200,
                                //                   );
                                //                 },
                                //                 child: const Icon(
                                //                   BipHip.system,
                                //                   size: kIconSize14,
                                //                   color: cIconColor,
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //         kH8sizedBox,
                                //         Text(
                                //           "Happy Birthday",
                                //           style: regular14TextStyle(cBlackColor),
                                //         ),
                                //         kH8sizedBox,
                                //         LikeSectionWidget(
                                //           isGiftShown: true,
                                //           giftOnPressed: () {},
                                //           commentOnPressed: () {},
                                //         ),
                                //         const CustomDivider(),
                                //         kH8sizedBox,
                                //       ],
                                //     ),
                                //   ),
                                // ),

                                kH8sizedBox,
                                if (globalController.commonPostList.isEmpty)
                                  SizedBox(
                                    height: height - (2 + 64 + 8 + 158 + 41 + kAppBarSize + MediaQuery.of(context).padding.top + kBottomNavHeight),
                                    child: EmptyView(
                                      title: ksNoDataAvailable.tr,
                                    ),
                                  ),
                                // ),
                                if (globalController.commonPostList.isNotEmpty)
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) => kH8sizedBox,
                                      itemCount: globalController.commonPostList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: cWhiteColor,
                                          width: width,
                                          child: CommonPostWidget(
                                            postIndex: index,
                                          ),
                                        );
                                      }),

                                if (globalController.commonPostList.isNotEmpty &&
                                    homeController.postListScrolled.value &&
                                    homeController.postListSubLink.value != null)
                                  const HomePagePaginationShimmer(),
                                kH8sizedBox,
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          // homeController.congratulationsAlertDialog(
          //     context: context,
          //     content: Column(
          //       children: [
          //         Image.asset(kiProfileDefaultImageUrl),
          //       ],
          //     )),
          if (Get.find<PostReactionController>().isGiftStarLoading.value || Get.find<PendentBadgesController>().isBuyBadgeLoading.value)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (Get.find<PostReactionController>().isGiftStarLoading.value || Get.find<PendentBadgesController>().isBuyBadgeLoading.value) {
                    return false;
                  }
                  return true;
                },
              ),
            ),
        ],
      ),
    );
  }
}

class BirthdayActionContent extends StatelessWidget {
  BirthdayActionContent({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: homeController.birthdayActionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: k8Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      homeController.birthdayActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: homeController.birthdayActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  itemColor:
                      homeController.birthdaySelectedAction.value == homeController.birthdayActionList[index]['action'] ? cPrimaryTint2Color : cWhiteColor,
                  onPressed: () {
                    homeController.birthdaySelectedAction.value = homeController.birthdayActionList[index]['action'];
                    Get.back();
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
