import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxInt interestCatagoriesIndex = RxInt(0);
  final RxInt profileSelectedTabIndex = RxInt(0);

  final RxList videoContentList = RxList(
    [
      {
        "videoPreviewImage": "https://images.pexels.com/photos/633198/pexels-photo-633198.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "31 January, 2024",
        "postIndex": 1
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/633198/pexels-photo-633198.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "19 March, 2024",
        "postIndex": 2
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/633198/pexels-photo-633198.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "28 February, 2024",
        "postIndex": 3
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/633198/pexels-photo-633198.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "22 July, 2024",
        "postIndex": 4
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/633198/pexels-photo-633198.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "21 Auguest, 2024",
        "postIndex": 5
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/633198/pexels-photo-633198.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "1 January, 2024",
        "postIndex": 6
      },
    ],
  );
}
