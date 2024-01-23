import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/post/post_button_widget.dart';
import 'package:bip_hip/widgets/post/stories_widget.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                          final spController = SpController();
                          Get.find<GlobalController>().recentSearch.value = await spController.getRecentSearchList();
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
                () => homeController.isHomePageLoading.value
                    ? const HomePageShimmer()
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (homeController.postListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                              scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                              !homeController.postListScrolled.value) {
                            homeController.postListScrolled.value = true;
                            if (homeController.allPostList.isNotEmpty) {
                              homeController.getMorePostList();
                            }
                            return true;
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: homeController.postListScrollController,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: width,
                                color: cWhiteColor,
                                child: CustomPostButton(
                                  name: Get.find<GlobalController>().userLastName.value.toString(),
                                  profilePic: Get.find<GlobalController>().userImage.value.toString(),
                                  onPressed: () async {
                                    Get.find<CreatePostController>().isPostedFromProfile.value = false;
                                    CreatePostHelper().resetCreatePostData();
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
                                        unselectedLabelColor: cSmallBodyTextColor,
                                        unselectedLabelStyle: medium14TextStyle(cSmallBodyTextColor),
                                        labelStyle: medium14TextStyle(cPrimaryColor),
                                        labelColor: cPrimaryColor,
                                        tabs: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: k8Padding),
                                            child: Text(
                                              ksSelfie.tr,
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
                                              ksWeeklyWinner.tr,
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
                              if (homeController.allPostList.isEmpty)
                                SizedBox(
                                  height: height - (2 + 64 + 8 + 158 + 41 + kAppBarSize + MediaQuery.of(context).padding.top + kBottomNavHeight),
                                  child: EmptyView(
                                    title: ksNoDataAvailable.tr,
                                  ),
                                ),
                              if (homeController.allPostList.isNotEmpty)
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => kH8sizedBox,
                                    itemCount: homeController.allPostList.length,
                                    itemBuilder: (context, index) {
                                      var item = homeController.allPostList[index];
                                      return Container(
                                        color: cWhiteColor,
                                        width: width,
                                        child: CommonPostWidget(
                                          postIndex: index,
                                          isCommented: index % 2 == 0,
                                          isLiked: index % 2 != 0,
                                          isSharedPost: false,
                                          showBottomSection: true,
                                          userName: item.user!.fullName!,
                                          postTime: homeController.postTimeDifference(item.createdAt),
                                          isCategorized: true,
                                          category: item.postCategory == null ? null : item.postCategory!.name, //API
                                          categoryIcon:
                                              item.postCategory == null ? null : homeController.getCategoryIcon(item.postCategory!.id), // need change API
                                          categoryIconColor:
                                              item.postCategory == null ? null : homeController.getCategoryColor(item.postCategory!.id), // Based on API
                                          privacy: BipHip.world,
                                          brandName: item.store == null ? null : item.store!.name, //API
                                          kidName: item.kid == null ? null : item.kid!.name, //API
                                          kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                                          postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
                                          mediaList: item.images, //API
                                          isSelfPost: index % 2 != 0,
                                          isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
                                          reactCount: item.countReactions,
                                          postID: item.id!,
                                          secondaryImage: item.kid?.profilePicture ?? item.store?.profilePicture,
                                          subCategory: null,
                                          platformName: 'Jane Clothing',
                                          platformLink: 'www.facebook.com/Clothing/lorem',
                                          actionName: null,
                                          title: item.title, //API
                                          price: item.price.toString(), //API
                                          mainPrice: '400',
                                          discount: item.discount.toString(),
                                          isInStock: false,
                                          productCondition: 'New',
                                          productCategory: 'Phone', userImage: item.user!.profilePicture ?? '', taggedFriends: item.taggedFriends,
                                        ),
                                      );
                                    }),
                              if (homeController.allPostList.isNotEmpty &&
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
      ],
    );
  }
}
