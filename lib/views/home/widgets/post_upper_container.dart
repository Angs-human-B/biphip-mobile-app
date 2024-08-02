import 'dart:math';

import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostUpperContainer extends StatelessWidget {
  PostUpperContainer({
    super.key,
    required this.postIndex,
  });
  final int postIndex;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            if (globalController.commonPostList[postIndex].type.toString() == "3")
              SizedBox(
                width: width - 48,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        height: h44,
                        width: h44,
                        decoration: const BoxDecoration(
                          color: cBlackColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          globalController.commonPostList[postIndex].user!.profilePicture ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.user,
                            size: kIconSize24,
                            color: cIconColor,
                          ),
                        ),
                      ),
                    ),
                    kW8sizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width - 120,
                          child: Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.clip,
                                  maxLines: 3,
                                  softWrap: true,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: globalController.commonPostList[postIndex].user?.fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      WidgetSpan(
                                        baseline: TextBaseline.alphabetic,
                                        alignment: PlaceholderAlignment.middle,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: k4Padding, right: k4Padding),
                                          child: SvgPicture.asset(
                                            kiRightArrow,
                                            width: h16,
                                            height: h16,
                                            color: cBlackColor,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: globalController.commonPostList[postIndex].user?.fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kH4sizedBox,
                        Row(
                          children: [
                            const Icon(
                              BipHip.birthday,
                              size: kIconSize16,
                              color: cAmberColor,
                            ),
                            kW4sizedBox,
                            Text(
                              ksBirthday.tr,
                              style: semiBold14TextStyle(cAmberColor),
                            ),
                          ],
                        ),
                        kH4sizedBox,
                        Row(
                          children: [
                            Icon(
                              globalController.privacyIcon(globalController.commonPostList[postIndex].isPublic),
                              color: cIconColor,
                              size: kIconSize12,
                            ),
                            Text(
                              ' ${globalController.postTimeDifference(globalController.commonPostList[postIndex].dateTime!)}',
                              style: regular14TextStyle(cSmallBodyTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Transform.rotate(
                        angle: pi / 2,
                        child: InkWell(
                          onTap: () {
                            globalController.blankBottomSheet(
                                context: context,
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.15 : height * 0.25,
                                content: BirthdayBottomSheetContent(
                                  postIndex: postIndex,
                                ));
                          },
                          child: const Icon(
                            BipHip.system,
                            size: kIconSize20,
                            color: cIconColor,
                          ),
                        )),
                  ],
                ),
              ),
            SizedBox(
              width: (globalController.commonPostList[postIndex].kid?.profilePicture != null ||
                      globalController.commonPostList[postIndex].store?.profilePicture != null)
                  ? 70
                  : h44,
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      height: h44,
                      width: h44,
                      decoration: const BoxDecoration(
                        color: cBlackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        globalController.commonPostList[postIndex].user!.profilePicture ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          BipHip.user,
                          size: kIconSize24,
                          color: cIconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (globalController.commonPostList[postIndex].kid?.profilePicture != null ||
                globalController.commonPostList[postIndex].store?.profilePicture != null)
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: ClipOval(
                  child: Container(
                    height: h45,
                    width: h45,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                    child: Image.network(
                      globalController.commonPostList[postIndex].kid?.profilePicture ?? globalController.commonPostList[postIndex].store?.profilePicture ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.user,
                        size: kIconSize24,
                        color: cIconColor,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        kW8sizedBox,
        if (globalController.commonPostList[postIndex].type.toString() != "3")
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: RichText(
                          textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style.copyWith(height: 1.4),
                            children: [
                              TextSpan(
                                text: globalController.commonPostList[postIndex].user!.fullName!,
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                              if (globalController.commonPostList[postIndex].postCategory != null)
                                TextSpan(
                                  text: ' ${ksPostedOn.tr} ',
                                  style: regular16TextStyle(cSmallBodyTextColor),
                                ),
                              if (globalController.commonPostList[postIndex].postCategory != null)
                                WidgetSpan(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 0),
                                        child: Icon(
                                          globalController.getCategoryIcon(globalController.commonPostList[postIndex].postCategory!.id),
                                          color: globalController.getCategoryColor(globalController.commonPostList[postIndex].postCategory!.id),
                                          size: kIconSize14,
                                        ),
                                      ),
                                      if (globalController.commonPostList[postIndex].postCategory != null)
                                        Text(
                                          " ${globalController.commonPostList[postIndex].postCategory!.name!}",
                                          style: semiBold14TextStyle(
                                              globalController.getCategoryColor(globalController.commonPostList[postIndex].postCategory!.id)),
                                        ),
                                    ],
                                  ),
                                ),
                              if (globalController.commonPostList[postIndex].taggedFriends.isNotEmpty)
                                TextSpan(
                                  text: ' ${ksWith.tr} ',
                                  style: regular16TextStyle(cSmallBodyTextColor),
                                ),
                              if (globalController.commonPostList[postIndex].taggedFriends.isNotEmpty)
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () async {
                                      // Get.find<ProfileViewController>().userName.value =
                                      //     globalController.commonPostList[postIndex].taggedFriends[0].userName;
                                      ll(globalController.commonPostList[postIndex].taggedFriends[0].userName);
                                      // Get.toNamed(krProfileView);
                                      // await Get.find<ProfileViewController>().getProfileOverview();
                                      // await Get.find<ProfileViewController>().getProfileViewPostList();
                                      // await Get.find<ProfileViewController>().getProfileViewFriend();
                                    },
                                    child: Text(
                                      '${globalController.commonPostList[postIndex].taggedFriends[0].fullName}',
                                      style: semiBold16TextStyle(cBlackColor),
                                    ),
                                  ),

                                  // text: '${globalController.commonPostList[postIndex].taggedFriends[0].fullName}',
                                  // style: semiBold16TextStyle(cBlackColor),
                                ),
                              if (globalController.commonPostList[postIndex].taggedFriends.isNotEmpty &&
                                  globalController.commonPostList[postIndex].taggedFriends.length == 2)
                                TextSpan(
                                  text: ' & ${globalController.commonPostList[postIndex].taggedFriends[1].fullName}',
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                              if (globalController.commonPostList[postIndex].taggedFriends.isNotEmpty &&
                                  globalController.commonPostList[postIndex].taggedFriends.length > 2)
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () {
                                      Get.find<GlobalController>().commonBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          bottomSheetHeight: globalController.commonPostList[postIndex].taggedFriends.length > 10 ? height * 0.6 : null,
                                          content: TaggedFriendContent(
                                            taggedFriend: globalController.commonPostList[postIndex].taggedFriends,
                                          ),
                                          onPressCloseButton: () {
                                            Get.back();
                                          },
                                          onPressRightButton: () {},
                                          rightText: ksDone.tr,
                                          rightTextStyle: regular14TextStyle(cPrimaryColor),
                                          title: ksTaggedFriends.tr,
                                          isRightButtonShow: false);
                                    },
                                    child: Text(
                                      ' & ${globalController.commonPostList[postIndex].taggedFriends.length - 1} others',
                                      style: semiBold16TextStyle(cBlackColor),
                                    ),
                                  ),
                                ),
                              const TextSpan(text: '\n'),
                              WidgetSpan(
                                baseline: TextBaseline.alphabetic,
                                alignment: PlaceholderAlignment.baseline,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Icon(
                                    globalController.privacyList.firstWhere(
                                      (element) => element['id'] == globalController.commonPostList[postIndex].isPublic,
                                    )["icon"],
                                    color: cIconColor,
                                    size: kIconSize12,
                                  ),
                                ),
                              ),
                              if (globalController.commonPostList[postIndex].postCategory?.name == 'Selling' &&
                                  globalController.commonPostList[postIndex].store != null)
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () async {
                                      Get.find<ProfileViewController>().profileSelectedTabIndex.value = 0;
                                      Get.find<ProfileViewController>().profileViewType.value = "store";
                                      Get.find<ProfileViewController>().kidOrStorePageId.value =
                                          globalController.commonPostList[postIndex].store!.pageId!.toString();
                                      Get.toNamed(krProfileView);
                                      await Get.find<ProfileViewController>()
                                          .getProfileViewStoreOverview(storePageId: Get.find<ProfileViewController>().kidOrStorePageId.value);
                                      await Get.find<ProfileViewController>()
                                          .getProfileViewStorePostList(storePageId: Get.find<ProfileViewController>().kidOrStorePageId.value.toString());
                                    },
                                    child: Text(' (${globalController.commonPostList[postIndex].store?.name})', style: semiBold14TextStyle(cBlackColor)),
                                  ),
                                ),
                              if (globalController.commonPostList[postIndex].postCategory?.name == 'Kids' &&
                                  globalController.commonPostList[postIndex].kid != null)
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () async {
                                      Get.find<ProfileViewController>().profileSelectedTabIndex.value = 0;
                                      Get.find<ProfileViewController>().profileViewType.value = "kid";
                                      Get.find<ProfileViewController>().kidOrStorePageId.value =
                                          globalController.commonPostList[postIndex].kid!.pageId!.toString();
                                      Get.toNamed(krProfileView);
                                      await Get.find<ProfileViewController>()
                                          .getKidProfileOverview(kidPageId: Get.find<ProfileViewController>().kidOrStorePageId.value);
                                      await Get.find<ProfileViewController>()
                                          .getProfileViewKidPostList(kidPageId: Get.find<ProfileViewController>().kidOrStorePageId.value);
                                    },
                                    child: Text(
                                        ' (${globalController.commonPostList[postIndex].kid?.name}, ${globalController.commonPostList[postIndex].kid?.age})',
                                        style: semiBold14TextStyle(cBlackColor)),
                                  ),
                                ),
                              TextSpan(
                                  text: ' ${globalController.postTimeDifference(globalController.commonPostList[postIndex].dateTime!)}',
                                  style: regular14TextStyle(cSmallBodyTextColor))
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        globalController.postSelectedAction.value = "";
                        globalController.selectedAudienceId.value = globalController.commonPostList[postIndex].isPublic!;
                        globalController.blankBottomSheet(
                          context: context,
                          bottomSheetHeight: isDeviceScreenLarge() ? height * 0.32 : height * 0.40,
                          content: Get.find<GlobalController>().userId.value == globalController.commonPostList[postIndex].user!.id
                              ? SelfPostActionContent(
                                  postIndex: postIndex,
                                )
                              : OthersPostActionContent(
                                  postIndex: postIndex,
                                ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: k4Padding),
                        child: Icon(
                          BipHip.system,
                          size: kIconSize18,
                          color: cIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class TaggedFriendContent extends StatelessWidget {
  const TaggedFriendContent({super.key, required this.taggedFriend});
  final List<FriendFamilyUserData> taggedFriend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taggedFriend.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                leading: Container(
                  height: h26,
                  width: h26,
                  decoration: const BoxDecoration(
                    color: cWhiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      taggedFriend[index].profilePicture.toString(),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.user,
                        size: kIconSize24,
                        color: cIconColor,
                      ),
                    ),
                  ),
                ),
                title: taggedFriend[index].fullName,
              );
            })
      ],
    );
  }
}

class SharePostUpperContainer extends StatelessWidget {
  SharePostUpperContainer({
    super.key,
    required this.postIndex,
    this.postUpperContainerOnPressed,
  });
  final int postIndex;
  final VoidCallback? postUpperContainerOnPressed;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: postUpperContainerOnPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: (globalController.commonPostList[postIndex].sharePosts!.kid?.profilePicture != null ||
                        globalController.commonPostList[postIndex].sharePosts!.store?.profilePicture != null)
                    ? 70
                    : h44,
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: h44,
                        width: h44,
                        decoration: const BoxDecoration(
                          color: cBlackColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          globalController.commonPostList[postIndex].sharePosts!.user!.profilePicture ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.user,
                            size: kIconSize24,
                            color: cIconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (globalController.commonPostList[postIndex].sharePosts!.kid?.profilePicture != null ||
                  globalController.commonPostList[postIndex].sharePosts!.store?.profilePicture != null)
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: ClipOval(
                    child: Container(
                      height: h45,
                      width: h45,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                      child: Image.network(
                        globalController.commonPostList[postIndex].sharePosts!.kid?.profilePicture ??
                            globalController.commonPostList[postIndex].sharePosts!.store?.profilePicture ??
                            "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          BipHip.user,
                          size: kIconSize24,
                          color: cIconColor,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          kW8sizedBox,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: RichText(
                          textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style.copyWith(height: 1.4),
                            children: [
                              TextSpan(
                                text: globalController.commonPostList[postIndex].sharePosts!.user!.fullName!,
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                              if (globalController.commonPostList[postIndex].sharePosts!.postCategory != null)
                                TextSpan(
                                  text: ' ${ksPostedOn.tr} ',
                                  style: regular16TextStyle(cSmallBodyTextColor),
                                ),
                              if (globalController.commonPostList[postIndex].sharePosts!.postCategory != null)
                                WidgetSpan(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 0),
                                        child: Icon(
                                          globalController.getCategoryIcon(globalController.commonPostList[postIndex].sharePosts!.postCategory!.id),
                                          color: globalController.getCategoryColor(globalController.commonPostList[postIndex].sharePosts!.postCategory!.id),
                                          size: kIconSize14,
                                        ),
                                      ),
                                      if (globalController.commonPostList[postIndex].sharePosts!.postCategory != null)
                                        Text(
                                          " ${globalController.commonPostList[postIndex].sharePosts!.postCategory!.name!}",
                                          style: semiBold14TextStyle(
                                              globalController.getCategoryColor(globalController.commonPostList[postIndex].sharePosts!.postCategory!.id)),
                                        ),
                                    ],
                                  ),
                                ),
                              if (globalController.commonPostList[postIndex].sharePosts!.taggedFriends.isNotEmpty)
                                TextSpan(
                                  text: ' ${ksWith.tr} ',
                                  style: regular16TextStyle(cSmallBodyTextColor),
                                ),
                              if (globalController.commonPostList[postIndex].sharePosts!.taggedFriends.isNotEmpty)
                                TextSpan(
                                  text: '${globalController.commonPostList[postIndex].sharePosts!.taggedFriends[0].fullName}',
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                              if (globalController.commonPostList[postIndex].sharePosts!.taggedFriends.isNotEmpty &&
                                  globalController.commonPostList[postIndex].sharePosts!.taggedFriends.length == 2)
                                TextSpan(
                                  text: ' & ${globalController.commonPostList[postIndex].sharePosts!.taggedFriends[1].fullName}',
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                              if (globalController.commonPostList[postIndex].sharePosts!.taggedFriends.isNotEmpty &&
                                  globalController.commonPostList[postIndex].sharePosts!.taggedFriends.length > 2)
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () {
                                      Get.find<GlobalController>().commonBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          bottomSheetHeight:
                                              globalController.commonPostList[postIndex].sharePosts!.taggedFriends.length > 10 ? height * 0.6 : null,
                                          content: TaggedFriendContent(
                                            taggedFriend: globalController.commonPostList[postIndex].sharePosts!.taggedFriends,
                                          ),
                                          onPressCloseButton: () {
                                            Get.back();
                                          },
                                          onPressRightButton: () {},
                                          rightText: ksDone.tr,
                                          rightTextStyle: regular14TextStyle(cPrimaryColor),
                                          title: ksTaggedFriends.tr,
                                          isRightButtonShow: false);
                                    },
                                    child: Text(
                                      ' & ${globalController.commonPostList[postIndex].sharePosts!.taggedFriends.length - 1} others',
                                      style: semiBold16TextStyle(cBlackColor),
                                    ),
                                  ),
                                ),
                              const TextSpan(text: '\n'),
                              WidgetSpan(
                                baseline: TextBaseline.alphabetic,
                                alignment: PlaceholderAlignment.baseline,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Icon(
                                    globalController.privacyList.firstWhere(
                                      (element) => element['id'] == globalController.commonPostList[postIndex].sharePosts!.isPublic,
                                    )["icon"],
                                    color: cIconColor,
                                    size: kIconSize12,
                                  ),
                                ),
                              ),
                              if (globalController.commonPostList[postIndex].sharePosts!.postCategory?.name == 'Selling' &&
                                  globalController.commonPostList[postIndex].sharePosts!.store != null)
                                TextSpan(
                                    text: ' (${globalController.commonPostList[postIndex].sharePosts!.store?.name})', style: semiBold14TextStyle(cBlackColor)),
                              if (globalController.commonPostList[postIndex].sharePosts!.postCategory?.name == 'Kids' &&
                                  globalController.commonPostList[postIndex].sharePosts!.kid != null)
                                // TextSpan(
                                //     text:
                                //         ' (${globalController.commonPostList[postIndex].sharePosts!.kid?.name}, ${globalController.commonPostList[postIndex].sharePosts!.kid?.age})',
                                //     style: semiBold14TextStyle(cBlackColor)),
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                        ' (${globalController.commonPostList[postIndex].sharePosts!.kid?.name}, ${globalController.commonPostList[postIndex].sharePosts!.kid?.age})',
                                        style: semiBold14TextStyle(cBlackColor)),
                                  ),
                                ),
                              TextSpan(
                                  text: ' ${globalController.postTimeDifference(globalController.commonPostList[postIndex].sharePosts!.createdAt!)}',
                                  style: regular14TextStyle(cSmallBodyTextColor))
                            ],
                          ),
                        ),
                      ),
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

class SelfPostActionContent extends StatelessWidget {
  SelfPostActionContent({
    super.key,
    required this.postIndex,
  });
  final GlobalController globalController = Get.find<GlobalController>();
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    PostDataRx postData = globalController.commonPostList[postIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k10Padding),
      child: Column(
        children: [
          IconWithTextRow(
            actionIcon: BipHip.edit,
            actionText: "Edit Post",
            actionOnPressed: () async {
              Get.back();
              globalController.postSelectedAction.value = "Edit Post";
              if (globalController.postSelectedAction.value == "Edit Post") {
                CreatePostHelper().resetCreatePostData();
                createPostController.taggedFriends.addAll(postData.taggedFriends);
                createPostController.postId.value = globalController.commonPostList[postIndex].id!;
                createPostController.isEditPost.value = true;
                createPostController.privacyId.value = postData.isPublic!;
                createPostController.category.value = postData.postCategory?.name ?? "";
                createPostController.createPostSelectedPrivacyIcon.value = globalController.privacyIcon(postData.isPublic);
                createPostController.createPostSelectedPrivacy.value = globalController.privacyText(postData.isPublic);
                for (int i = 0; i < createPostController.categoryList.length; i++) {
                  if (createPostController.category.value != "" && createPostController.category.value == createPostController.categoryList[i]['title']) {
                    createPostController.categoryIcon.value = createPostController.categoryList[i]['icon'];
                    createPostController.categoryIconColor.value = createPostController.categoryList[i]['icon_color'];
                    break;
                  }
                }
                if (createPostController.category.value == "Selling") {
                  createPostController.biddingTitleTextEditingController.text = postData.content ?? "";
                  createPostController.biddingDescriptionTextEditingController.text = postData.description ?? "";
                  if (postData.price != null) {
                    createPostController.biddingPriceTextEditingController.text = postData.price.toString();
                  }
                  if (postData.discount != null) {
                    createPostController.biddingDiscountAmountTextEditingController.text = postData.discount.toString();
                  }
                  if (postData.desireAmount != null) {
                    createPostController.biddingDesiredAmountTextEditingController.text = postData.desireAmount.toString();
                  }
                  if (postData.productTags != null) {
                    createPostController.biddingProductTagTextEditingController.text = postData.productTags.toString();
                  }
                  if (postData.sku != null) {
                    createPostController.biddingSKUTextEditingController.text = postData.sku.toString();
                  }
                  if (postData.location != null) {
                    createPostController.sellingLocationTextEditingController.text = postData.location.toString();
                  }
                  if (postData.minBiddingAmount != null) {
                    createPostController.biddingMinimumBidTextEditingController.text = postData.minBiddingAmount.toString();
                  }
                  if (postData.sellPostType != null) {
                    if (postData.sellPostType == 0) {
                      createPostController.sellingPostType.value = ksRegularPost.tr;
                    } else {
                      createPostController.sellingPostType.value = ksBiddingPost.tr;
                    }
                  }
                  createPostController.selectedBrandName.value = postData.store?.name ?? "";
                  createPostController.postSecondaryCircleAvatar.value = postData.store?.profilePicture ?? "";
                } else if (createPostController.category.value == "News") {
                  if (postData.title != null) {
                    createPostController.newsTitleTextEditingController.text = postData.title.toString();
                    createPostController.previousNewsTitle.value = postData.title ?? "";
                  }
                  if (postData.description != null) {
                    createPostController.newsDescriptionTextEditingController.text = postData.description.toString();
                  }
                } else {
                  createPostController.createPostTextEditingController.text = postData.content ?? "";
                  createPostController.previousPostContent.value = postData.content ?? "";
                  if (postData.images.isNotEmpty) {
                    createPostController.imageIdList.clear();
                    createPostController.deleteImageIdList.clear();
                    for (int i = 0; i < postData.images.length; i++) {
                      if (postData.images[i].fullPath != null) {
                        createPostController.allMediaList.add(postData.images[i].fullPath.toString());
                      }
                      createPostController.previousPostImageLength.value = createPostController.allMediaList.length;
                      createPostController.imageIdList.add(postData.images[i].id);
                      createPostController.imageDescriptionTextEditingController.add(TextEditingController(text: postData.images[i].description ?? ""));
                      createPostController.imageLocationsList.add(postData.images[i].imageTakenLocation);
                      createPostController.imageTimesList.add(postData.images[i].imageTakenTime);
                      createPostController.imageTagIdList.add('1,58');
                    }
                  }
                  if (createPostController.category.value == "Kids") {
                    createPostController.postSecondaryCircleAvatar.value = postData.kid?.profilePicture ?? "";
                    createPostController.kidID.value = postData.kid?.id ?? -1;
                  }
                }
                Get.toNamed(krCreatePost);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: BipHip.world,
            actionText: "Edit Audience",
            actionOnPressed: () async {
              Get.back();
              globalController.postSelectedAction.value = "Edit Audience";
              if (globalController.postSelectedAction.value == "Edit Audience") {
                globalController.temporaryselectedAudienceId.value = globalController.selectedAudienceId.value;
                if (globalController.selectedAudienceId.value == 0) {
                  globalController.postAudienceAction.value = "Only me";
                }
                if (globalController.selectedAudienceId.value == 1) {
                  globalController.postAudienceAction.value = "Public";
                }
                if (globalController.selectedAudienceId.value == 2) {
                  globalController.postAudienceAction.value = "Friends";
                }
                if (globalController.selectedAudienceId.value == 3) {
                  globalController.postAudienceAction.value = "Families";
                }
                if (globalController.selectedAudienceId.value == 4) {
                  globalController.postAudienceAction.value = "Friends & Families";
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: EditAudienceActionContent(),
                    onPressCloseButton: () => Get.back(),
                    onPressRightButton: () async {
                      globalController.selectedAudienceId.value = globalController.temporaryselectedAudienceId.value;
                      Get.back();
                      globalController.commonPostList[postIndex].isPublic = globalController.selectedAudienceId.value;
                      await globalController.editAudience(postData.id!);
                      globalController.commonPostList.replaceRange(postIndex, postIndex + 1, [globalController.commonPostList[postIndex]]);
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                    title: "Edit Audience",
                    isBottomSheetRightButtonActive: true.obs,
                    isRightButtonShow: true);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: postData.isNotifaction == true ? BipHip.notificationFill : BipHip.notificationOutline,
            actionText: postData.isNotifaction == true ? "Turn off notification for this post" : "Turn on notification for this post",
            actionOnPressed: () async {
              Get.back();
              if (postData.isNotifaction == true) {
                globalController.postSelectedAction.value = "Turn off notification for this post";
              } else {
                globalController.postSelectedAction.value = "Turn on notification for this post";
              }
              if (globalController.postSelectedAction.value == "Turn off notification for this post") {
                await globalController.postNotificationOff(postId: postData.id!);
              } else {
                await globalController.postNotificationOn(postId: postData.id!);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: BipHip.donatedFill,
            actionText: "Edit Date",
            actionOnPressed: () {
              Get.back();
              globalController.postSelectedAction.value = "Edit Date";
              if (globalController.postSelectedAction.value == "Edit Date") {
                globalController.postDate.value = postData.dateTime.toString();
                globalController.editPostDate(context: context, postId: postData.id!, postIndex: postIndex);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: BipHip.copy,
            actionText: "Copy Link",
            actionOnPressed: () {
              Get.back();
              globalController.postSelectedAction.value = "Copy Link";
              if (globalController.postSelectedAction.value == "Copy Link") {
                String baseUrl = "bip-hip-dev.vercel.app/posts";
                Clipboard.setData(ClipboardData(text: "$baseUrl/${postData.id}"));
                Get.find<GlobalController>().showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: BipHip.deleteNew,
            actionText: "Move to Recycle Bin",
            actionOnPressed: () async {
              Get.back();
              globalController.postSelectedAction.value = "Move to Recycle Bin";
              if (globalController.postSelectedAction.value == "Move to Recycle Bin") {
                CreatePostHelper().deletePostAlertDialog(context: context, id: postData.id!);
              }
            },
          ),
        ],
      ),
    );
  }
}

class EditAudienceActionContent extends StatelessWidget {
  EditAudienceActionContent({super.key});
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: globalController.privacyList.length,
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
                          globalController.privacyList[index]['icon'],
                          color: cBlackColor,
                          size: isDeviceScreenLarge() ? h18 : h14,
                        ),
                      ),
                      title: globalController.privacyList[index]['action'].toString().tr,
                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                      subTitleTextStyle: regular14TextStyle(cBlackColor),
                      itemColor: globalController.postAudienceAction.value == globalController.privacyList[index]['action'] ? cPrimaryTint2Color : cWhiteColor,
                      onPressed: () {
                        globalController.postAudienceAction.value = globalController.privacyList[index]['action'];
                        globalController.temporaryselectedAudienceId.value = globalController.privacyList[index]['id'];
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class ReportBottomSheetContent extends StatelessWidget {
  ReportBottomSheetContent({super.key, required this.postIndex});
  final GlobalController globalController = Get.find<GlobalController>();
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: globalController.reportList.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      title: globalController.reportList[index].title,
                      trailing: const Icon(
                        BipHip.rightArrow,
                        size: kIconSize18,
                        color: cIconColor,
                      ),
                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                      subTitleTextStyle: regular14TextStyle(cBlackColor),
                      itemColor: globalController.reportId.value == globalController.reportList[index].id ? cPrimaryTint2Color : cWhiteColor,
                      onPressed: () {
                        globalController.reportId.value = globalController.reportList[index].id!;
                        globalController.selectedReportIndex.value = index;
                        globalController.reportBottomSheetState.value = true;
                        Get.back();
                        Get.find<GlobalController>().commonBottomSheet(
                            context: Get.context,
                            bottomSheetHeight: height * 0.2,
                            content: ReportDescriptionBottomSheetContent(
                              selectedIndex: globalController.selectedReportIndex.value,
                              postIndex: postIndex,
                            ),
                            onPressCloseButton: () => Get.back(),
                            onPressRightButton: () {
                              Get.back();
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                            title: "Report".tr,
                            isBottomSheetRightButtonActive: globalController.reportBottomSheetState,
                            isRightButtonShow: false);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class ReportDescriptionBottomSheetContent extends StatelessWidget {
  ReportDescriptionBottomSheetContent({super.key, required this.selectedIndex, required this.postIndex});
  final GlobalController globalController = Get.find<GlobalController>();
  final int selectedIndex;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kH8sizedBox,
        Text(
          globalController.reportList[selectedIndex].description ?? "",
          style: regular16TextStyle(cBlackColor),
        ),
        kH20sizedBox,
        CustomElevatedButton(
          label: ksSubmit.tr,
          onPressed: () async {
            Get.back();
            await globalController.postReportAndUndoReport(
              globalController.reportId.value,
              null,
              reportOrUndo: "report",
              postId: globalController.commonPostList[postIndex].id!,
            );
          },
          buttonWidth: width / 2,
          buttonHeight: h32,
        ),
      ],
    );
  }
}

class ReportContentShimmer extends StatelessWidget {
  const ReportContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      title: ShimmerCommon(
                        widget: Container(height: h12, width: width - 80, decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class OthersPostActionContent extends StatelessWidget {
  OthersPostActionContent({super.key, required this.postIndex});
  final GlobalController globalController = Get.find<GlobalController>();
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    PostDataRx postData = globalController.commonPostList[postIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k10Padding),
      child: Column(
        children: [
          IconWithTextRow(
            actionIcon: BipHip.cross,
            actionText: "Hide Post",
            actionOnPressed: () async {
              Get.back();
              globalController.postSelectedAction.value = "Hide post";
              if (globalController.postSelectedAction.value == "Hide post") {
                await globalController.hidePost(postId: postData.id!);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: postData.user!.followStatus == 0 ? BipHip.follow : BipHip.unFollow,
            actionText: postData.user!.followStatus == 0 ? "Follow ${postData.user!.fullName}" : "UnFollow ${postData.user!.fullName}",
            actionOnPressed: () async {
              Get.back();
              if (postData.user!.followStatus == 0) {
                globalController.postSelectedAction.value = "Follow ${postData.user!.fullName}";
              } else {
                globalController.postSelectedAction.value = "UnFollow ${postData.user!.fullName}";
              }
              if (globalController.postSelectedAction.value == "Follow ${postData.user!.fullName}") {
                await globalController.followUnfollowUser(userId: postData.user!.id!, followOrUnfollow: "Follow");
              } else {
                await globalController.followUnfollowUser(userId: postData.user!.id!, followOrUnfollow: "UnFollow");
              }
            },
          ),
          IconWithTextRow(
            actionIcon: postData.isNotifaction == true ? BipHip.notificationFill : BipHip.notificationOutline,
            actionText: postData.isNotifaction == true ? "Turn off notification for this post" : "Turn on notification for this post",
            actionOnPressed: () async {
              Get.back();
              if (postData.isNotifaction == true) {
                globalController.postSelectedAction.value = "Turn off notification for this post";
              } else {
                globalController.postSelectedAction.value = "";
              }
              if (globalController.postSelectedAction.value == "Turn off notification for this post") {
                await globalController.postNotificationOff(postId: postData.id!);
              } else {
                await globalController.postNotificationOn(postId: postData.id!);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: postData.hasReport! ? BipHip.cross : BipHip.report,
            actionText: postData.hasReport! ? "Undo Report" : "Report post",
            actionOnPressed: () async {
              Get.back();
              if (postData.hasReport!) {
                globalController.postSelectedAction.value = "Undo Report";
              } else {
                globalController.postSelectedAction.value = "Report post";
              }
              if (globalController.postSelectedAction.value == "Report post") {
                globalController.reportId.value = -1;
                globalController.reportBottomSheetState.value = false;
                Get.find<GlobalController>().commonBottomSheet(
                    context: Get.context,
                    content: globalController.isReportListLoading.value ? ReportContentShimmer() : ReportBottomSheetContent(postIndex: postIndex),
                    onPressCloseButton: () => Get.back(),
                    onPressRightButton: () {
                      Get.back();
                      Get.find<GlobalController>().commonBottomSheet(
                          context: Get.context,
                          bottomSheetHeight: height * 0.2,
                          content: ReportDescriptionBottomSheetContent(
                            selectedIndex: globalController.selectedReportIndex.value,
                            postIndex: postIndex,
                          ),
                          onPressCloseButton: () => Get.back(),
                          onPressRightButton: () {
                            Get.back();
                          },
                          rightText: ksDone.tr,
                          rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                          title: "Report".tr,
                          isBottomSheetRightButtonActive: globalController.reportBottomSheetState,
                          isRightButtonShow: false);
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                    title: "Report".tr,
                    isBottomSheetRightButtonActive: globalController.reportBottomSheetState,
                    isRightButtonShow: false);
                await globalController.getReportList();
              } else {
                await globalController.postReportAndUndoReport(
                  null,
                  null,
                  reportOrUndo: "Undo Report",
                  postId: postData.id!,
                );
              }
            },
          ),
          IconWithTextRow(
            actionIcon: BipHip.copy,
            actionText: "Copy Link",
            actionOnPressed: () {
              Get.back();
              globalController.postSelectedAction.value = "Copy Link";
              if (globalController.postSelectedAction.value == "Copy Link") {
                String baseUrl = "bip-hip-dev.vercel.app/posts";
                Clipboard.setData(ClipboardData(text: "$baseUrl/${postData.id}"));
                Get.find<GlobalController>().showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
              }
            },
          ),
          IconWithTextRow(
            actionIcon: BipHip.unfriend,
            actionText: "Block ${postData.user!.fullName}",
            actionOnPressed: () async {
              Get.back();
              globalController.postSelectedAction.value = "Block";
              if (globalController.postSelectedAction.value == "Block") {
                await Get.find<FamilyController>().blockUser(userId: postData.user!.id!);
              }
            },
          ),
        ],
      ),
    );
  }
}

class IconWithTextRow extends StatelessWidget {
  const IconWithTextRow(
      {super.key, required this.actionIcon, required this.actionText, this.actionOnPressed, this.iconColor, this.iconSize, this.actionTextStyle});
  final IconData actionIcon;
  final Color? iconColor;
  final String actionText;
  final double? iconSize;
  final TextStyle? actionTextStyle;
  final VoidCallback? actionOnPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: actionOnPressed,
      child: Row(
        children: [
          CustomIconButton(
            icon: actionIcon,
            onPress: null,
            iconColor: iconColor ?? cIconColor,
            size: iconSize ?? kIconSize20,
          ),
          Text(
            actionText,
            style: actionTextStyle ?? semiBold14TextStyle(cBlackColor),
          ),
        ],
      ),
    );
  }
}

class BirthdayBottomSheetContent extends StatelessWidget {
  const BirthdayBottomSheetContent({super.key, required this.postIndex});
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    PostDataRx postData = Get.find<GlobalController>().commonPostList[postIndex];
    return Column(
      children: [
        CustomListTile(
          onPressed: () {
            Get.back();
          },
          leading: Container(
            width: h24,
            height: h24,
            decoration: const BoxDecoration(
              color: cNeutralColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              BipHip.edit,
              size: kIconSize14,
              color: cBlackColor,
            ),
          ),
          title: ksEditPost.tr,
        ),
        CustomListTile(
          onPressed: () {
            Get.back();
            Get.find<PendentBadgesController>().deletePostAlertDialog(context: context, id: postData.id!);
          },
          leading: Container(
            width: h24,
            height: h24,
            decoration: const BoxDecoration(
              color: cNeutralColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              BipHip.deleteNew,
              size: kIconSize14,
              color: cBlackColor,
            ),
          ),
          title: ksDeletePost.tr,
        ),
      ],
    );
  }
}
