import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/shimmers/post/create_post_shimmers.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/create_album_media_section.dart';
import 'package:bip_hip/views/menu/photos/create_album_upper_section.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class CreateAlbum extends StatelessWidget {
  CreateAlbum({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    ll("BELLO: ${galleryController.privacyId.value}");
    ll("HELLO: ${galleryController.selectedPrivacyId.value}");
    return Obx(
      () => Stack(
        children: [
          Container(
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
                      title: galleryController.isEditAlbum.value ? ksEditAlbum : ksCreateAlbum.tr,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                      action: [
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(right: k20Padding),
                              child: TextButton(
                                style: kTextButtonStyle,
                                onPressed: galleryController.isCreateAlbumPostButtonEnable.value ||
                                        (galleryController.privacyId.value != galleryController.selectedPrivacyId.value)
                                    ? () async {
                                        if (galleryController.isEditAlbum.value) {
                                          await galleryController.updateAlbum(albumId: galleryController.selectedAlbumId.value);
                                        } else {
                                          await galleryController.createAlbum();
                                        }
                                      }
                                    : null,
                                child: Text(
                                  galleryController.isEditAlbum.value ? ksSave : ksPost.tr,
                                  style: semiBold16TextStyle(galleryController.isCreateAlbumPostButtonEnable.value ||
                                          (galleryController.privacyId.value != galleryController.selectedPrivacyId.value)
                                      ? cPrimaryColor
                                      : cPlaceHolderColor),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  body: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH16sizedBox,
                            CreateAlbumUpperSection(),
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
                            if (galleryController.allMediaList.isEmpty)
                              InkWell(
                                onTap: () async {
                                  var status = await Get.find<GlobalController>().selectMultiMediaSource(galleryController.isCreateAlbumMediaChanged,
                                      galleryController.createAlbumAllMediaLinkList, galleryController.createAlbumAllMediaFileList);
                                  if (status) {
                                    GalleryPhotoHelper().insertMedia(galleryController.createAlbumAllMediaFileList);
                                    GalleryPhotoHelper().configImageDescription();
                                    galleryController.checkCreateAlbum();
                                    galleryController.isCreateAlbumMediaChanged.value = false;
                                    galleryController.createAlbumAllMediaLinkList.clear();
                                    galleryController.createAlbumAllMediaFileList.clear();
                                  }
                                },
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
                              ),
                            if (galleryController.allMediaList.isNotEmpty) CreateAlbumtMediaSection(),
                          ],
                        ),
                      ),
                      kH16sizedBox,
                      Positioned(
                        bottom: 44,
                        child: SizedBox(
                          width: width,
                          child: const CustomDivider(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: CreateAlbumBottomSection(),
                      )
                    ],
                  )),
            ),
          ),
          if (galleryController.isCreateAlbumLoading.value)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (galleryController.isCreateAlbumLoading.value) {
                    return false;
                  }
                  return true;
                },
              ),
            ),
        ],
      ),
    );
  }
}

class CreateAlbumAudienceContent extends StatelessWidget {
  CreateAlbumAudienceContent({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();
  final GlobalController globalController = Get.find<GlobalController>();

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
        for (int i = 0; i < globalController.privacyList.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: k4Padding),
            child: Obx(
              () => CustomListTile(
                onPressed: () {
                  galleryController.temporaryCreateAlbumSelectedPrivacy.value = globalController.privacyList[i]['action'].toString();
                  galleryController.temporaryCreateAlbumSelectedPrivacyIcon.value = globalController.privacyList[i]['icon'];
                  galleryController.temporaryprivacyId.value = globalController.privacyList[i]['id'];
                },
                itemColor: galleryController.temporaryprivacyId.value == globalController.privacyList[i]['id'] ? cPrimaryTint3Color : cWhiteColor,
                title: globalController.privacyList[i]['action'].toString(),
                leading: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: cNeutralColor,
                  ),
                  height: h28,
                  width: h28,
                  child: Icon(
                    globalController.privacyList[i]['icon'],
                    color: cBlackColor,
                    size: isDeviceScreenLarge() ? h18 : h14,
                  ),
                ),
                trailing: CustomRadioButton(
                  onChanged: () {
                    galleryController.temporaryCreateAlbumSelectedPrivacy.value = globalController.privacyList[i]['name'].toString();
                    galleryController.temporaryCreateAlbumSelectedPrivacyIcon.value = globalController.privacyList[i]['icon'];
                    galleryController.temporaryprivacyId.value = globalController.privacyList[i]['id'];
                  },
                  isSelected: galleryController.temporaryprivacyId.value == globalController.privacyList[i]['id'],
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
              onPressed: i == 2
                  ? null
                  : () async {
                      galleryPhotoHelper.getBottomRowOnPressed(i + 1, context);
                    },
              style: kTextButtonStyle,
              child: SizedBox(
                width: width * 0.25,
                height: 44,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SvgPicture.asset(
                    galleryPhotoHelper.getBottomRowPicture(i + 1),
                    color: i == 2 ? cIconColor : null,
                    height: h20,
                  ),
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
                                    height: h16,
                                    width: h16,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cRedColor,
                                    ),
                                    child: const Icon(
                                      BipHip.cross,
                                      size: 12,
                                      color: cWhiteColor,
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
