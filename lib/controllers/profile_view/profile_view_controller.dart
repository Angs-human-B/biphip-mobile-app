import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/store_review/profile_view_create_review.dart';

class ProfileViewController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxInt interestCatagoriesIndex = RxInt(0);
  final RxInt profileSelectedTabIndex = RxInt(0);
  //* Videos
  final RxList videoContentList = RxList(
    [
      {
        "videoPreviewImage": "https://images.pexels.com/photos/633198/pexels-photo-633198.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "31 January, 2024",
        "postIndex": 1
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/1804035/pexels-photo-1804035.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "19 March, 2024",
        "postIndex": 2
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/280471/pexels-photo-280471.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "28 February, 2024",
        "postIndex": 3
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/18104/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "22 July, 2024",
        "postIndex": 4
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/768474/pexels-photo-768474.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "21 Auguest, 2024",
        "postIndex": 5
      },
      {
        "videoPreviewImage": "https://images.pexels.com/photos/1049446/pexels-photo-1049446.jpeg?auto=compress&cs=tinysrgb&w=800",
        "videoTitle": "video title 1",
        "videoPublishedDate": "1 January, 2024",
        "postIndex": 6
      },
    ],
  );
  //* Photos
  final RxList photoTapAbleButtonState = RxList([true, false]);
  final RxList photoTapAbleButtonText = RxList(["All Photos", "Albums"]);
  //*For tapAble button
  void photoToggleType(int index) {
    switch (index) {
      case 0:
        photoTapAbleButtonState[0] = true;
        photoTapAbleButtonState[1] = false;
        break;
      case 1:
        photoTapAbleButtonState[0] = false;
        photoTapAbleButtonState[1] = true;
        break;
    }
  }

  final RxList allPhotoList = RxList([
    "https://images.pexels.com/photos/390574/pexels-photo-390574.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/3750893/pexels-photo-3750893.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/271816/pexels-photo-271816.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/271795/pexels-photo-271795.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/2679542/pexels-photo-2679542.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/373578/pexels-photo-373578.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/2510067/pexels-photo-2510067.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/2440471/pexels-photo-2440471.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/4210778/pexels-photo-4210778.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/2332909/pexels-photo-2332909.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/4207788/pexels-photo-4207788.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/4010464/pexels-photo-4010464.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/6446708/pexels-photo-6446708.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://images.pexels.com/photos/6177609/pexels-photo-6177609.jpeg?auto=compress&cs=tinysrgb&w=800",
  ]);
  final RxList photoAlbumList = RxList([
    {
      "title": "Photography",
      "subTitle": "5",
      "image": [
        "https://images.pexels.com/photos/390574/pexels-photo-390574.jpeg?auto=compress&cs=tinysrgb&w=800",
        "https://images.pexels.com/photos/4210778/pexels-photo-4210778.jpeg?auto=compress&cs=tinysrgb&w=800"
      ],
    },
    {
      "title": "Poetry",
      "subTitle": "3",
      "image": [
        "https://images.pexels.com/photos/6177609/pexels-photo-6177609.jpeg?auto=compress&cs=tinysrgb&w=800",
        "https://images.pexels.com/photos/4210778/pexels-photo-4210778.jpeg?auto=compress&cs=tinysrgb&w=800"
      ],
    },
    {
      "title": "News",
      "subTitle": "1",
      "image": [
        "https://images.pexels.com/photos/4207788/pexels-photo-4207788.jpeg?auto=compress&cs=tinysrgb&w=800",
        "https://images.pexels.com/photos/4210778/pexels-photo-4210778.jpeg?auto=compress&cs=tinysrgb&w=800"
      ],
    },
    {
      "title": "Storytelling",
      "subTitle": "4",
      "image": [
        "https://images.pexels.com/photos/2679542/pexels-photo-2679542.jpeg?auto=compress&cs=tinysrgb&w=800",
        "https://images.pexels.com/photos/4210778/pexels-photo-4210778.jpeg?auto=compress&cs=tinysrgb&w=800"
      ],
    },
  ]);
  final TextEditingController friendSearchController = TextEditingController();
  final TextEditingController familySearchController = TextEditingController();
  final TextEditingController followerSearchController = TextEditingController();
  final RxBool isKidOrStoreProfile = RxBool(false);
  final RxString profileViewType = RxString("");
  final RxString storeRating = RxString("4.8");
  final RxInt storeRatingReviewCount = RxInt(36);
  final RxList storeReviewList = RxList([
    {
      "userImage":
          "https://media.istockphoto.com/id/1490133656/photo/young-woman-using-a-laptop-while-working-from-home.jpg?s=1024x1024&w=is&k=20&c=mg4cZuZQfZcBi6KBU_JyNGSFzA2ZSCOexOjep4TazLc=",
      "userName": "Jane Smith",
      "storeName": " Emma Isabella",
      "rating": "4.0",
      "postText": "I have been doing business",
    },
    {
      "userImage":
          "https://media.istockphoto.com/id/1490133656/photo/young-woman-using-a-laptop-while-working-from-home.jpg?s=1024x1024&w=is&k=20&c=mg4cZuZQfZcBi6KBU_JyNGSFzA2ZSCOexOjep4TazLc=",
      "userName": "Jane Smith",
      "storeName": " Emma Isabella",
      "rating": "4.0",
      "postText": "I have been doing business",
    },
    {
      "userImage":
          "https://media.istockphoto.com/id/1490133656/photo/young-woman-using-a-laptop-while-working-from-home.jpg?s=1024x1024&w=is&k=20&c=mg4cZuZQfZcBi6KBU_JyNGSFzA2ZSCOexOjep4TazLc=",
      "userName": "Jane Smith",
      "storeName": " Emma Isabella",
      "rating": "4.0",
      "postText": "I have been doing business",
    },
    {
      "userImage":
          "https://media.istockphoto.com/id/1490133656/photo/young-woman-using-a-laptop-while-working-from-home.jpg?s=1024x1024&w=is&k=20&c=mg4cZuZQfZcBi6KBU_JyNGSFzA2ZSCOexOjep4TazLc=",
      "userName": "Jane Smith",
      "storeName": " Emma Isabella",
      "rating": "4.0",
      "postText": "I have been doing business",
    },
    {
      "userImage":
          "https://media.istockphoto.com/id/1490133656/photo/young-woman-using-a-laptop-while-working-from-home.jpg?s=1024x1024&w=is&k=20&c=mg4cZuZQfZcBi6KBU_JyNGSFzA2ZSCOexOjep4TazLc=",
      "userName": "Jane Smith",
      "storeName": " Emma Isabella",
      "rating": "4.0",
      "postText": "I have been doing business",
    },
  ]);
  final RxString temporaryReviewSelectedPrivacy = RxString("Public");
  final RxString reviewSelectedPrivacy = RxString("Public");
  final Rx<IconData> temporaryeviewSelectedPrivacyIcon = Rx<IconData>(BipHip.world);
  final Rx<IconData> reviewSelectedPrivacyIcon = Rx<IconData>(BipHip.world);
  final RxInt reviewPrivacyId = RxInt(1);
  final RxDouble ratingValue = RxDouble(4.0);
  final RxList<Map<String, dynamic>> reviewPrivacyList = RxList([
    {'icon': BipHip.world, 'action': 'Public', 'id': 1},
    {'icon': BipHip.lock, 'action': 'Only me', 'id': 2},
    {'icon': BipHip.friends, 'action': 'Friends', 'id': 3},
    {'icon': BipHip.addFamily, 'action': 'Families', 'id': 4},
    {'icon': BipHip.addFamily, 'action': 'Friends & Families', 'id': 5},
  ]);

  void showReviewPrivacySheet(context) {
    temporaryReviewSelectedPrivacy.value = reviewSelectedPrivacy.value;
    Get.find<GlobalController>().commonBottomSheet(
      isBottomSheetRightButtonActive: true.obs,
      bottomSheetHeight: height * .5,
      context: context,
      content: ReviewAudienceContent(),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        reviewSelectedPrivacy.value = temporaryReviewSelectedPrivacy.value;
        reviewSelectedPrivacyIcon.value = temporaryeviewSelectedPrivacyIcon.value;
        if (reviewSelectedPrivacy.value.toLowerCase() == "Public".toLowerCase()) {
          reviewPrivacyId.value = 1;
        } else if (reviewSelectedPrivacy.value.toLowerCase() == "Friends".toLowerCase()) {
          reviewPrivacyId.value = 3;
        } else if (reviewSelectedPrivacy.value.toLowerCase() == "Friends".toLowerCase()) {
          reviewPrivacyId.value = 3;
        } else if (reviewSelectedPrivacy.value.toLowerCase() == "Families".toLowerCase()) {
          reviewPrivacyId.value = 4;
        } else if (reviewSelectedPrivacy.value.toLowerCase() == "Friend & Family".toLowerCase()) {
          reviewPrivacyId.value = 5;
        }
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksEditAudience.tr,
      isRightButtonShow: true,
    );
  }
}
