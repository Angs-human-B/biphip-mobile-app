import 'package:bip_hip/utils/constants/imports.dart';

class GalleryController extends GetxController {
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
  final List galleryAlbumPhotos = [
//     const String kiDummyImage1ImageUrl = 'assets/images/pic4.jpeg';
// const String kiDummyImage2ImageUrl = 'assets/images/pic5.jpeg';
// const String kiDummyImage3ImageUrl = 'assets/images/pic12.jpeg';
    {'title': 'Untitled', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
    {'title': 'Poetery', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
    {
      'title': 'Photography',
      'items': '18 Items',
      'image1': 'assets/images/pic4.jpeg',
      'image2': 'assets/images/pic5.jpeg',
      'image3': 'assets/images/pic12.jpeg'
    },
    {'title': 'Painting', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
    {'title': 'Storytelling', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
    {'title': 'Kids', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
    {'title': 'Selling', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
    {'title': 'News', 'items': '18 Items', 'image1': 'assets/images/pic4.jpeg', 'image2': 'assets/images/pic5.jpeg', 'image3': 'assets/images/pic12.jpeg'},
  ];
}
