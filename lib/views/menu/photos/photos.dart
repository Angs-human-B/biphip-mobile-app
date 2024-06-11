import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/models/menu/album/album_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_sheet_contents.dart';
import 'package:bip_hip/views/post/widgets/create_post_upper_section.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Photos extends StatelessWidget {
  Photos({super.key, required this.imageList, this.imageListTitle, required this.albumIndex});
  final List imageList;
  final String? imageListTitle;
  final int albumIndex;
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: imageListTitle,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding),
              child: imageList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: EmptyView(
                            title: ksNoImageAvailable.tr,
                          ),
                        ),
                      ),
                    )
                  : GridView.custom(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                        childCount: imageList.length,
                        (context, index) {
                          String imageUrl = imageList[index].fullPath.toString();
                          return InkWell(
                            onTap: () async {
                              galleryController.imageId.value = imageList[index].id!;
                              await galleryController.getImageDetails();
                              galleryController.imageData.value?.description = null;
                              // Get.to(() => CommonPhotoView(
                              //       image: galleryController.imageDetailsData.value!.image!.fullPath.toString(),
                              //       description: galleryController.imageDetailsData.value!.image!.description ?? '',
                              //       onPressed: () {
                              //         galleryController.photoActionSelect.value = '';
                              //         Get.find<GlobalController>().blankBottomSheet(
                              //           context: context,
                              //           isScrollControlled: true,
                              //           content: PhotoActionContent(),
                              //           bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.4,
                              //         );
                              //       },
                              //     ));
                              // ll(index);
                              // ll(albumIndex);
                              Get.find<PostReactionController>().isRouteFromHomePage.value = false;
                              Get.to(() => GalleryWidget(
                                  urlImages: RxList(galleryController.imageDataList[albumIndex].imageList), imageIndex: index, postIndex: albumIndex));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: cLineColor),
                                borderRadius: k8CircularBorderRadius,
                              ),
                              child: ClipRRect(
                                borderRadius: k8CircularBorderRadius,
                                child: Image.network(
                                  imageUrl,
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
                          );
                        },
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoActionContent extends StatelessWidget {
  PhotoActionContent({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: galleryController.photoActionList.length,
          separatorBuilder: (context, index) => kH8sizedBox,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: kHorizontalPadding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      galleryController.photoActionList[index]['icon'],
                      color: cBlackColor,
                      size: kIconSize16,
                    ),
                  ),
                  title: galleryController.photoActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  itemColor: GalleryPhotoHelper().photoItemColor(index: index),
                  onPressed: () {
                    GalleryPhotoHelper().photoOnPressed(index: index);
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

class GalleryImageShareBottomSheetContent extends StatelessWidget {
  GalleryImageShareBottomSheetContent({super.key, required this.photoData, required this.imageIndex});
  final GalleryController galleryController = Get.find<GalleryController>();
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final AlbumData photoData;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            // kH16sizedBox,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: postReactionController.shareActionList.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding, left: k10Padding, right: k10Padding),
                    child: CustomListTile(
                      leading: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cNeutralColor,
                        ),
                        height: h32,
                        width: h32,
                        child: Icon(
                          postReactionController.shareActionList[index]['icon'],
                          color: cBlackColor,
                          size: isDeviceScreenLarge() ? h18 : h14,
                        ),
                      ),
                      title: postReactionController.shareActionList[index]['action'].toString().tr,
                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                      subTitleTextStyle: regular14TextStyle(cBlackColor),
                      onPressed: () async {
                        Get.back();
                        if (postReactionController.shareActionList[index]['action'] == 'Share to Feed') {
                          Get.find<CreatePostController>().getCreatePost();
                          Get.find<CreatePostController>().isSharingPost.value = true;
                          Get.find<GlobalController>().blankBottomSheet(
                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                              context: context,
                              content: GallerySharePostImageBottomSheetContent(
                                photoData: photoData,
                                imageIndex: imageIndex,
                              ),
                              isScrollControlled: true);
                        }
                        if (postReactionController.shareActionList[index]['action'].toString().toLowerCase() == "Share to Your Kids Profile".toLowerCase()) {
                          createPostController.isKidListLoading.value = true;
                          createPostController.tempSelectedKid.value = null;
                          createPostController.tempKidID.value = -1;
                          if (createPostController.tempSelectedKid.value == null) {
                            createPostController.kidListBottomSheetRightButtonState.value = false;
                          } else {
                            createPostController.kidListBottomSheetRightButtonState.value = true;
                          }
                          Get.find<GlobalController>().commonBottomSheet(
                            isBottomSheetRightButtonActive: createPostController.kidListBottomSheetRightButtonState,
                            isScrollControlled: true,
                            bottomSheetHeight: height * .5,
                            context: Get.context,
                            content: KidListBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {
                              Get.back();
                              Get.find<CreatePostController>().isPostedFromProfile.value = false;
                              CreatePostHelper().resetCreatePostData();
                              createPostController.selectedKid.value = createPostController.tempSelectedKid.value;
                              createPostController.tempSelectedKid.value = null;
                              createPostController.category.value = "Kids";
                              createPostController.kidID.value = createPostController.tempKidID.value;
                              ll(createPostController.kidID.value);
                              createPostController.postSecondaryCircleAvatar.value = createPostController.selectedKid.value!.profilePicture.toString();
                              Get.find<KidsController>().isRouteFromKid.value = false;
                              Get.find<CreatePostController>().getCreatePost();
                              Get.find<CreatePostController>().isSharingPost.value = true;
                              Get.find<GlobalController>().blankBottomSheet(
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                                isScrollControlled: true,
                                context: context,
                                content: GallerySharePostImageBottomSheetContent(
                                  photoData: photoData,
                                  imageIndex: imageIndex,
                                ),
                              );
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: ksSelectKids.tr,
                            isRightButtonShow: true,
                          );
                          await createPostController.getKidList();
                        }
                        if (postReactionController.shareActionList[index]['action'].toString().toLowerCase() == "Share to Your Store Profile".toLowerCase()) {
                          // createPostController.tempSelectedBrandId.value = createPostController.selectedBrandId.value;

                          if (createPostController.tempSelectedBrandId.value == -1) {
                            createPostController.storeListBottomSheetRightButtonState.value = false;
                          } else {
                            createPostController.storeListBottomSheetRightButtonState.value = true;
                          }
                          Get.find<GlobalController>().commonBottomSheet(
                            isBottomSheetRightButtonActive: createPostController.storeListBottomSheetRightButtonState,
                            isScrollControlled: true,
                            bottomSheetHeight: height * 0.5,
                            context: Get.context,
                            content: SelectBrandBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {
                              // createPostHelper.selectBrandTextChange();
                              Get.find<CreatePostController>().isPostedFromProfile.value = false;
                              CreatePostHelper().resetCreatePostData();
                              createPostController.selectedBrandId.value = createPostController.tempSelectedBrandId.value;
                              ll(createPostController.selectedBrandId.value);
                              Get.back();
                              createPostController.category.value = "Selling";
                              for (int i = 0; i < createPostController.storeList.length; i++) {
                                if (createPostController.selectedBrandId.value == createPostController.storeList[i].id) {
                                  createPostController.brandID.value = createPostController.storeList[i].id!;
                                  createPostController.postSecondaryCircleAvatar.value = createPostController.storeList[i].profilePicture.toString();
                                  createPostController.selectedBrandName.value = createPostController.storeList[i].name.toString();
                                }
                              }
                              Get.find<KidsController>().isRouteFromKid.value = false;
                              Get.find<CreatePostController>().getCreatePost();
                              Get.find<CreatePostController>().isSharingPost.value = true;
                              Get.find<GlobalController>().blankBottomSheet(
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                                isScrollControlled: true,
                                context: context,
                                // content: SharePostBottomSheetContent(
                                //   postData: postData,
                                // ),
                                content: GallerySharePostImageBottomSheetContent(
                                  photoData: photoData,
                                  imageIndex: imageIndex,
                                ),
                              );
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: ksSelectBrands.tr,
                            isRightButtonShow: true,
                          );
                          await createPostController.getStoreList();
                        }
                        if (postReactionController.shareActionList[index]['action'].toString().toLowerCase() == "Copy Link".toLowerCase()) {
                          String baseUrl = "bip-hip-dev.vercel.app/posts";
                          Clipboard.setData(ClipboardData(text: "$baseUrl/image/${photoData.imageList[imageIndex].id}"));
                          // ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                          // ll(clipboardData!.text);
                          Get.find<GlobalController>()
                              .showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
                        }
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

class GallerySharePostImageBottomSheetContent extends StatelessWidget {
  GallerySharePostImageBottomSheetContent({super.key, required this.photoData, required this.imageIndex});
  final PostReactionController postReactionController = Get.find<PostReactionController>();
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final AlbumData photoData;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: 4),
          child: Column(
            children: [
              CreatePostUpperSection(),
              CustomModifiedTextField(
                controller: createPostController.createPostTextEditingController,
                maxLength: 1000,
                maxLines: 7,
                minLines: 1,
                isFilled: false,
                fillColor: cWhiteColor,
                inputAction: TextInputAction.newline,
                inputType: TextInputType.multiline,
                hint: "${ksSaySomethingAboutThis.tr}....",
                contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k16Padding),
                textHintStyle: regular16TextStyle(cPlaceHolderColor),
                textInputStyle: regular16TextStyle(cBlackColor),
                onChanged: (v) {},
              ),
              Row(
                children: [
                  const Spacer(),
                  CustomElevatedButton(
                      textStyle: semiBold14TextStyle(cWhiteColor),
                      buttonWidth: 80,
                      buttonHeight: 40,
                      label: ksShareNow.tr,
                      onPressed: () async {
                        Get.back();
                        // await createPostController.sharePost(postData.id.toString());//!APi call
                      }),
                ],
              )
            ],
          ),
        ),
        kH12sizedBox,
        Container(
          width: width,
          height: height * 0.4,
          color: cBackgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(kHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius, border: Border.all(color: cLineColor)),
                      child: Row(
                        children: [
                          // if (postData.images.isNotEmpty && postData.sharePosts == null)
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)), color: cWhiteColor),
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)),
                              child: Image.network(
                                photoData.imageList[imageIndex].fullPath.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize20,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                          // if (postData.sharePosts != null && postData.sharePosts!.images.isNotEmpty)
                          // Container(
                          //   decoration: const BoxDecoration(
                          //       borderRadius: BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)), color: cWhiteColor),
                          //   height: 70,
                          //   width: 70,
                          //   child: ClipRRect(
                          //     borderRadius: const BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)),
                          //     child: Image.network(
                          //       postData.sharePosts!.images[imageIndex].fullPath.toString(),
                          //       fit: BoxFit.cover,
                          //       errorBuilder: (context, error, stackTrace) => const Icon(
                          //         BipHip.imageFile,
                          //         size: kIconSize20,
                          //         color: cIconColor,
                          //       ),
                          //       loadingBuilder: imageLoadingBuilder,
                          //       frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                          //         return child;
                          //       },
                          //     ),
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // if (postData.images[imageIndex].description != null && postData.sharePosts == null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: SizedBox(
                                    width: width - 130,
                                    child: Text(
                                      photoData.imageList[imageIndex].description ?? "",
                                      style: semiBold16TextStyle(cBlackColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                // if (postData.sharePosts != null && postData.sharePosts!.images[imageIndex].description != null)
                                //   Padding(
                                //     padding: const EdgeInsets.only(bottom: 8.0),
                                //     child: SizedBox(
                                //       width: width - 130,
                                //       child: Text(
                                //         postData.sharePosts!.images[imageIndex].description ?? ksNA,
                                //         style: semiBold16TextStyle(cBlackColor),
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //   ),
                                // if (postData.sharePosts == null)
                                SizedBox(
                                  width: width - 130,
                                  child: Text(
                                    Get.find<GlobalController>().userName.toString(),
                                    style: semiBold16TextStyle(cBlackColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // if (postData.sharePosts != null)
                                //   SizedBox(
                                //     width: width - 130,
                                //     child: Text(
                                //       postData.sharePosts!.user!.fullName!,
                                //       style: postData.sharePosts!.content != null ? regular14TextStyle(cSmallBodyTextColor) : semiBold16TextStyle(cBlackColor),
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    kH20sizedBox,
                    Text(
                      ksShareTo.tr,
                      style: semiBold20TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width,
                height: 70,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: k20Padding),
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: createPostController.sharePostOthersList.length,
                    separatorBuilder: (context, index) => kW20sizedBox,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          String baseUrl = "bip-hip-dev.vercel.app/posts";
                          if (createPostController.sharePostOthersList[index]["text"].toString().toLowerCase() == "Copy Link".toLowerCase()) {
                            Clipboard.setData(ClipboardData(text: "$baseUrl/${photoData.imageList[imageIndex].id}"));
                            // ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                            // ll(clipboardData!.text);
                            Get.back();
                            Get.find<GlobalController>()
                                .showSnackBar(title: ksSuccess.tr, message: "Link copied to clipboard", color: cGreenColor, duration: 1000);
                          } else {
                            Get.back();
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: h44,
                              height: h44,
                              decoration: const BoxDecoration(
                                color: cWhiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: CustomIconButton(
                                onPress: null,
                                icon: createPostController.sharePostOthersList[index]["icon"] as IconData,
                                iconColor: cBlackColor,
                                size: kIconSize20,
                              ),
                            ),
                            kH8sizedBox,
                            Text(
                              createPostController.sharePostOthersList[index]["text"].toString(),
                              style: regular12TextStyle(cBlackColor),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }
}
