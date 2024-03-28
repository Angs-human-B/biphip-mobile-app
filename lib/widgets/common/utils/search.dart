import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/search_bottom_sheets/search_kids_news_bottom_sheet_content.dart';
import 'package:bip_hip/widgets/common/utils/search_bottom_sheets/search_photos_videos_bottom_sheet_content.dart';
import 'package:bip_hip/widgets/common/utils/search_bottom_sheets/search_posts_bottom_sheet_content.dart';
import 'package:bip_hip/widgets/common/utils/search_bottom_sheets/search_sell_posts_bottom_sheet_content.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/search_posted_by_content.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/search_video_content.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  final FriendController friendController = Get.find<FriendController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Obx(
                () => Scaffold(
                  backgroundColor: cWhiteColor,
                  //* info:: body
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top + 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: CustomIconButton(
                              onPress: () {
                                Get.back();
                              },
                              icon: BipHip.leftArrow,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CustomModifiedTextField(
                                borderRadius: h8,
                                controller: allSearchController.searchTextEditingController,
                                focusNode: searchFocusNode,
                                prefixIcon: BipHip.search,
                                suffixIcon: allSearchController.isSearchSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                hint: ksSearch.tr,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: k12Padding,
                                ),
                                textInputStyle: regular16TextStyle(cBlackColor),
                                onSuffixPress: () {
                                  allSearchController.searchTextEditingController.clear();
                                  allSearchController.isSearchSuffixIconVisible.value = false;
                                  allSearchController.isSearched.value = false;
                                  allSearchController.selectedFilterIndex.value = -1;
                                  allSearchController.selectedFilterValue.value = "";
                                },
                                onSubmit: (value) async {
                                  unFocus(context);
                                  if (allSearchController.searchTextEditingController.text.toString().trim() == "") {
                                    allSearchController.isSearchSuffixIconVisible.value = false;
                                  } else {
                                    allSearchController.isSearchSuffixIconVisible.value = true;
                                    allSearchController.selectedFilterIndex.value = 0;
                                    allSearchController.selectedFilterValue.value = allSearchController.filterTypeList[0];
                                    await allSearchController.getSearch();
                                    allSearchController.isSearched.value = true;
                                  }
                                },
                                onChanged: (value) {
                                  if (allSearchController.searchTextEditingController.text.toString().trim() == "") {
                                    allSearchController.isSearchSuffixIconVisible.value = false;
                                  } else {
                                    allSearchController.isSearchSuffixIconVisible.value = true;
                                  }
                                },
                              ),
                            ),
                          ),
                          if (allSearchController.selectedFilterIndex.value != 0 && allSearchController.isSearched.value)
                            CustomIconButton(
                              onPress: () {
                                if (allSearchController.selectedFilterIndex.value == 1) {
                                  globalController.commonBottomSheet(
                                      context: context,
                                      isBottomSheetRightButtonActive: allSearchController.isPostsBottomSheetResetOrShowResult,
                                      content: SearchPostsBottomSheetContent(),
                                      bottomSheetHeight: height * 0.4,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {
                                        allSearchController.resetPostsBottomSheetData();
                                        // allSearchController.resetBottomSheetData();
                                      },
                                      rightText: ksReset.tr,
                                      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                      title: ksPosts.tr,
                                      isRightButtonShow: true);
                                }
                                if (allSearchController.selectedFilterIndex.value == 2) {
                                  Get.find<GlobalController>().commonBottomSheet(
                                      context: context,
                                      bottomSheetHeight: height * 0.4,
                                      content: SearchPostedByContent(),
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {
                                        allSearchController.selectedPostedBy.value = allSearchController.temporarySelectedPostedBy.value;
                                        Get.back();
                                      },
                                      rightText: ksDone.tr,
                                      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                      title: ksPostedBy.tr,
                                      isRightButtonShow: true,
                                      isBottomSheetRightButtonActive: allSearchController.isPostedByBottomSheetState);
                                }
                                if (allSearchController.selectedFilterIndex.value == 3 || allSearchController.selectedFilterIndex.value == 4) {
                                  globalController.commonBottomSheet(
                                      context: context,
                                      isBottomSheetRightButtonActive: allSearchController.isPhotosVideosBottomSheetResetOrShowResult,
                                      content: SearchPhotosVideosBottomSheetContent(),
                                      bottomSheetHeight: height * 0.3,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {
                                        allSearchController.resetPhotosVideosBottomSheetData();
                                      },
                                      rightText: ksReset.tr,
                                      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                      title: ksPosts.tr,
                                      isRightButtonShow: true);
                                }
                                if (allSearchController.selectedFilterIndex.value == 5) {
                                  globalController.commonBottomSheet(
                                      context: context,
                                      isBottomSheetRightButtonActive: allSearchController.isSellPostBottomSheetResetOrShowResult,
                                      content: SearchSellPostsBottomSheetContent(),
                                      bottomSheetHeight: height * 0.4,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {
                                        allSearchController.resetSellPostBottomSheetData();
                                        // allSearchController.resetBottomSheetData();
                                      },
                                      rightText: ksReset.tr,
                                      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                      title: ksSellPost.tr,
                                      isRightButtonShow: true);
                                }
                                if (allSearchController.selectedFilterIndex.value == 6 || allSearchController.selectedFilterIndex.value == 7) {
                                  globalController.commonBottomSheet(
                                      context: context,
                                      isBottomSheetRightButtonActive: allSearchController.isKidsNewsBottomSheetResetOrShowResult,
                                      content: SearchKidsNewsBottomSheetContent(),
                                      bottomSheetHeight: height * 0.35,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {
                                        allSearchController.resetKidsNewsBottomSheetData();
                                      },
                                      rightText: ksReset.tr,
                                      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                      title: ksSellPost.tr,
                                      isRightButtonShow: true);
                                }
                              },
                              icon: BipHip.filter,
                              size: kIconSize16,
                              iconColor: cBlackColor,
                            ),
                        ],
                      ),
                      if (allSearchController.isSearched.value == false && allSearchController.searchHistoryList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k16Padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ksRecent.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              InkWell(
                                onTap: () {
                                  allSearchController.deleteAllSearchHistory();
                                },
                                child: Text(
                                  ksClearAll.tr,
                                  style: semiBold16TextStyle(cRedColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (allSearchController.isSearched.value == false)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: k12Padding, top: k16Padding),
                              child: Column(
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(k0Padding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: allSearchController.searchHistoryList.length,
                                      separatorBuilder: (context, index) => kH4sizedBox,
                                      itemBuilder: (context, index) {
                                        return CustomListTile(
                                          leading: ClipOval(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                // allSearchController.searchHistoryList[index]??"",//!No image parameter from api
                                                "",
                                                width: h40,
                                                height: h40,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => const Icon(
                                                  BipHip.user,
                                                  size: kIconSize28,
                                                  color: cIconColor,
                                                ),
                                                loadingBuilder: imageLoadingBuilder,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            allSearchController.searchHistoryList[index].keywords ?? "",
                                            style: medium16TextStyle(cBlackColor),
                                          ),
                                          trailing: CustomIconButton(
                                            onPress: () {
                                              // allSearchController.userList.removeAt(index);//!Api call here(history delete api)
                                              allSearchController.deleteSearchHistory(id: allSearchController.searchHistoryList[index].id!);
                                            },
                                            icon: BipHip.circleCrossNew,
                                            size: kIconSize16,
                                          ),
                                          onPressed: () {
                                            // onSelected(option);
                                            unfocus(context);
                                            // allSearchController.searchTextEditingController.text = allSearchController.userList[index]["name"];
                                            allSearchController.isSearchSuffixIconVisible.value = true;
                                            // familyController.userId.value = option.id!;
                                          },
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (allSearchController.isSearched.value)
                        Padding(
                          padding: const EdgeInsets.only(left: k16Padding),
                          child: Container(
                            color: cWhiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width,
                                  height: 50,
                                  child: ListView.builder(
                                    itemCount: allSearchController.filterTypeList.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(0),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, i) {
                                      return Obx(() => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                                            child: CustomChoiceChips(
                                              label: allSearchController.filterTypeList[i],
                                              isSelected: (allSearchController.selectedFilterIndex.value == i),
                                              onSelected: (value) {
                                                allSearchController.resetBottomSheetData();
                                                allSearchController.selectedFilterIndex.value = i;
                                                allSearchController.selectedFilterValue.value = allSearchController.filterTypeList[i];
                                              },
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (allSearchController.selectedFilterIndex.value == 0 && allSearchController.isSearched.value)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kH12sizedBox,
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                  child: Text(
                                    ksPeople.tr,
                                    style: semiBold18TextStyle(cBlackColor),
                                  ),
                                ),
                                if (allSearchController.userList.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(k0Padding),
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: allSearchController.userList.length,
                                        separatorBuilder: (context, index) => kH8sizedBox,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  width: h40,
                                                  height: h40,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: cWhiteColor,
                                                  ),
                                                  child: Image.network(
                                                    allSearchController.userList[index].profilePicture ?? "",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                                      BipHip.user,
                                                      size: kIconSize20,
                                                      color: cIconColor,
                                                    ),
                                                    loadingBuilder: imageLoadingBuilder,
                                                  ),
                                                ),
                                              ),
                                              kW12sizedBox,
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    allSearchController.userList[index].fullName ?? "",
                                                    style: semiBold16TextStyle(cBlackColor),
                                                  ),
                                                  kH4sizedBox,
                                                  Text(
                                                    "${allSearchController.userList[index].mutualFriend.toString()} mutual friends",
                                                    style: regular10TextStyle(cSmallBodyTextColor),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                allSearchController.userList[index].friendStatus == 1 ? ksMessage.tr : ksAddFriend.tr,
                                                style: regular12TextStyle(cPrimaryColor),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                kH16sizedBox,
                                if (allSearchController.postsList.isNotEmpty)
                                  ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(k0Padding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) => kH8sizedBox,
                                      itemCount: Get.find<HomeController>().allPostList.length,
                                      itemBuilder: (context, index) {
                                        var item = allSearchController.postsList[index];
                                        return Container(
                                          color: cWhiteColor,
                                          width: width - 40,
                                          child: CommonPostWidget(
                                            postIndex: index,
                                            isCommented: index % 2 == 0,
                                            isLiked: index % 2 != 0,
                                            isSharedPost: false,
                                            showBottomSection: true,
                                            userName: item.user?.fullName ?? "",
                                            postTime: Get.find<HomeController>().postTimeDifference(item.createdAt ?? DateTime.now()),
                                            isCategorized: true,
                                            mediaList: const [],
                                            // category: item.postCategoryId == null ? null : item.postCategory!.name, //API
                                            // categoryIcon: item.postCategory == null
                                            //     ? null
                                            //     : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                                            // categoryIconColor: item.postCategory == null
                                            //     ? null
                                            //     : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
                                            privacy: BipHip.world,
                                            // brandName: item.store == null ? null : item.store!.name, //API
                                            // kidName: item.kid == null ? null : item.kid!.name, //API
                                            // kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                                            // postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
                                            // mediaList: item.images, //API
                                            isSelfPost: index % 2 != 0,
                                            isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
                                            // reactCount: item.countReaction,
                                            postID: item.id!,
                                            // secondaryImage: item.kid?.profilePicture ?? item.store?.profilePicture,
                                            subCategory: null,
                                            // category: item.postCategoryId==null ? null : item.postCategory.name,
                                            platformName: item.platform,
                                            platformLink: 'www.facebook.com/Clothing/lorem',
                                            actionName: null,
                                            title: item.title ?? "", //API
                                            postText: item.content ?? "",
                                            price: item.price.toString(), //API
                                            mainPrice: '400',
                                            discount: item.discount.toString(),
                                            isInStock: false,
                                            productCondition: 'New',
                                            productCategory: 'Phone', userImage: item.user?.profilePicture ?? '',
                                            taggedFriends: const [],
                                          ),
                                        );
                                      }),
                              ],
                            ),
                          ),
                        ),
                      if (allSearchController.selectedFilterIndex.value == 1)
                        if (allSearchController.postsList.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(k0Padding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) => kH8sizedBox,
                                      itemCount: Get.find<HomeController>().allPostList.length,
                                      itemBuilder: (context, index) {
                                        var item = allSearchController.postsList[index];
                                        return Container(
                                          color: cWhiteColor,
                                          width: width - 40,
                                          child: CommonPostWidget(
                                            postIndex: index,
                                            isCommented: index % 2 == 0,
                                            isLiked: index % 2 != 0,
                                            isSharedPost: false,
                                            showBottomSection: true,
                                            userName: item.user?.fullName ?? "",
                                            postTime: Get.find<HomeController>().postTimeDifference(item.createdAt ?? DateTime.now()),
                                            isCategorized: true,
                                            mediaList: const [],
                                            // category: item.postCategoryId == null ? null : item.postCategory!.name, //API
                                            // categoryIcon: item.postCategory == null
                                            //     ? null
                                            //     : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                                            // categoryIconColor: item.postCategory == null
                                            //     ? null
                                            //     : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
                                            privacy: BipHip.world,
                                            // brandName: item.store == null ? null : item.store!.name, //API
                                            // kidName: item.kid == null ? null : item.kid!.name, //API
                                            // kidAge: item.kid == null ? null : item.kid!.age.toString(), //API
                                            // postText: item.postCategory?.name == 'News' ? item.description ?? '' : item.content ?? '', //API
                                            // mediaList: item.images, //API
                                            isSelfPost: index % 2 != 0,
                                            isCommentShown: true, commentCount: item.countComment!, shareCount: item.countShare!, giftCount: item.countStar!,
                                            // reactCount: item.countReaction,
                                            postID: item.id!,
                                            // secondaryImage: item.kid?.profilePicture ?? item.store?.profilePicture,
                                            subCategory: null,
                                            // category: item.postCategoryId==null ? null : item.postCategory.name,
                                            platformName: item.platform,
                                            platformLink: 'www.facebook.com/Clothing/lorem',
                                            actionName: null,
                                            title: item.title ?? "", //API
                                            postText: item.content ?? "",
                                            price: item.price.toString(), //API
                                            mainPrice: '400',
                                            discount: item.discount.toString(),
                                            isInStock: false,
                                            productCondition: 'New',
                                            productCategory: 'Phone', userImage: item.user?.profilePicture ?? '',
                                            taggedFriends: const [],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                      if (allSearchController.selectedFilterIndex.value == 2)
                        if (allSearchController.userList.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(k0Padding),
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: allSearchController.userList.length,
                                        separatorBuilder: (context, index) => kH8sizedBox,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  width: h40,
                                                  height: h40,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: cWhiteColor,
                                                  ),
                                                  child: Image.network(
                                                    allSearchController.userList[index].profilePicture ?? "",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                                      BipHip.user,
                                                      size: kIconSize20,
                                                      color: cIconColor,
                                                    ),
                                                    loadingBuilder: imageLoadingBuilder,
                                                  ),
                                                ),
                                              ),
                                              kW12sizedBox,
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    allSearchController.userList[index].fullName ?? ksNA.tr,
                                                    style: semiBold16TextStyle(cBlackColor),
                                                  ),
                                                  kH4sizedBox,
                                                  Text(
                                                    "${allSearchController.userList[index].mutualFriend.toString()} mutual friends",
                                                    style: regular10TextStyle(cSmallBodyTextColor),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                allSearchController.userList[index].friendStatus == 1 ? ksMessage.tr : ksAddFriend.tr,
                                                style: regular12TextStyle(cPrimaryColor),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      if (allSearchController.selectedFilterIndex.value == 3)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
                                  child: GridView.custom(
                                    padding: const EdgeInsets.all(k0Padding),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverQuiltedGridDelegate(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                                      pattern: const [
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(2, 3),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(2, 2),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                        QuiltedGridTile(1, 1),
                                      ],
                                    ),
                                    childrenDelegate: SliverChildBuilderDelegate(
                                      childCount: allSearchController.photosList.length,
                                      (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: cLineColor),
                                            borderRadius: k8CircularBorderRadius,
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: k8CircularBorderRadius,
                                                child: Image.network(
                                                  allSearchController.photosList[index].fullPath ?? "",
                                                  fit: BoxFit.cover,
                                                  width: width,
                                                  height: 600,
                                                  errorBuilder: (context, error, stackTrace) => SizedBox(
                                                    width: width,
                                                    child: Image.asset(
                                                      kiDummyImage3ImageUrl, //!Change this dummy image
                                                      width: width,
                                                      height: 600,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  loadingBuilder: imageLoadingBuilder,
                                                ),
                                              ),
                                              Positioned(
                                                left: 4,
                                                bottom: 4,
                                                child: Text(
                                                  "by ${allSearchController.photosList[index].user?.fullName ?? ""}",
                                                  style: regular10TextStyle(cWhiteColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (allSearchController.selectedFilterIndex.value == 4)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: k16Padding),
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(k0Padding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) => kH8sizedBox,
                                      itemCount: allSearchController.videosList.length,
                                      itemBuilder: (context, index) {
                                        final item = allSearchController.videosList[index];
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(krVideoDetails);
                                          },
                                          child: SearchVideosContent(
                                            image: item.fullPath.toString(),
                                            title: item.title ?? ksNA.tr,
                                            name: item.user?.fullName ?? ksNA.tr,
                                            date: item.imageTakenTime.toString(),
                                            totalView: item.totalViewCount.toString(),
                                            time: item.imageTakenTime.toString(),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (allSearchController.selectedFilterIndex.value == 5)
                        if (Get.find<HomeController>().allPostList.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(k0Padding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) => kH8sizedBox,
                                      itemCount: Get.find<HomeController>().allPostList.length,
                                      itemBuilder: (context, index) {
                                        var item = Get.find<HomeController>().allPostList[index];
                                        return Container(
                                          color: cWhiteColor,
                                          width: width - 40,
                                          child: CommonPostWidget(
                                            postIndex: index,
                                            isCommented: index % 2 == 0,
                                            isLiked: index % 2 != 0,
                                            isSharedPost: false,
                                            showBottomSection: true,
                                            userName: item.user!.fullName!,
                                            postTime: Get.find<HomeController>().postTimeDifference(item.createdAt),
                                            isCategorized: true,
                                            category: item.postCategory == null ? null : item.postCategory!.name, //API
                                            categoryIcon: item.postCategory == null
                                                ? null
                                                : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                                            categoryIconColor: item.postCategory == null
                                                ? null
                                                : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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
                                ],
                              ),
                            ),
                          ),
                      if (allSearchController.selectedFilterIndex.value == 6)
                        if (Get.find<HomeController>().allPostList.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(k0Padding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) => kH8sizedBox,
                                      itemCount: Get.find<HomeController>().allPostList.length,
                                      itemBuilder: (context, index) {
                                        var item = Get.find<HomeController>().allPostList[index];
                                        return Container(
                                          color: cWhiteColor,
                                          width: width - 40,
                                          child: CommonPostWidget(
                                            postIndex: index,
                                            isCommented: index % 2 == 0,
                                            isLiked: index % 2 != 0,
                                            isSharedPost: false,
                                            showBottomSection: true,
                                            userName: item.user!.fullName!,
                                            postTime: Get.find<HomeController>().postTimeDifference(item.createdAt),
                                            isCategorized: true,
                                            category: item.postCategory == null ? null : item.postCategory!.name, //API
                                            categoryIcon: item.postCategory == null
                                                ? null
                                                : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                                            categoryIconColor: item.postCategory == null
                                                ? null
                                                : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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
                                ],
                              ),
                            ),
                          ),
                      if (allSearchController.selectedFilterIndex.value == 7)
                        if (Get.find<HomeController>().allPostList.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(k0Padding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) => kH8sizedBox,
                                      itemCount: Get.find<HomeController>().allPostList.length,
                                      itemBuilder: (context, index) {
                                        var item = Get.find<HomeController>().allPostList[index];
                                        return Container(
                                          color: cWhiteColor,
                                          width: width - 40,
                                          child: CommonPostWidget(
                                            postIndex: index,
                                            isCommented: index % 2 == 0,
                                            isLiked: index % 2 != 0,
                                            isSharedPost: false,
                                            showBottomSection: true,
                                            userName: item.user!.fullName!,
                                            postTime: Get.find<HomeController>().postTimeDifference(item.createdAt),
                                            isCategorized: true,
                                            category: item.postCategory == null ? null : item.postCategory!.name, //API
                                            categoryIcon: item.postCategory == null
                                                ? null
                                                : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
                                            categoryIconColor: item.postCategory == null
                                                ? null
                                                : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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
                                ],
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
