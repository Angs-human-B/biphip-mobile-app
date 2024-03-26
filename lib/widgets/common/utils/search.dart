import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

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
      child: SafeArea(
        top: false,
        child: Obx(
          () => Scaffold(
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
                        child: RawAutocomplete<FriendFamilyUserData>(
                          textEditingController: allSearchController.searchTextEditingController,
                          focusNode: searchFocusNode,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return friendController.temporaryFriendList;
                            }
                            return friendController.temporaryFriendList.where((FriendFamilyUserData option) {
                              return option.fullName!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (option) {
                            unFocus(context);
                            allSearchController.isSearchSuffixIconVisible.value = false;
                            allSearchController.searchTextEditingController.text = option.fullName!;
                            // familyController.userId.value = option.id!;
                            allSearchController.searchedValue.value = option.fullName.toString();
                            allSearchController.searchPeopleProfilePicture.value = option.profilePicture.toString();
                            allSearchController.isSearched.value = true;
                            allSearchController.selectedFilterIndex.value = 0;
                          },
                          optionsViewBuilder: (context, AutocompleteOnSelected<FriendFamilyUserData> onSelected, Iterable<FriendFamilyUserData> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: width - 40,
                                child: Material(
                                  elevation: 4,
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return CustomListTile(
                                        leading: ClipOval(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              option.profilePicture.toString(),
                                              width: 30,
                                              height: 30,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(kiProfileDefaultImageUrl);
                                              },
                                              loadingBuilder: imageLoadingBuilder,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          option.fullName.toString(),
                                          style: medium16TextStyle(cBlackColor),
                                        ),
                                        trailing: CustomIconButton(
                                          onPress: () {
                                            // allSearchController.recentSearchList.removeAt(index); //!Remove from list after api call
                                          },
                                          icon: BipHip.circleCrossNew,
                                          size: kIconSize16,
                                        ),
                                        onPressed: () {
                                          onSelected(option);
                                          unfocus(context);
                                          allSearchController.searchTextEditingController.text = option.fullName.toString();
                                          allSearchController.isSearchSuffixIconVisible.value = true;
                                          // familyController.userId.value = option.id!;
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) => Container(
                                      height: 1,
                                      color: cLineColor,
                                    ),
                                    itemCount: options.length,
                                  ),
                                ),
                              ),
                            );
                          },
                          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                            return Obx(
                              () => CustomModifiedTextField(
                                borderRadius: h8,
                                controller: allSearchController.searchTextEditingController,
                                focusNode: focusNode,
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
                                },
                                onSubmit: (value) {
                                  unFocus(context);
                                  if (allSearchController.searchTextEditingController.text.toString().trim() == "") {
                                    allSearchController.isSearchSuffixIconVisible.value = false;
                                  } else {
                                    allSearchController.isSearchSuffixIconVisible.value = true;
                                    allSearchController.isSearched.value = true;
                                    allSearchController.selectedFilterIndex.value = 0;
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
                            );
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
                                content: PostsFilterContent(),
                                bottomSheetHeight: height * 0.4,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: allSearchController.isPostsBottomSheetResetOrShowResult.value ? () {} : null,
                                rightText: ksReset.tr,
                                rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                title: ksPosts.tr,
                                isRightButtonShow: true);
                          }
                          if (allSearchController.selectedFilterIndex.value == 2) {
                            Get.find<GlobalController>().commonBottomSheet(
                                context: context,
                                bottomSheetHeight: height * 0.4,
                                content: PostedByContent(),
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
                                content: PhotosVideosBottomSheetContent(),
                                bottomSheetHeight: height * 0.3,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: allSearchController.isPhotosVideosBottomSheetResetOrShowResult.value ? () {} : null,
                                rightText: ksReset.tr,
                                rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                title: ksPosts.tr,
                                isRightButtonShow: true);
                          }
                          if (allSearchController.selectedFilterIndex.value == 5) {
                            globalController.commonBottomSheet(
                                context: context,
                                isBottomSheetRightButtonActive: allSearchController.isPostsBottomSheetResetOrShowResult, //!Change it
                                content: PostSellingSection(),
                                bottomSheetHeight: height * 0.4,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {},
                                rightText: ksReset.tr,
                                rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                title: ksSellPost.tr,
                                isRightButtonShow: true);
                          }
                          if (allSearchController.selectedFilterIndex.value == 6 || allSearchController.selectedFilterIndex.value == 7) {
                            globalController.commonBottomSheet(
                                context: context,
                                isBottomSheetRightButtonActive: allSearchController.isKidsNewsBottomSheetResetOrShowResult,
                                content: KidsNewsContent(),
                                bottomSheetHeight: height * 0.35,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {},
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
                // if (recentSearchList.isNotEmpty)
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: h16),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               "Recent Search",
                //               style: semiBold16TextStyle(cBlackColor),
                //             ),
                //             CustomTextButton(
                //               onPressed: () async {
                //                 recentSearchList.value = [];
                //                 final spController = SpController();
                //                 await spController.saveRecentSearchList(recentSearchList);
                //               },
                //               text: "Clear",
                //               textStyle: regular14TextStyle(cRedColor),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 8),
                //         child: Wrap(
                //           children: [
                //             for (int i = recentSearchList.length - 1; i >= 0; i--)
                //               ChipsWrapContainer(
                //                 text: recentSearchList[i],
                //                 onPress: () {
                //                   searchController.text = recentSearchList[i];
                //                   searchController.selection = TextSelection.fromPosition(TextPosition(offset: searchController.text.length));
                //                   isSuffix.value = true;
                //                 },
                //               ),
                //           ],
                //         ),
                //       ),
                //       kH20sizedBox,
                //     ],
                //   ),
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
                                          // allSearchController.isFilterSelected.value = value;
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
                                              allSearchController.userList[index]['image'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        kW12sizedBox,
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              allSearchController.userList[index]['name'],
                                              style: semiBold16TextStyle(cBlackColor),
                                            ),
                                            if (allSearchController.userList[index]['mutualFriend'] != null)
                                              Text(
                                                allSearchController.userList[index]['mutualFriend'],
                                                style: regular10TextStyle(cSmallBodyTextColor),
                                              ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          allSearchController.userList[index]['isFriend'] == "0" ? ksAddFriend.tr : ksMessage.tr,
                                          style: regular12TextStyle(cPrimaryColor),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          kH16sizedBox,
                          if (Get.find<HomeController>().allPostList.isNotEmpty)
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
                                      categoryIconColor:
                                          item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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
                if (allSearchController.selectedFilterIndex.value == 1)
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
                                      categoryIconColor:
                                          item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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
                                              allSearchController.userList[index]['image'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        kW12sizedBox,
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              allSearchController.userList[index]['name'],
                                              style: semiBold16TextStyle(cBlackColor),
                                            ),
                                            if (allSearchController.userList[index]['mutualFriend'] != null)
                                              Text(
                                                allSearchController.userList[index]['mutualFriend'],
                                                style: regular10TextStyle(cSmallBodyTextColor),
                                              ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          allSearchController.userList[index]['isFriend'] == "0" ? ksAddFriend.tr : ksMessage.tr,
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
                                childCount: allSearchController.imageList.length,
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
                                            allSearchController.imageList[index]["image"],
                                            fit: BoxFit.cover,
                                            width: width,
                                            errorBuilder: (context, error, stackTrace) => const Icon(
                                              BipHip.imageFile,
                                              size: kIconSize70,
                                              color: cIconColor,
                                            ),
                                            loadingBuilder: imageLoadingBuilder,
                                          ),
                                        ),
                                        Positioned(
                                          left: 4,
                                          bottom: 4,
                                          child: Text(
                                            "by ${allSearchController.imageList[index]["name"]}",
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
                                  return VideosContent(
                                    image: item["image"],
                                    title: item["title"],
                                    name: item["name"],
                                    date: item["date"],
                                    totalView: item["totalView"],
                                    time: item["time"],
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
                                      categoryIconColor:
                                          item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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
                                      categoryIconColor:
                                          item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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
                                      categoryIconColor:
                                          item.postCategory == null ? null : Get.find<HomeController>().getCategoryColor(item.postCategory!.id), // Based on API
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

class PostsFilterContent extends StatelessWidget {
  PostsFilterContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leading: const IconContainer(icon: Icons.timer), //!Icon must change
              title: ksRecentPost.tr,
              trailing: Obx(() => SizedBox(
                    width: (width - 330) / 2,
                    child: CustomCheckBox(
                        value: allSearchController.isRecentPostCheckBoxSelected.value,
                        label: "",
                        onChanged: (v) {
                          allSearchController.isRecentPostCheckBoxSelected.value = !allSearchController.isRecentPostCheckBoxSelected.value;
                          allSearchController.postsBottomSheetState();
                        },
                        textStyle: regular14TextStyle(cBlackColor)),
                  )),
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostedBy.tr,
              subtitle: allSearchController.selectedPostedBy.value,
              trailing: allSearchController.selectedPostedBy.value != ""
                  ? CustomIconButton(
                      onPress: () {
                        allSearchController.selectedPostedBy.value = "";
                        allSearchController.postsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    )
                  : null,
              onPressed: () {
                allSearchController.temporarySelectedPostedBy.value = allSearchController.selectedPostedBy.value;
                if (allSearchController.temporarySelectedPostedBy.value == '') {
                  allSearchController.isPostedByBottomSheetState.value = false;
                } else {
                  allSearchController.isPostedByBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.4,
                    content: PostedByContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedPostedBy.value = allSearchController.temporarySelectedPostedBy.value;
                      allSearchController.postsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksPostedBy.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isPostedByBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: Icons.date_range), //!Icon must change
              title: ksDatePosted.tr,
              subtitle: allSearchController.selectedDatePosted.value,
              trailing: allSearchController.selectedDatePosted.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedDatePosted.value = "";
                        allSearchController.postsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedDatePosted.value = allSearchController.selectedDatePosted.value;
                // kidsController.temporaryKidRelationId.value = kidsController.kidRelationId.value;
                if (allSearchController.temporarySelectedDatePosted.value == '') {
                  allSearchController.isDatePostedBottomSheetState.value = false;
                } else {
                  allSearchController.isDatePostedBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: DatePostedContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedDatePosted.value = allSearchController.temporarySelectedDatePosted.value;
                      allSearchController.postsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksDatePosted.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isDatePostedBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.menuFill),
              title: ksCategory.tr,
              subtitle: allSearchController.selectedCategory.value,
              trailing: allSearchController.selectedCategory.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedCategory.value = "";
                        allSearchController.postsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedCategory.value = allSearchController.selectedCategory.value;
                if (allSearchController.temporarySelectedCategory.value == '') {
                  allSearchController.isCategoryBottomSheetState.value = false;
                } else {
                  allSearchController.isCategoryBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: CategoryContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedCategory.value = allSearchController.temporarySelectedCategory.value;
                      allSearchController.postsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksCategory.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isCategoryBottomSheetState);
              },
            ),
            kH24sizedBox,
            CustomElevatedButton(
              label: ksShowResult.tr,
              buttonWidth: width - 40,
              buttonHeight: h32,
              onPressed: allSearchController.isPostsBottomSheetResetOrShowResult.value ? () {} : null,
              buttonColor: cPrimaryColor,
              textStyle: semiBold14TextStyle(cWhiteColor),
            ),
          ],
        ));
  }
}

class PostSellingSection extends StatelessWidget {
  PostSellingSection({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostType.tr,
              subtitle: allSearchController.selectedSellPostType.value,
              trailing: allSearchController.selectedSellPostType.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedSellPostType.value = "";
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedSellPostType.value = allSearchController.selectedSellPostType.value;
                if (allSearchController.temporarySelectedSellPostType.value == '') {
                  allSearchController.isSellPostTypeBottomSheetState.value = false;
                } else {
                  allSearchController.isSellPostTypeBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.25,
                    content: SellPostBottomSheetContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedSellPostType.value = allSearchController.temporarySelectedSellPostType.value;
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksPostType.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isSellPostTypeBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.activity), //!Icon must change
              title: ksCondition.tr,
              subtitle: allSearchController.selectedSellPostCondition.value,
              trailing: allSearchController.selectedSellPostCondition.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedSellPostCondition.value = "";
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedSellPostCondition.value = allSearchController.selectedSellPostCondition.value;
                // kidsController.temporaryKidRelationId.value = kidsController.kidRelationId.value;
                if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                  allSearchController.isSellPostConditionBottomSheetState.value = false;
                } else {
                  allSearchController.isSellPostConditionBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: SellPostConditionContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedSellPostCondition.value = allSearchController.temporarySelectedSellPostCondition.value;
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksCondition.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isSellPostConditionBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostedBy.tr,
              subtitle: allSearchController.selectedPostedBy.value,
              trailing: allSearchController.selectedPostedBy.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedPostedBy.value = "";
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedPostedBy.value = allSearchController.selectedPostedBy.value;
                if (allSearchController.temporarySelectedPostedBy.value == "") {
                  allSearchController.isPostedByBottomSheetState.value = false;
                } else {
                  allSearchController.isPostedByBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.4,
                    content: PostedByContent(),
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
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.menuFill),
              title: ksCategory.tr,
              subtitle: allSearchController.selectedSellPostProductCategory.value,
              trailing: allSearchController.selectedSellPostProductCategory.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedSellPostProductCategory.value = "";
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedSellPostProductCategory.value = allSearchController.selectedSellPostProductCategory.value;
                if (allSearchController.temporarySelectedSellPostProductCategory.value == '') {
                  allSearchController.isSellPostProductConditionBottomSheetState.value = false;
                } else {
                  allSearchController.isSellPostProductConditionBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: SellPostProductCategoryContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedSellPostProductCategory.value = allSearchController.temporarySelectedSellPostProductCategory.value;
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksCategory.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isSellPostProductConditionBottomSheetState);
              },
            ),
            kH24sizedBox,
            CustomElevatedButton(
              label: ksShowResult.tr,
              buttonWidth: width - 40,
              buttonHeight: h32,
              onPressed: () {},
              buttonColor: cPrimaryColor,
              textStyle: semiBold14TextStyle(cWhiteColor),
            ),
          ],
        ));
  }
}

class KidsNewsContent extends StatelessWidget {
  KidsNewsContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leading: const IconContainer(icon: BipHip.menuFill),
              title: ksSubCategory.tr,
              subtitle: allSearchController.selectedSubCategory.value,
              trailing: allSearchController.selectedSubCategory.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedSubCategory.value = "";
                        allSearchController.kidsNewsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedSubCategory.value = allSearchController.selectedSubCategory.value;
                if (allSearchController.temporarySelectedSubCategory.value == "") {
                  allSearchController.isSubCategoryBottomSheetState.value = false;
                } else {
                  allSearchController.isSubCategoryBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: SubCategoryBottomSheetContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedSubCategory.value = allSearchController.temporarySelectedSubCategory.value;
                      allSearchController.kidsNewsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksDatePosted.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isSubCategoryBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: Icons.date_range), //!Icon must change
              title: ksDatePosted.tr,
              subtitle: allSearchController.selectedDatePosted.value,
              trailing: allSearchController.selectedDatePosted.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedDatePosted.value = "";
                        allSearchController.kidsNewsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedDatePosted.value = allSearchController.selectedDatePosted.value;
                if (allSearchController.temporarySelectedDatePosted.value == "") {
                  allSearchController.isDatePostedBottomSheetState.value = false;
                } else {
                  allSearchController.isDatePostedBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: DatePostedContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedDatePosted.value = allSearchController.temporarySelectedDatePosted.value;
                      allSearchController.kidsNewsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksDatePosted.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isDatePostedBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostedBy.tr,
              subtitle: allSearchController.selectedPostedBy.value,
              trailing: allSearchController.selectedPostedBy.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedPostedBy.value = "";
                        allSearchController.kidsNewsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedPostedBy.value = allSearchController.selectedPostedBy.value;
                if (allSearchController.temporarySelectedPostedBy.value == "") {
                  allSearchController.isPostedByBottomSheetState.value = false;
                } else {
                  allSearchController.isPostedByBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.4,
                    content: PostedByContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedPostedBy.value = allSearchController.temporarySelectedPostedBy.value;
                      allSearchController.kidsNewsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksPostedBy.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isPostedByBottomSheetState);
              },
            ),
            kH24sizedBox,
            CustomElevatedButton(
              label: ksShowResult.tr,
              buttonWidth: width - 40,
              buttonHeight: h32,
              onPressed: allSearchController.isKidsNewsBottomSheetResetOrShowResult.value ? () {} : null,
              buttonColor: cPrimaryColor,
              textStyle: semiBold14TextStyle(cWhiteColor),
            ),
          ],
        ));
  }
}

class PhotosVideosBottomSheetContent extends StatelessWidget {
  PhotosVideosBottomSheetContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostedBy.tr,
              subtitle: allSearchController.selectedPostedBy.value,
              trailing: allSearchController.selectedPostedBy.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedPostedBy.value = "";
                        allSearchController.photosVideosBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedPostedBy.value = allSearchController.selectedPostedBy.value;
                if (allSearchController.temporarySelectedPostedBy.value == '') {
                  allSearchController.isPostedByBottomSheetState.value = false;
                } else {
                  allSearchController.isPostedByBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.4,
                    content: PostedByContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedPostedBy.value = allSearchController.temporarySelectedPostedBy.value;
                      allSearchController.photosVideosBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksPostedBy.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isPostedByBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: Icons.date_range), //!Icon must change
              title: ksDatePosted.tr,
              subtitle: allSearchController.selectedDatePosted.value,
              trailing: allSearchController.selectedDatePosted.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedDatePosted.value = "";
                        allSearchController.photosVideosBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedDatePosted.value = allSearchController.selectedDatePosted.value;
                // kidsController.temporaryKidRelationId.value = kidsController.kidRelationId.value;
                if (allSearchController.temporarySelectedDatePosted.value == '') {
                  allSearchController.isDatePostedBottomSheetState.value = false;
                } else {
                  allSearchController.isDatePostedBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: DatePostedContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedDatePosted.value = allSearchController.temporarySelectedDatePosted.value;
                      allSearchController.photosVideosBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksDatePosted.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isDatePostedBottomSheetState);
              },
            ),
            kH24sizedBox,
            CustomElevatedButton(
              label: ksShowResult.tr,
              buttonWidth: width - 40,
              buttonHeight: h32,
              onPressed: allSearchController.isPhotosVideosBottomSheetResetOrShowResult.value ? () {} : null,
              buttonColor: cPrimaryColor,
              textStyle: semiBold14TextStyle(cWhiteColor),
            ),
          ],
        ));
  }
}

class PostedByContent extends StatelessWidget {
  PostedByContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.postedByList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  leading: IconContainer(icon: allSearchController.postedByList[index]["icon"]),
                  itemColor:
                      allSearchController.temporarySelectedPostedBy.value == allSearchController.postedByList[index]["type"] ? cPrimaryTint3Color : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedPostedBy.value = allSearchController.postedByList[index]["type"];
                    // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                    if (allSearchController.temporarySelectedPostedBy.value == '') {
                      allSearchController.isPostedByBottomSheetState.value = false;
                    } else {
                      allSearchController.isPostedByBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.postedByList[index]["type"],
                  borderColor:
                      allSearchController.temporarySelectedPostedBy.value == allSearchController.postedByList[index]["type"] ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedPostedBy.value = allSearchController.postedByList[index]["type"];
                      // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                      if (allSearchController.temporarySelectedPostedBy.value == '') {
                        allSearchController.isPostedByBottomSheetState.value = false;
                      } else {
                        allSearchController.isPostedByBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedPostedBy.value == allSearchController.postedByList[index]["type"],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SubCategoryBottomSheetContent extends StatelessWidget {
  SubCategoryBottomSheetContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.subCategoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor:
                      allSearchController.temporarySelectedSubCategory.value == allSearchController.subCategoryList[index] ? cPrimaryTint3Color : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedSubCategory.value = allSearchController.subCategoryList[index];
                    if (allSearchController.temporarySelectedSubCategory.value == '') {
                      allSearchController.isSubCategoryBottomSheetState.value = false;
                    } else {
                      allSearchController.isSubCategoryBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.subCategoryList[index],
                  borderColor:
                      allSearchController.temporarySelectedSubCategory.value == allSearchController.subCategoryList[index] ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedSubCategory.value = allSearchController.subCategoryList[index];
                      if (allSearchController.temporarySelectedSubCategory.value == '') {
                        allSearchController.isSubCategoryBottomSheetState.value = false;
                      } else {
                        allSearchController.isSubCategoryBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedSubCategory.value == allSearchController.subCategoryList[index],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SellPostConditionContent extends StatelessWidget {
  SellPostConditionContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.conditionList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedSellPostCondition.value == allSearchController.conditionList[index]
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedSellPostCondition.value = allSearchController.conditionList[index];
                    // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                    if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                      allSearchController.isSellPostConditionBottomSheetState.value = false;
                    } else {
                      allSearchController.isSellPostConditionBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.conditionList[index],
                  borderColor:
                      allSearchController.temporarySelectedSellPostCondition.value == allSearchController.conditionList[index] ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedSellPostCondition.value = allSearchController.conditionList[index];
                      if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                        allSearchController.isSellPostConditionBottomSheetState.value = false;
                      } else {
                        allSearchController.isSellPostConditionBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedSellPostCondition.value == allSearchController.conditionList[index],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SellPostProductCategoryContent extends StatelessWidget {
  SellPostProductCategoryContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.productCategoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedSellPostProductCategory.value == allSearchController.productCategoryList[index]
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedSellPostProductCategory.value = allSearchController.productCategoryList[index];
                    if (allSearchController.temporarySelectedSellPostProductCategory.value == '') {
                      allSearchController.isSellPostProductConditionBottomSheetState.value = false;
                    } else {
                      allSearchController.isSellPostProductConditionBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.productCategoryList[index],
                  borderColor: allSearchController.temporarySelectedSellPostProductCategory.value == allSearchController.productCategoryList[index]
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedSellPostProductCategory.value = allSearchController.productCategoryList[index];
                      if (allSearchController.temporarySelectedSellPostProductCategory.value == '') {
                        allSearchController.isSellPostProductConditionBottomSheetState.value = false;
                      } else {
                        allSearchController.isSellPostProductConditionBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedSellPostProductCategory.value == allSearchController.productCategoryList[index],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class DatePostedContent extends StatelessWidget {
  DatePostedContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.datePostedList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedDatePosted.value == allSearchController.datePostedList[index]["date"]
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedDatePosted.value = allSearchController.datePostedList[index]["date"];
                    // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                    if (allSearchController.temporarySelectedDatePosted.value == '') {
                      allSearchController.isDatePostedBottomSheetState.value = false;
                    } else {
                      allSearchController.isDatePostedBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.datePostedList[index]["date"],
                  borderColor:
                      allSearchController.temporarySelectedDatePosted.value == allSearchController.datePostedList[index]["date"] ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedDatePosted.value = allSearchController.datePostedList[index]["date"];
                      // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                      if (allSearchController.temporarySelectedDatePosted.value == '') {
                        allSearchController.isDatePostedBottomSheetState.value = false;
                      } else {
                        allSearchController.isDatePostedBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedDatePosted.value == allSearchController.datePostedList[index]["date"],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CategoryContent extends StatelessWidget {
  CategoryContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedCategory.value == allSearchController.categoryList[index] ? cPrimaryTint3Color : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedCategory.value = allSearchController.categoryList[index];
                    // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                    if (allSearchController.temporarySelectedCategory.value == '') {
                      allSearchController.isCategoryBottomSheetState.value = false;
                    } else {
                      allSearchController.isCategoryBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.categoryList[index],
                  borderColor: allSearchController.temporarySelectedCategory.value == allSearchController.categoryList[index] ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedCategory.value = allSearchController.categoryList[index];
                      // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                      if (allSearchController.temporarySelectedCategory.value == '') {
                        allSearchController.isCategoryBottomSheetState.value = false;
                      } else {
                        allSearchController.isCategoryBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedCategory.value == allSearchController.categoryList[index],
                  ),
                ),
              ),
            );
          },
        ),
      ],
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

class VideosContent extends StatelessWidget {
  const VideosContent({
    super.key,
    this.image,
    required this.title,
    this.name,
    this.onPressed,
    this.date,
    this.totalView,
    this.time,
  });
  final String? image;
  final String title;
  final String? name;
  final String? date;
  final String? totalView;
  final String? time;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: SizedBox(
                    width: 120,
                    height: 90,
                    child: Image.network(
                      image ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.imageFile,
                        size: kIconSize70,
                        color: cIconColor,
                      ),
                      loadingBuilder: imageLoadingBuilder,
                    ),
                  ),
                ),
                Positioned(
                  right: h10,
                  bottom: h10,
                  child: Text(
                    time ?? "",
                    style: semiBold12TextStyle(cWhiteColor),
                  ),
                ),
              ],
            ),
          kW12sizedBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // kH8sizedBox,
                Text(
                  title,
                  style: semiBold18TextStyle(cBlackColor),
                  overflow: TextOverflow.clip,
                ),
                kH8sizedBox,
                Text(
                  name ?? "",
                  style: regular16TextStyle(cSmallBodyTextColor),
                  textAlign: TextAlign.left,
                ),
                kH8sizedBox,
                Row(
                  children: [
                    Text(
                      date ?? "",
                      style: regular12TextStyle(cSmallBodyTextColor),
                    ),
                    kW4sizedBox,
                    Text(
                      totalView ?? "",
                      style: regular12TextStyle(cSmallBodyTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SellPostBottomSheetContent extends StatelessWidget {
  SellPostBottomSheetContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => OutLinedButton(
            onPress: () {
              allSearchController.temporarySelectedSellPostType.value = ksRegularPost.tr;
              allSearchController.isSellPostTypeBottomSheetState.value = true;
            },
            suffixWidget: Padding(
              padding: const EdgeInsets.only(right: k8Padding),
              child: Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: k100CircularBorderRadius,
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          cBlueLinearColor1,
                          cBlueLinearColor2,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 7,
                    bottom: 7,
                    child: SvgPicture.asset(
                      kiRegularPostSvgUrl,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
            buttonText: ksRegularPost.tr,
            buttonTextStyle: medium16TextStyle(cBlackColor),
            borderColor: allSearchController.temporarySelectedSellPostType.value == ksRegularPost.tr ? cPrimaryColor : cLineColor,
            buttonColor: allSearchController.temporarySelectedSellPostType.value == ksRegularPost.tr ? cPrimaryTint2Color : cWhiteColor,
          ),
        ),
        kH16sizedBox,
        Obx(
          () => OutLinedButton(
            onPress: () {
              allSearchController.temporarySelectedSellPostType.value = ksBiddingPost.tr;
              allSearchController.isSellPostTypeBottomSheetState.value = true;
            },
            suffixWidget: Padding(
              padding: const EdgeInsets.only(right: k8Padding),
              child: Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: k100CircularBorderRadius,
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          cYellowLinearColor1,
                          cYellowLinearColor2,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 7,
                    bottom: 7,
                    child: SvgPicture.asset(
                      kiBiddingPostSvgUrl,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
            buttonText: ksBiddingPost.tr,
            buttonTextStyle: medium16TextStyle(cBlackColor),
            borderColor: allSearchController.temporarySelectedSellPostType.value == ksBiddingPost.tr ? cPrimaryColor : cLineColor,
            buttonColor: allSearchController.temporarySelectedSellPostType.value == ksBiddingPost ? cPrimaryTint2Color : cWhiteColor,
          ),
        ),
      ],
    );
  }
}
