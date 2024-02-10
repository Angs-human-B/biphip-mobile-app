import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/shimmers/post/create_post_shimmers.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreateAlbum extends StatelessWidget {
  CreateAlbum({super.key});
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
              title: ksCreateAlbum.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k20Padding),
                  child: Obx(() => TextButton(
                        style: kTextButtonStyle,
                        onPressed: galleryController.isCreateAlbumPostButtonEnable.value
                            ? () {
                                Get.back();
                              }
                            : null,
                        child: Text(
                          ksPost.tr,
                          style: semiBold16TextStyle(galleryController.isCreateAlbumPostButtonEnable.value ? cPrimaryColor : cPlaceHolderColor),
                        ),
                      )),
                ),
              ],
            ),
          ),
          body: Obx(() => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kH16sizedBox,
                        CustomModifiedTextField(
                          controller: galleryController.createAlbumNameController,
                          hint: ksAlbumNamw.tr,
                          errorText: galleryController.albumNameErrorText.value,
                          onChanged: (text) {
                            galleryController.albumNameOnChange();
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.text,
                          maxLength: 50,
                        ),
                        kH8sizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomElevatedButton(
                              isCustomButton: true,
                              label: galleryController.createAlbumSelectedPrivacy.value,
                              prefixIcon: galleryController.createAlbumSelectedPrivacyIcon.value,
                              onPressed: () {
                                unFocus(context);
                                GalleryPhotoHelper().showAudienceSheet(context);
                              },
                              buttonHeight: 22,
                              suffixIcon: BipHip.downArrow,
                              buttonColor: cGreyBoxColor,
                              prefixIconColor: cBlackColor,
                              suffixIconColor: cBlackColor,
                              textStyle: regular12TextStyle(cBlackColor),
                            ),
                          ],
                        ),
                        kH16sizedBox,
                        galleryController.createAlbumAllMediaFileList.isEmpty
                            ? InkWell(
                                onTap: () async {},
                                child: Container(
                                  width: width,
                                  height: isDeviceScreenLarge() ? 148 : 124,
                                  decoration: BoxDecoration(
                                    color: cPrimaryTint4Color,
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    border: Border.all(color: cPrimaryColor, width: 1),
                                  ),
                                  child: Column(
                                    children: [
                                      kH16sizedBox,
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: const BoxDecoration(color: cPrimaryTint2Color, shape: BoxShape.circle),
                                        child: const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize28,
                                          color: cPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        ksAddPhotoAndVideo,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      kH4sizedBox,
                                      Text(
                                        ksTapToUpload.tr,
                                        style: regular12TextStyle(cPlaceHolderColor),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: h12,
                                  crossAxisSpacing: h12,
                                  childAspectRatio: 0.83,
                                ),
                                itemCount: galleryController.createAlbumAllMediaFileList.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      if (galleryController.createAlbumAllMediaFileList.length != index)
                                        ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(k8BorderRadius)),
                                            child: Image.file(
                                              galleryController.createAlbumAllMediaFileList[index].value,
                                              width: (width - 40) / 3,
                                              fit: BoxFit.cover,
                                            )),
                                      if (galleryController.createAlbumAllMediaFileList.length != index)
                                        Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              width: h20,
                                              height: h20,
                                              decoration: const BoxDecoration(
                                                color: cRedColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                  child: CustomIconButton(
                                                onPress: () {
                                                  // createPostHelper.removeSellingMedia(index);
                                                },
                                                icon: BipHip.cross,
                                                iconColor: cWhiteColor,
                                                size: kIconSize14,
                                              )),
                                            )),
                                    ],
                                  );
                                }),
                      ],
                    ),
                  ),
                  kH16sizedBox,
                  Positioned(
                    bottom: 0,
                    child: CreateAlbumBottomSection(),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class CreateAlbumAudienceContent extends StatelessWidget {
  CreateAlbumAudienceContent({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${ksWhoCanSeeYourPost.tr}?",
          style: semiBold16TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        Text(
          ksAudienceInformation.tr,
          style: regular14TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        for (int i = 0; i < galleryController.privacyList.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: k4Padding),
            child: Obx(
              () => CustomListTile(
                onPressed: () {
                  galleryController.temporaryCreateAlbumSelectedPrivacy.value = galleryController.privacyList[i]['name'].toString();
                  galleryController.temporaryCreateAlbumSelectedPrivacyIcon.value = galleryController.privacyList[i]['icon'];
                  galleryController.temoparyprivacyId.value = galleryController.privacyList[i]['id'];
                },
                itemColor: galleryController.temporaryCreateAlbumSelectedPrivacy.value == galleryController.privacyList[i]['name'].toString()
                    ? cPrimaryTint3Color
                    : cWhiteColor,
                title: galleryController.privacyList[i]['name'].toString(),
                leading: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: cNeutralColor,
                  ),
                  height: h28,
                  width: h28,
                  child: Icon(
                    galleryController.privacyList[i]['icon'],
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  ),
                ),
                trailing: CustomRadioButton(
                  onChanged: () {
                    galleryController.temporaryCreateAlbumSelectedPrivacy.value = galleryController.privacyList[i]['name'].toString();
                    galleryController.temporaryCreateAlbumSelectedPrivacyIcon.value = galleryController.privacyList[i]['icon'];
                    galleryController.temoparyprivacyId.value = galleryController.privacyList[i]['id'];
                  },
                  isSelected: galleryController.temporaryCreateAlbumSelectedPrivacy.value == galleryController.privacyList[i]['name'].toString(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CreateAlbumBottomSection extends StatelessWidget {
  CreateAlbumBottomSection({super.key});
  final GalleryPhotoHelper galleryPhotoHelper = GalleryPhotoHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      width: width,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 4; i++)
            TextButton(
              onPressed: () async {
                galleryPhotoHelper.getBottomRowOnPressed(i + 1, context);
              },
              style: kTextButtonStyle,
              child: SizedBox(
                width: width * .25,
                height: 40,
                child: Icon(
                  galleryPhotoHelper.getBottomRowIcon(i + 1),
                  color: galleryPhotoHelper.getBottomIconColor(i + 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
}


class CreateAlbumTagPeopleBottomSheetContent extends StatelessWidget {
  CreateAlbumTagPeopleBottomSheetContent({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Obx(() => Get.find<FriendController>().isFriendListLoading.value
          ? const TagFriendShimmer()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (galleryController.temporaryTaggedFriends.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: k2Padding, bottom: k8Padding),
                    child: Text(
                      ksSelected.tr,
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                  ),
                if (galleryController.temporaryTaggedFriends.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: k12Padding),
                    child: Container(
                      color: cWhiteColor,
                      height: 40,
                      width: width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => kW8sizedBox,
                        scrollDirection: Axis.horizontal,
                        itemCount: galleryController.temporaryTaggedFriends.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: h40,
                                width: h40,
                                decoration: const BoxDecoration(
                                  color: cWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    galleryController.temporaryTaggedFriends[index].profilePicture.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(kiProfileDefaultImageUrl);
                                    },
                                    loadingBuilder: imageLoadingBuilder,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: InkWell(
                                  onTap: () {
                                    galleryController.tagFriendList
                                        .insert(galleryController.temporaryTagIndex[index], galleryController.temporaryTaggedFriends[index]);
                                    galleryController.temporaryTagIndex.removeAt(index);
                                    galleryController.temporaryTaggedFriends.removeAt(index);
                                    if (galleryController.temporaryTaggedFriends.isNotEmpty) {
                                      galleryController.tagFriendButtonSheetRightButtonState.value = true;
                                    } else {
                                      galleryController.tagFriendButtonSheetRightButtonState.value = false;
                                    }
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cWhiteColor,
                                    ),
                                    child: const Icon(
                                      BipHip.circleCrossNew,
                                      size: 12,
                                      color: cRedColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: k2Padding),
                  child: Text(
                    ksSuggestionAllCap.tr,
                    style: regular14TextStyle(cSmallBodyTextColor),
                  ),
                ),
                kH8sizedBox,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: galleryController.tagFriendList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: k10Padding),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            galleryController.temporaryTaggedFriends.add(galleryController.tagFriendList[index]);
                            galleryController.temporaryTagIndex.add(index);
                            galleryController.tagFriendList.removeAt(index);
                            if (galleryController.temporaryTaggedFriends.isNotEmpty) {
                              galleryController.tagFriendButtonSheetRightButtonState.value = true;
                            } else {
                              galleryController.tagFriendButtonSheetRightButtonState.value = false;
                            }
                          },
                          child: CustomListTile(
                            padding: const EdgeInsets.symmetric(horizontal: k0Padding, vertical: k4Padding),
                            leading: Container(
                              height: h40,
                              width: h40,
                              decoration: const BoxDecoration(
                                color: cWhiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  galleryController.tagFriendList[index].profilePicture.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(kiProfileDefaultImageUrl);
                                  },
                                  loadingBuilder: imageLoadingBuilder,
                                ),
                              ),
                            ),
                            title: galleryController.tagFriendList[index].fullName,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
    );
  }
}

