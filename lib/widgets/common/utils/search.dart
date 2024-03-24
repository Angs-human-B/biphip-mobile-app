import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
    // required this.searchTextEditingController,
    // required this.recentSearchList,
    // required this.onSubmit,
    // this.isShopSearch = false,
    // this.isHomeSearch = false,
    // this.isFavoriteSearch = false,
  }) : super(key: key);

  // final TextEditingController searchTextEditingController;
  // final RxList recentSearchList;
  // final dynamic onSubmit;
  // final bool isShopSearch, isHomeSearch, isFavoriteSearch;
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    RxBool isSuffix = RxBool(false);
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Obx(
          () => Scaffold(
            //* info:: body
            body: SingleChildScrollView(
              child: Column(
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
                            hint: ksSearch.tr,
                            borderRadius: 30,
                            contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: h12),
                            controller: allSearchController.searchTextEditingController,
                            fillColor: cInputFieldColor,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            prefixIcon: BipHip.search,
                            suffixIcon: isSuffix.value ? BipHip.circleCrossNew : null,
                            onSuffixPress: isSuffix.value
                                ? () {
                                    allSearchController.searchTextEditingController.clear();
                                    isSuffix.value = false;
                                  }
                                : null,
                            onChanged: (v) {
                              if (v.isEmpty) {
                                isSuffix.value = false;
                              } else {
                                isSuffix.value = true;
                              }
                            },
                            onSubmit: (v) async {
                              // unfocus(context);
                              // if (v.isNotEmpty) {
                              //   var item = v.toLowerCase();
                              //   for (int i = 0; i < recentSearchList.length; i++) {
                              //     if (recentSearchList[i] == item) {
                              //       recentSearchList.remove(item);
                              //     }
                              //   }
                              //   recentSearchList.add(item);
                              // } else {
                              //   recentSearchList.add('...');
                              // }
                              // if (recentSearchList.length > 6) recentSearchList.removeAt(0);
                              // final spController = SpController();
                              // await spController.saveRecentSearchList(recentSearchList);
                              // onSubmit();
                              // searchTextEditingController.clear();
                            },
                          ),
                        ),
                      ),
                      if (allSearchController.selectedFilterIndex.value != 0)
                        CustomIconButton(
                          onPress: () {
                            globalController.commonBottomSheet(
                                context: context,
                                isBottomSheetRightButtonActive: allSearchController.isFilterRightButtonActive,
                                content: PostsFilterContent(),
                                bottomSheetHeight: height * 0.4,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {},
                                rightText: ksReset.tr,
                                rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                title: ksPosts.tr,
                                isRightButtonShow: true);
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

                  // Wrap(
                  //   alignment: WrapAlignment.start,
                  //   direction: Axis.horizontal,
                  //   spacing: 8.0,
                  //   children: [
                  //     for (int i = 0; i < allSearchController.filterTypeList.length; i++)
                  //       Padding(
                  //         padding: const EdgeInsets.only(bottom: k8Padding),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               color: cWhiteColor,
                  //               border: Border.all(
                  //                 color: cLineColor,
                  //               ),
                  //               borderRadius: k100CircularBorderRadius),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(k8Padding),
                  //             child: Text(
                  //               // profileController.userData.value!.interest[i],
                  //               // kidsController.kidsData.value?.hobbies[i],
                  //               // kidsController.kidsData.value!.hobbies[i],
                  //               allSearchController.filterTypeList[i],
                  //               style: regular14TextStyle(cBlackColor),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //   ],
                  // ),

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
                  if (allSearchController.selectedFilterIndex.value == 0)
                    Column(
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
                            child: Column(
                              children: [
                                ListView.separated(
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
                              ],
                            ),
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
                                    categoryIcon:
                                        item.postCategory == null ? null : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
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
                  if (allSearchController.selectedFilterIndex.value == 1)
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
                                categoryIcon:
                                    item.postCategory == null ? null : Get.find<HomeController>().getCategoryIcon(item.postCategory!.id), // need change API
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
                  if (allSearchController.selectedFilterIndex.value == 2)
                    if (allSearchController.userList.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
                        child: Column(
                          children: [
                            ListView.separated(
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
                          ],
                        ),
                      ),
                ],
              ),
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
    return Column(
      children: [
        // OutLinedButton(
        //   buttonText: ksRecentPost.tr,
        //   borderColor: cNeutralColor,
        //   suffixWidget: Obx(() => SizedBox(
        //         width: (width - 330) / 2,
        //         child: CustomCheckBox(
        //             value: allSearchController.isRecentPostCheckBoxSelected.value,
        //             label: "",
        //             onChanged: (v) {
        //               allSearchController.isRecentPostCheckBoxSelected.value = !allSearchController.isRecentPostCheckBoxSelected.value;
        //             },
        //             textStyle: regular14TextStyle(cBlackColor)),
        //       )),
        // ),
        Row(
          children: [
            Container(
              width: h24,
              height: h24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cNeutralColor,
              ),
              child: const Icon(
                Icons.timer,
                size: kIconSize12,
                color: cIconColor,
              ),
            ),
            kW8sizedBox,
            Text(
              ksRecentPost.tr,
              style: semiBold14TextStyle(cBlackColor),
            ),
            const Spacer(),
            Obx(() => SizedBox(
                  width: (width - 330) / 2,
                  child: CustomCheckBox(
                      value: allSearchController.isRecentPostCheckBoxSelected.value,
                      label: "",
                      onChanged: (v) {
                        allSearchController.isRecentPostCheckBoxSelected.value = !allSearchController.isRecentPostCheckBoxSelected.value;
                      },
                      textStyle: regular14TextStyle(cBlackColor)),
                )),
          ],
        ),

        kH16sizedBox,
        OutLinedButton(
          buttonText: ksPostedBy.tr,
          borderColor: cWhiteColor,
          onPress: () {},
          buttonTextStyle: semiBold14TextStyle(cBlackColor),
          suffixWidget: Container(
            width: h24,
            height: h24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: cNeutralColor,
            ),
            child: const Icon(
              BipHip.world,
              size: kIconSize12,
              color: cIconColor,
            ),
          ),
          subTitleText: "Anyone",
          buttonHeight: h40,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        kH16sizedBox,
        OutLinedButton(
          buttonText: ksDatePosted.tr,
          borderColor: cWhiteColor,
          onPress: () {},
          buttonTextStyle: semiBold14TextStyle(cBlackColor),
          suffixWidget: Container(
            width: h24,
            height: h24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: cNeutralColor,
            ),
            child: const Icon(
              Icons.date_range_outlined, //!Icon Must change
              size: kIconSize12,
              color: cIconColor,
            ),
          ),
          subTitleText: "AnyDate",
          buttonHeight: h40,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        OutLinedButton(
          buttonText: ksCategory.tr,
          borderColor: cWhiteColor,
          onPress: () {},
          buttonTextStyle: semiBold14TextStyle(cBlackColor),
          suffixWidget: Container(
            width: h24,
            height: h24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: cNeutralColor,
            ),
            child: const Icon(
              BipHip.menuFill,
              size: kIconSize12,
              color: cIconColor,
            ),
          ),
          subTitleText: "Any Category",
          buttonHeight: h40,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
