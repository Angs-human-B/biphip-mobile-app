import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/widgets/post/post_button_widget.dart';
import 'package:bip_hip/widgets/post/stories_widget.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';

import '../../widgets/common/utils/common_divider.dart';

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
                    : SizedBox(
                        height: height,
                        width: width,
                        child: SingleChildScrollView(
                          child: Column(
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
                                  onPressed: () {
                                    CreatePostHelper().resetData();
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
                              if (homeController.allPostList.isEmpty) const SizedBox(height: 300, child: EmptyView(title: ksNoDataAvailable)),
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
                                          isCommented: false,
                                          isLiked: false,
                                          isSharedPost: false,
                                          showBottomSection: true,
                                          userName: 'Rick Sanchez',
                                          postTime: '3 hrs ago',
                                          isCategorized: true,
                                          isTextualPost: item.content == null ? false : true, //API
                                          category: item.postCategory!.name, //API
                                          categoryIcon: homeController.getCategoryIcon(item.postCategory!.id), // need change API
                                          categoryIconColor: homeController.getCategoryColor(item.postCategory!.id), // Based on API
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
                                          postID: item.id!,
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

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    this.title,
    required this.addContent,
    this.hasCloseBtn = false,
    this.hasDivider = true,
    this.actions,
    this.onClose,
    this.horizontalContentPadding,
    this.verticalContentPadding,
    Key? key,
  }) : super(key: key);

  final String? title;
  final Widget? addContent;
  final bool hasCloseBtn, hasDivider;
  final List<Widget>? actions;
  final Function()? onClose;
  final double? horizontalContentPadding;
  final double? verticalContentPadding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(k4BorderRadius),
      ),
      elevation: 0,
      titlePadding: EdgeInsets.zero,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(k4BorderRadius),
        child: Column(
          children: [
            Container(
              color: cWhiteColor,
              height: 100,
              width: width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (title != null)
                    Center(
                      child: Text(
                        title.toString(),
                        textAlign: TextAlign.center,
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                    ),
                ],
              ),
            ),
            const CustomDivider(
              thickness: 0.3,
            )
          ],
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalContentPadding ?? k16Padding,
        vertical: verticalContentPadding ?? k10Padding,
      ),
      insetPadding: const EdgeInsets.all(k20Padding),
      content: addContent,
      actions: actions,
    );
  }
}
