import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/models/common/common_error_model.dart';
import 'package:bip_hip/models/profile/album_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();
  final RxList tapAbleButtonState = RxList([true, false]);
  final RxList tapAbleButtonText = RxList(["Your Photos", "Albums"]);

  //*For tapAble button
  void toggleType(int index) {
    for (int i = 0; i < 2; i++) {
      if (index == i) {
        tapAbleButtonState[i] = true;
      } else {
        tapAbleButtonState[i] = false;
      }
    }
  }

  void resetTapButtonData() {
    tapAbleButtonState.clear();
    tapAbleButtonState.addAll([true, false]);
  }

  @override
  void onInit() {
    super.onInit();
    if (albumData.value != null) {
      imageDataList.clear();

      for (var album in albumData.value!.imageAlbums!.data) {
        if (album.title.toLowerCase() == 'profile picture' || album.title.toLowerCase() == 'cover photo') {
          imageDataList.add(album);
        }
      }
    }

    // resetTapButtonData();

    toggleType(0);
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

  // final List galleryAlbumPhotos = [
  //   {'title': 'Untitled', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
  //   {'title': 'Poetery', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
  //   {
  //     'title': 'Photography',
  //     'items': '18 Items',
  //     'image1': 'assets/images/pic4.jpeg',
  //     'image2': 'assets/images/pic5.jpeg',
  //     'image3': 'assets/images/pic12.jpeg'
  //   },
  //   {'title': 'Painting', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
  //   {
  //     'title': 'Storytelling',
  //     'items': '18 Items',
  //     'image1': 'assets/images/pic4.jpeg',
  //     'image2': 'assets/images/pic5.jpeg',
  //     'image3': 'assets/images/pic12.jpeg'
  //   },
  //   {'title': 'Kids', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
  //   {'title': 'Selling', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
  //   {'title': 'News', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
  // ];

//*Album List Data
  Rx<AlbumListModel?> albumData = Rx<AlbumListModel?>(null);
  RxList<ImageData> imageDataList = RxList<ImageData>([]);
  // RxList<ImageData> yourPhotosImageDataList = RxList<ImageData>([]);
  // RxList<ImageData> galleryImageDataList = RxList<ImageData>([]);
  final RxBool isAlbumListLoading = RxBool(false);
  Future<void> getGalleryAlbumList() async {
    try {
      isAlbumListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuAlbumList,
      ) as CommonDM;
      if (response.success == true) {
        resetTapButtonData();
        imageDataList.clear();
        albumData.value = AlbumListModel.fromJson(response.data);
        // imageDataList.addAll(albumData.value!.imageAlbums!.data);
        imageDataList.clear();
        for (var album in albumData.value!.imageAlbums!.data) {
          if (album.title.toLowerCase() == 'profile picture' || album.title.toLowerCase() == 'cover photo') {
            imageDataList.add(album);
          }
        }

        toggleType(0);
        // for (int index = 0; index < imageDataList.length; index++) {
        //   if (tapAbleButtonState[0] &&
        //       (imageDataList[index].title.toString().toLowerCase() == 'profile picture' ||
        //           imageDataList[index].title.toString().toLowerCase() == 'cover photo')) {
        //     imageDataList.clear();
        //     imageDataList.add(imageDataList[index]);
        //     ll('Hi');
        //   } else if (tapAbleButtonState[1] &&
        //       (imageDataList[index].title.toString().toLowerCase() != 'profile picture' ||
        //           imageDataList[index].title.toString().toLowerCase() != 'cover photo')) {
        //     imageDataList.clear();
        //     imageDataList.add(imageDataList[index]);
        //     ll('Hlw');
        //   }
        // }

        // imageList.addAll(albumData.value!);

        // ll(imageDataList[3].title);
        // for (int index = 0; index < imageDataList.length; index++) {
        //   if (tapAbleButtonState[0] &&
        //       (imageDataList[index].title.toString().toLowerCase() == 'profile picture' ||
        //           imageDataList[index].title.toString().toLowerCase() == 'cover photo')) {
        //     imageDataList.clear();
        //     imageDataList.add(imageDataList[index]);
        //     ll('Hi');
        //   }
        // }
        isAlbumListLoading.value = false;
      } else {
        isAlbumListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAlbumListLoading.value = false;
      ll('getAlbumListData error: $e');
    }
  }
}
