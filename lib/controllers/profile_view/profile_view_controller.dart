import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';
import 'package:bip_hip/models/profile_view/user/user_profile_view_overview_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

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

  final RxString userName = RxString("");

  //!Profile view api implement
  //* Profile overview API Implementation
  Rx<UserProfileViewOverviewModel?> userProfileViewData = Rx<UserProfileViewOverviewModel?>(null);
  Rx<User?> userProfileData = Rx<User?>(null);
  Rx<CurrentCity?> hometownData = Rx<CurrentCity?>(null);
  Rx<CurrentCity?> currentCityData = Rx<CurrentCity?>(null);
  Rx<Works?> userCurrentWorkplace = Rx<Works?>(null);
  RxBool isUserProfileViewLoading = RxBool(false);
  Future<void> getProfileOverview() async {
    try {
      isUserProfileViewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/overview",
      ) as CommonDM;
      if (response.success == true) {
        userProfileViewData.value = UserProfileViewOverviewModel.fromJson(response.data);
        userProfileData.value = userProfileViewData.value!.user;
        hometownData.value = userProfileViewData.value!.hometown;
        currentCityData.value = userProfileViewData.value!.currentCity;
        userCurrentWorkplace.value = userProfileViewData.value!.works;
        isUserProfileViewLoading.value = false;
      } else {
        isUserProfileViewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUserProfileViewLoading.value = true;
      ll('getProfileOverview error: $e');
    }
  }

  //* Profile view Contact info api
  Rx<UserProfileViewBasicInfoModel?> userProfileBasicData = Rx<UserProfileViewBasicInfoModel?>(null);
  RxList<Contact?> userBasicData = RxList<Contact?>([]);
  RxList<Link?> userLinkData = RxList<Link?>([]);
  RxBool isUserBasicInfoLoading = RxBool(false);
  Future<void> getProfileBasicInfo() async {
    try {
      isUserBasicInfoLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/basic-info",
      ) as CommonDM;
      if (response.success == true) {
        userProfileBasicData.value = UserProfileViewBasicInfoModel.fromJson(response.data);
        userBasicData.value = userProfileBasicData.value!.contacts!;
        userLinkData.value = userProfileBasicData.value!.links!;
        isUserBasicInfoLoading.value = false;
      } else {
        isUserBasicInfoLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUserBasicInfoLoading.value = true;
      ll('getProfileBasicInfo error: $e');
    }
  }
}
