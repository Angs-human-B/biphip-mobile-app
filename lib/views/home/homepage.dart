import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/common_post_widget.dart';
import 'package:bip_hip/views/profile/profile_widgets/post_button_widget.dart';
import 'package:bip_hip/views/profile/profile_widgets/stories_widget.dart';
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
          backgroundColor: cGreyBoxColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: 'BipHip'.tr,
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
              child: Column(
                children: [
                  kH16sizedBox,
                  Container(
                    width: width,
                    color: cWhiteColor,
                    child: CustomPostButton(
                      name: 'Monjurul',
                      profilePic: 'assets/images/profilePic.png',
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
                                'Selfie',
                                style: semiBold12TextStyle(cPrimaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                              child: Text(
                                'Daily Quiz',
                                style: semiBold12TextStyle(cPrimaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k8Padding),
                              child: Text(
                                'Weekly Winner',
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
                  Container(
                    color: cWhiteColor,
                    width: width,
                    child: CommonPostWidget(
                      isCommented: false,
                      isLiked: true,
                      isSharedPost: true,
                      userName: 'Monjurul Sharker',
                      postTime: '3 hrs ago',
                      isCategorized: true,
                      isTextualPost: true,
                      category: 'Selling',
                      categoryIcon: _homeController.getCategoryIcon('Selling'),
                      categoryIconColor: _homeController.getCategoryIconColor('Selling'),
                      privacy: BipHip.world,
                      brandName: 'Black Market',
                      kidName: 'Babu',
                      kidAge: '5 years',
                      title: '5 Year old Kid for selling, with functioning organs (Except left kidney)',
                      price: '1000',
                      postText:
                          'Good news for child traffickers and black market organ sellers. A 5 years old kid from Ohio is up for sell. The product has fully functional organs. Unfortunately, his left kidney got malfunctioned few months ago. Hospital documents will also be provided. Otherwise all organs are completely functional and product is refundable',
                      mediaList: [],
                      isSelfPost: true,
                      isCommentShown: false,
                    ),
                  ),
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
