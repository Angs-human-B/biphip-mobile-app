import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
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
  // final RxList<Image> kidList = RxList<Image>([]);
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
      ll('getKidsList error: $e');
    }
  }
}
