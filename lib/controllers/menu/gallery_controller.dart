import 'dart:io';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/menu/album/album_list_model.dart';
import 'package:bip_hip/models/menu/album/image_details_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final RxList tapAbleButtonState = RxList([true, false]);
  final RxList tapAbleButtonText = RxList(["Your Photos", "Albums"]);

  @override
  void onInit() {
    super.onInit();
    ll('Gallery APi Call test');
    if (albumData.value != null) {
      imageDataList.clear();
      for (var album in albumData.value!.imageAlbums.data) {
        if (album.title!.toLowerCase() == 'profile picture' || album.title!.toLowerCase() == 'cover photo') {
          imageDataList.add(album);
        }
      }
    }
    toggleType(0);
  }

  //*For tapAble button
  void toggleType(int index) {
    switch (index) {
      case 0:
        tapAbleButtonState[0] = true;
        tapAbleButtonState[1] = false;
        break;
      case 1:
        tapAbleButtonState[0] = false;
        tapAbleButtonState[1] = true;
        break;
    }
  }

  final List galleryVideos = [
    {
      'title': 'Untitled Videos',
      'items': '18 Items',
      'video1': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video2': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video3': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
    },
    {
      'title': 'Poetery',
      'items': '18 Items',
      'video1': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video2': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video3': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
    },
    {
      'title': 'Painting',
      'items': '18 Items',
      'video1': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video2': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video3': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
    },
    {
      'title': 'Photography',
      'items': '18 Items',
      'video1': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video2': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video3': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
    },
    {
      'title': 'Kids',
      'items': '18 Items',
      'video1': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video2': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video3': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
    },
    {
      'title': 'Selling',
      'items': '18 Items',
      'video1': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video2': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video3': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
    },
    {
      'title': 'News',
      'items': '18 Items',
      'video1': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video2': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
      'video3': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
    },
  ];

//*Album List Data Api Call
  Rx<AlbumListModel?> albumData = Rx<AlbumListModel?>(null);
  RxList<AlbumData> imageDataList = RxList<AlbumData>([]);
  final RxBool isAlbumListLoading = RxBool(false);
  Future<void> getGalleryAlbumList() async {
    try {
      isAlbumListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuAlbumList,
      ) as CommonDM;
      if (response.success == true) {
        GalleryPhotoHelper().resetTapButtonData();
        imageDataList.clear();
        albumData.value = AlbumListModel.fromJson(response.data);
        imageDataList.clear();
        for (var album in albumData.value!.imageAlbums.data) {
          if (album.title!.toLowerCase() == 'profile picture' || album.title!.toLowerCase() == 'cover photo') {
            imageDataList.add(album);
          }
        }

        toggleType(0);

        isAlbumListLoading.value = false;
      } else {
        isAlbumListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAlbumListLoading.value = true;
      ll('getAlbumListData error: $e');
    }
  }

  List selectedImageList = [];
  final RxString selectedTitle = RxString('');
  final RxInt imageId = RxInt(-1);

  //*Get Image details Api call
  final Rx<ImageDetailsModel?> imageDetailsData = Rx<ImageDetailsModel?>(null);
  final RxBool isImageDetailsLoading = RxBool(false);
  Future<void> getImageDetails() async {
    try {
      isImageDetailsLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuImageDetails/${imageId.value.toString()}',
      ) as CommonDM;
      if (response.success == true) {
        imageDetailsData.value = ImageDetailsModel.fromJson(response.data);
        isImageDetailsLoading.value = false;
      } else {
        isImageDetailsLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isImageDetailsLoading.value = true;
      ll('getImageDetails error: $e');
    }
  }

  //*Image as profile picture
  final RxBool isImageMakeProfilePictureLoading = RxBool(false);
  Future<void> imageMakeProfilePicture() async {
    try {
      isImageMakeProfilePictureLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'image_id': imageId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuImageMakeProfilePicture,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        isImageMakeProfilePictureLoading.value = false;
        if (!Get.isSnackbarOpen) {
          globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        }
      } else {
        isImageMakeProfilePictureLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (!Get.isSnackbarOpen) {
          if (errorModel.errors.isEmpty) {
            globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
          } else {
            globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
          }
        }
      }
    } catch (e) {
      isImageMakeProfilePictureLoading.value = false;
      ll('imageMakeProfilePicture error: $e');
    }
  }

  //*Image as Cover photo
  final RxBool isImageMakeCoverPhotoLoading = RxBool(false);
  Future<void> imageMakeCoverPhoto() async {
    try {
      isImageMakeCoverPhotoLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'image_id': imageId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuImageMakeCoverPhoto,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        isImageMakeCoverPhotoLoading.value = false;
        if (!Get.isSnackbarOpen) {
          globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        }
      } else {
        isImageMakeCoverPhotoLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (!Get.isSnackbarOpen) {
          if (errorModel.errors.isEmpty) {
            globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
          } else {
            globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
          }
        }
      }
    } catch (e) {
      isImageMakeCoverPhotoLoading.value = false;
      ll('imageMakeCoverPhoto error: $e');
    }
  }

  //*Delete Photo Api Call
  final RxBool isPhotoDeleteLoading = RxBool(false);
  Future<void> deleteImage() async {
    try {
      isPhotoDeleteLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteImage/${imageId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        getGalleryAlbumList();
        isPhotoDeleteLoading.value = false;
        Get.back();
        getGalleryAlbumList();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isPhotoDeleteLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPhotoDeleteLoading.value = false;
      ll('deleteImage error: $e');
    }
  }

  //*Download Photo Api Call
  final RxBool isDownloadImageLoading = RxBool(false);
  Future<void> downloadPhoto() async {
    try {
      isDownloadImageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        url: '$kuDownloadImage/${imageId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        isDownloadImageLoading.value = false;

        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isDownloadImageLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isDownloadImageLoading.value = false;
      ll('downloadImage error: $e');
    }
  }

  //*Image description update
  final TextEditingController imageDescriptionUpdateController = TextEditingController();
  final RxBool isImageDescriptionUpdateLoading = RxBool(false);
  Future<void> imageDescriptionUpdate() async {
    try {
      isImageDescriptionUpdateLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'id': imageId.value.toString(),
        'description': imageDescriptionUpdateController.text.toString().trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuImageMakeCoverPhoto,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        isImageDescriptionUpdateLoading.value = false;
        if (!Get.isSnackbarOpen) {
          globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        }
      } else {
        isImageDescriptionUpdateLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (!Get.isSnackbarOpen) {
          if (errorModel.errors.isEmpty) {
            globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
          } else {
            globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
          }
        }
      }
    } catch (e) {
      isImageDescriptionUpdateLoading.value = false;
      ll('imageDescriptionUpdate error: $e');
    }
  }

  final RxBool galleryPhotoBottomSheetRightButtonState = RxBool(false);
  final RxString galleryPhotoActionSelect = RxString('');
  final RxList galleryPhotoActionList = RxList([
    {'icon': BipHip.imageFile, 'action': 'Download album'}
  ]);
  final RxString photoActionSelect = RxString('');
  final RxList photoActionList = RxList([
    {'icon': BipHip.deleteNew, 'action': 'Delete photo'},
    {'icon': BipHip.edit, 'action': 'Edit caption'},
    {'icon': BipHip.downArrowOutline, 'action': 'Download photo'},
    {'icon': BipHip.user, 'action': 'Make as profile picture'},
    {'icon': BipHip.imageFile, 'action': 'Make as cover photo'},
  ]);
  //*Create Album
  final TextEditingController createAlbumNameController = TextEditingController();
  final Rx<String?> albumNameErrorText = Rx<String?>(null);
  final RxBool isCreateAlbumPostButtonEnable = RxBool(false);
  //*for privacy
  final RxString temporaryCreateAlbumSelectedPrivacy = RxString('Friends');
  final RxString createAlbumSelectedPrivacy = RxString('Friends');
  final Rx<IconData> temporaryCreateAlbumSelectedPrivacyIcon = Rx<IconData>(BipHip.friends);
  final Rx<IconData> createAlbumSelectedPrivacyIcon = Rx<IconData>(BipHip.friends);
  final RxInt privacyId = RxInt(2);
  final RxInt temoparyprivacyId = RxInt(2);

  void albumNameOnChange() {
    if (createAlbumNameController.text.toString().trim() == '') {
      albumNameErrorText.value = ksEmptyAlbumNameErrorText.tr;
    } else {
      albumNameErrorText.value = null;
    }
    checkCreateAlbum();
  }

  void checkCreateAlbum() {
    if (createAlbumNameController.text.toString().trim() != '' && allMediaList.isNotEmpty) {
      isCreateAlbumPostButtonEnable.value = true;
    } else {
      isCreateAlbumPostButtonEnable.value = false;
    }
  }

  final List<Map<String, dynamic>> privacyList = [
    {'id': 0, 'name': 'Private', 'icon': BipHip.lock},
    {'id': 1, 'name': 'Public', "icon": BipHip.world},
    {'id': 2, 'name': 'Friends', "icon": BipHip.friends},
    {'id': 3, 'name': 'Families', "icon": BipHip.addFamily},
    {'id': 4, 'name': 'Friend & Family', "icon": BipHip.friends},
  ];

  final RxBool isCreateAlbumMediaChanged = RxBool(false);
  final RxList<FriendFamilyUserData> tagFriendList = RxList<FriendFamilyUserData>([]);
  final RxList<FriendFamilyUserData> temporaryTaggedFriends = RxList<FriendFamilyUserData>([]);
  final RxList<FriendFamilyUserData> taggedFriends = RxList<FriendFamilyUserData>([]);
  final RxList temporaryTagIndex = RxList([]);
  final RxBool tagFriendButtonSheetRightButtonState = RxBool(false);
  //*Add location
  final TextEditingController locationTextEditingController = TextEditingController();
  final List<String> locationList = ['Agargaon', 'Shewrapara', 'Kazipara', 'Mirpur10', 'Mirpur11', 'Pallabi', 'Mirpur12'];
  final RxBool isLocationSaveEnable = RxBool(false);
  final RxBool isAddLocationSuffixIconVisible = RxBool(false);
  final RxString addLocationValue = RxString('');
  void checkCanSaveLocation() {
    if (locationTextEditingController.text.toString().trim() != '') {
      isLocationSaveEnable.value = true;
    } else {
      isLocationSaveEnable.value = false;
    }
  }

  final RxList allMediaList = RxList([]);
  final RxList<Rx<File>> allMediaFileList = RxList<Rx<File>>([]);
  final RxList<RxString> createAlbumAllMediaLinkList = RxList<RxString>([]);
  final RxList<Rx<File>> createAlbumAllMediaFileList = RxList<Rx<File>>([]);
  List imageDescriptionTextEditingController = [];
  List imageLocationsList = [];
  List imageTimesList = [];
  List imageTagIdList = [];
  //*Date and time
  final RxString createAlbumDate = RxString('');
  final RxString temporaryCreateAlbumDate = RxString('');
  final RxBool createAlbumDateBottomSheetState = RxBool(false);
  final RxString createAlbumTime = RxString('');
  final RxString temporaryCreateAlbumTime = RxString('');
  final RxBool createAlbumTimeBottomSheetState = RxBool(false);
  final RxBool isDateTimeSaveButtonEnable = RxBool(false);

//*Create album Api call
  final RxBool isCreateAlbumLoading = RxBool(false);
  Future<void> createAlbum() async {
    List tags = [];
    for (int i = 0; i < taggedFriends.length; i++) {
      tags.add(taggedFriends[i].id);
    }
    try {
      isCreateAlbumLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'title': createAlbumNameController.text.toString().trim(),
        'privacy': privacyId.value.toString(),
        // 'post_tag_friend_id': tags.join(','),
        for (int i = 0; i < imageDescriptionTextEditingController.length; i++) 'description[$i]': imageDescriptionTextEditingController[i].text.toString(),
        for (int i = 0; i < imageLocationsList.length; i++) 'location[$i]': imageLocationsList[i].toString(),
        for (int i = 0; i < imageTimesList.length; i++) 'time[$i]': imageTimesList[i].toString(),
        for (int i = 0; i < imageTagIdList.length; i++) 'tag_friend_ids[$i]': imageTagIdList[i].toString(),
      };
      ll(body);
      var response = await apiController.multiMediaUpload(
        url: kuCreateAlbum,
        body: body,
        token: token,
        key: 'images[]',
        values: allMediaList,
      ) as CommonDM;

      if (response.success == true) {
        isCreateAlbumLoading.value = false;
        Get.offNamedUntil(krGalleryPhotos, ModalRoute.withName(krMenu));
        getGalleryAlbumList();
        GalleryPhotoHelper().resetCreateAlbumData();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isCreateAlbumLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCreateAlbumLoading.value = false;
      ll('createAlbum error: $e');
    }
  }
}
