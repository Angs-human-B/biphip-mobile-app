import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmers/search/search_post_shimmer.dart';
import 'package:bip_hip/shimmers/search/search_user_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/search/search_widgets/search_app_bar.dart';
import 'package:bip_hip/views/search/search_widgets/search_filter_chips.dart';
import 'package:bip_hip/views/search/search_widgets/search_history.dart';
import 'package:bip_hip/views/search/search_widgets/search_result_all_posts.dart';
import 'package:bip_hip/views/search/search_widgets/search_result_photos.dart';
import 'package:bip_hip/views/search/search_widgets/search_result_users.dart';
import 'package:bip_hip/views/search/search_widgets/search_result_videos.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  final FriendController friendController = Get.find<FriendController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        await Get.find<HomeController>().getPostList();
      },
      child: Container(
        color: cWhiteColor,
        child: Obx(
          () => Stack(
            children: [
              Container(
                color: cWhiteColor,
                child: SafeArea(
                  top: false,
                  child: Scaffold(
                    backgroundColor: cWhiteColor,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 10,
                        ),
                        SearchAppBar(),
                        SearchHistory(),
                        if (allSearchController.isSearched.value) SearchFilterChips(),
                        Obx(
                          () => Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  if ((allSearchController.selectedFilterIndex.value == 0 || allSearchController.selectedFilterIndex.value == 2) &&
                                      allSearchController.isSearched.value)
                                    allSearchController.isSearchLoading.value
                                        ? const UserSearchShimmer()
                                        : allSearchController.userList.isNotEmpty
                                            ? SearchResultUsers()
                                            : const SizedBox(),
                                  if (allSearchController.selectedFilterIndex.value == 0)
                                    Container(
                                      height: h10,
                                      width: width,
                                      color: cBackgroundColor,
                                    ),
                                  if (allSearchController.selectedFilterIndex.value == 0 ||
                                      allSearchController.selectedFilterIndex.value == 1 ||
                                      allSearchController.selectedFilterIndex.value == 5 ||
                                      allSearchController.selectedFilterIndex.value == 6 ||
                                      allSearchController.selectedFilterIndex.value == 7)
                                    allSearchController.isSearchLoading.value ? const SearchPostShimmer() : SearchResultAllPost(),
                                  if (allSearchController.selectedFilterIndex.value == 3)
                                    if (allSearchController.photosList.isNotEmpty) SearchResultPhotos(),
                                  if (allSearchController.selectedFilterIndex.value == 4)
                                    if (allSearchController.videosList.isNotEmpty) SearchResultVideos(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (allSearchController.isDeleteSearchHistory.value || allSearchController.isDeleteAllSearchHistory.value)
                Positioned(
                  child: CommonLoadingAnimation(
                    onWillPop: () async {
                      if (allSearchController.isDeleteSearchHistory.value || allSearchController.isDeleteAllSearchHistory.value) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChipsWrapContainer extends StatelessWidget {
  const ChipsWrapContainer({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          border: kLineBorder,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding),
          child: Text(
            text,
            style: regular14TextStyle(cPlaceHolderColor),
          ),
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: h24,
      height: h24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: cNeutralColor,
      ),
      child: Icon(
        icon,
        size: kIconSize12,
        color: cIconColor,
      ),
    );
  }
}
