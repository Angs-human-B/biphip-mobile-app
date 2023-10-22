import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/post_widgets/post_button_widget.dart';
import 'package:bip_hip/widgets/post_widgets/stories_widget.dart';
import 'package:bip_hip/widgets/common/utils/custom_bottom_nav.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: cGreyBoxColor,
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
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  kH16sizedBox,
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
                  kH16sizedBox,
                  Container(
                    color: cWhiteColor,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                      ),
                      child: DefaultTabController(
                        length: 3,
                        child: TabBar(
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                              child: Text(
                                ksSelfie.tr,
                                style: semiBold12TextStyle(cPrimaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                              child: Text(
                                ksDailyQuiz.tr,
                                style: semiBold12TextStyle(cPrimaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                              child: Text(
                                ksWeeklyWinner.tr,
                                style: semiBold12TextStyle(cPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: cWhiteColor,
                    width: width,
                    child: const StoriesWidget(),
                  ),
                  kH16sizedBox,
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => kH20sizedBox,
                      itemCount: homePagePost.length,
                      itemBuilder: (context, index) {
                        var item = homePagePost[index];
                        return Container(
                          color: cWhiteColor,
                          width: width,
                          child: CommonPostWidget(
                            isCommented: item['isCommented'],
                            isLiked: item['isLiked'],
                            isSharedPost: item['isSharedPost'],
                            showBottomSection: item['showBottomSection'],
                            userName: item['userName'],
                            postTime: item['postTime'],
                            isCategorized: item['isCategorized'],
                            isTextualPost: item['isTextualPost'],
                            category: item['category'],
                            categoryIcon: item['categoryIcon'],
                            categoryIconColor: item['categoryIconColor'],
                            privacy: item['privacy'],
                            brandName: item['brandName'],
                            kidName: item['kidName'],
                            kidAge: item['kidAge'],
                            title: item['item'],
                            price: item['price'],
                            postText: item['postText'],
                            mediaList: item['mediaList'],
                            isSelfPost: item['isSelfPost'],
                            isCommentShown: item['isCommentShown'],
                          ),
                        );
                      }),
                  kH20sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
