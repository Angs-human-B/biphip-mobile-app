import 'package:bip_hip/controllers/profile_view/profile_view_kid_post_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/models/profile_view/kid/profile_view_kid_overview_model.dart';
import 'package:bip_hip/models/profile_view/store/profile_view_store_overview_model.dart';
import 'package:bip_hip/models/profile_view/store/profile_view_store_review_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_award_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_friend_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_image_album_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_image_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_place_live_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_post_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_user_family_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_video_model.dart';
import 'package:bip_hip/models/profile_view/user/profile_view_work_education_model.dart';
import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';
import 'package:bip_hip/models/profile_view/user/user_profile_view_overview_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/utils/constants/strings.dart';
import 'package:intl/intl.dart';
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

  final RxString userName = RxString("");

  //!Profile view api implement
  //* Profile overview API Implementation
  Rx<UserProfileViewOverviewModel?> userProfileViewData = Rx<UserProfileViewOverviewModel?>(null);
  Rx<User?> userProfileData = Rx<User?>(null);
  // Rx<CurrentCity?> hometownData = Rx<CurrentCity?>(null);
  // Rx<CurrentCity?> currentCityData = Rx<CurrentCity?>(null);
  // Rx<Works?> userCurrentWorkplace = Rx<Works?>(null);
  RxBool isUserProfileViewOverviewLoading = RxBool(false);
  Future<void> getProfileOverview() async {
    try {
      isUserProfileViewOverviewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/overview",
      ) as CommonDM;
      if (response.success == true) {
        userProfileViewData.value = UserProfileViewOverviewModel.fromJson(response.data);
        userProfileData.value = userProfileViewData.value!.user;
        // hometownData.value = userProfileViewData.value!.hometown;
        // currentCityData.value = userProfileViewData.value!.currentCity;
        // userCurrentWorkplace.value = userProfileViewData.value!.works;
        isUserProfileViewOverviewLoading.value = false;
      } else {
        isUserProfileViewOverviewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUserProfileViewOverviewLoading.value = true;
      ll('getProfileOverview error: $e');
    }
  }

  //* Profile view Basic info api
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

  //* Profile view Work and Education info api
  Rx<ProfileViewWorkEducationModel?> profileViewWorkEducationData = Rx<ProfileViewWorkEducationModel?>(null);
  RxList<Work?> workPlaceList = RxList<Work?>([]);
  RxList<College?> collegeDataList = RxList<College?>([]);
  RxList<College?> schoolDataList = RxList<College?>([]);
  RxBool isProfileViewWorkEducationLoading = RxBool(false);
  Future<void> getProfileViewWorkEducation() async {
    try {
      isProfileViewWorkEducationLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/work-education",
      ) as CommonDM;
      if (response.success == true) {
        profileViewWorkEducationData.value = ProfileViewWorkEducationModel.fromJson(response.data);
        workPlaceList.addAll(profileViewWorkEducationData.value!.works!);
        collegeDataList.addAll(profileViewWorkEducationData.value!.colleges!);
        schoolDataList.addAll(profileViewWorkEducationData.value!.schools!);
        isProfileViewWorkEducationLoading.value = false;
      } else {
        isProfileViewWorkEducationLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileViewWorkEducationLoading.value = true;
      ll('getProfileViewWorkEducation error: $e');
    }
  }

  //* Profile view Friends api
  Rx<ProfileViewFriendModel?> profileFriendData = Rx<ProfileViewFriendModel?>(null);
  RxList<MutualFriendData?> profileMutualFriendList = RxList<MutualFriendData?>([]);
  RxList<FriendData?> profileFriendList = RxList<FriendData?>([]);
  RxBool isProfileViewFriendLoading = RxBool(false);
  Future<void> getProfileViewFriend() async {
    try {
      isProfileViewFriendLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/friends?all_friend_take=20&mutual_friend_take=20",
      ) as CommonDM;
      if (response.success == true) {
        profileMutualFriendList.clear();
        profileFriendList.clear();
        profileFriendData.value = ProfileViewFriendModel.fromJson(response.data);
        profileMutualFriendList.addAll(profileFriendData.value!.mutualFriends!.data!);
        profileFriendList.addAll(profileFriendData.value!.friends!.data!);
        isProfileViewFriendLoading.value = false;
      } else {
        isProfileViewFriendLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileViewFriendLoading.value = true;
      ll('getProfileViewFriend error: $e');
    }
  }

  //* Profile view Family api
  Rx<ProfileViewUserFamilyModel?> profileFamilyData = Rx<ProfileViewUserFamilyModel?>(null);
  RxList<FamilyData?> profileFamilyList = RxList<FamilyData?>([]);
  RxBool isProfileViewFamilyLoading = RxBool(false);
  Future<void> getProfileViewFamily() async {
    try {
      isProfileViewFamilyLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/families?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileFamilyList.clear();
        profileFamilyData.value = ProfileViewUserFamilyModel.fromJson(response.data);
        profileFamilyList.addAll(profileFamilyData.value!.families!.data!);
        isProfileViewFamilyLoading.value = false;
      } else {
        isProfileViewFamilyLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileViewFamilyLoading.value = true;
      ll('getProfileViewFriend error: $e');
    }
  }

  //* Profile view Place Live info api
  Rx<ProfileViewPlaceLiveModel?> profileViewPlaceLiveData = Rx<ProfileViewPlaceLiveModel?>(null);
  Rx<CurrentCity?> profileViewHometownData = Rx<CurrentCity?>(null);
  Rx<CurrentCity?> profileViewCurrentCityData = Rx<CurrentCity?>(null);
  RxList<CurrentCity?> profileViewPlacesList = RxList<CurrentCity?>([]);
  RxBool isProfileViewPlaceLiveLoading = RxBool(false);
  Future<void> getProfileViewPlaceLived() async {
    try {
      isProfileViewPlaceLiveLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/places",
      ) as CommonDM;
      if (response.success == true) {
        profileViewPlaceLiveData.value = ProfileViewPlaceLiveModel.fromJson(response.data);
        profileViewHometownData.value = profileViewPlaceLiveData.value!.hometown;
        profileViewCurrentCityData.value = profileViewPlaceLiveData.value!.currentCity;
        profileViewPlacesList.addAll(profileViewPlaceLiveData.value!.places!);
        isProfileViewPlaceLiveLoading.value = false;
      } else {
        isProfileViewPlaceLiveLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileViewPlaceLiveLoading.value = true;
      ll('getProfileViewWorkEducation error: $e');
    }
  }

  //*Award APi implement
  final Rx<ProfileViewAwardModel?> allAwardListData = Rx<ProfileViewAwardModel?>(null);
  final RxList<AllAwardData> allAwardList = RxList<AllAwardData>([]);
  final Rx<String?> awardListSubLink = Rx<String?>(null);
  final RxBool awardListScrolled = RxBool(false);
  final RxBool isawardListLoading = RxBool(false);
  Future<void> getProfileViewAwardList() async {
    try {
      isawardListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/awards?take=20",
      ) as CommonDM;
      if (response.success == true) {
        allAwardList.clear();
        awardListScrolled.value = false;
        allAwardListData.value = ProfileViewAwardModel.fromJson(response.data);
        allAwardList.addAll(allAwardListData.value!.awards!.data!);
        awardListSubLink.value = allAwardListData.value!.awards!.nextPageUrl;
        if (awardListSubLink.value != null) {
          awardListScrolled.value = false;
        } else {
          awardListScrolled.value = true;
        }
        isawardListLoading.value = false;
      } else {
        isawardListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isawardListLoading.value = true;
      ll('getProfileViewAwardList error: $e');
    }
  }

  //*Image APi implement
  final Rx<ProfileViewImageModel?> profileViewImageData = Rx<ProfileViewImageModel?>(null);
  final RxList<ImageData> allImageList = RxList<ImageData>([]);
  final Rx<String?> allImageListSubLink = Rx<String?>(null);
  final RxBool allImageListScrolled = RxBool(false);
  final RxBool isAllImageListLoading = RxBool(false);
  Future<void> getAllImage() async {
    try {
      isAllImageListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/images?take=20",
      ) as CommonDM;
      if (response.success == true) {
        allImageList.clear();
        allImageListScrolled.value = false;
        profileViewImageData.value = ProfileViewImageModel.fromJson(response.data);
        allImageList.addAll(profileViewImageData.value!.images!.data!);
        allImageListSubLink.value = profileViewImageData.value!.images!.nextPageUrl;
        if (allImageListSubLink.value != null) {
          allImageListScrolled.value = false;
        } else {
          allImageListScrolled.value = true;
        }
        isAllImageListLoading.value = false;
      } else {
        isAllImageListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAllImageListLoading.value = true;
      ll('getAllImage error: $e');
    }
  }

  //*Image Album APi implement
  final Rx<ProfileViewImageAlbumModel?> profileViewImageAlbumData = Rx<ProfileViewImageAlbumModel?>(null);
  final RxList<ImageAlbumData> imageAlbumList = RxList<ImageAlbumData>([]);
  final Rx<String?> imageAlbumListSubLink = Rx<String?>(null);
  final RxBool imageAlbumListScrolled = RxBool(false);
  final RxBool isImageAlbumListLoading = RxBool(false);
  Future<void> getImageAlbum() async {
    try {
      isImageAlbumListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/image-albums?take=20",
      ) as CommonDM;
      if (response.success == true) {
        imageAlbumList.clear();
        imageAlbumListScrolled.value = false;
        profileViewImageAlbumData.value = ProfileViewImageAlbumModel.fromJson(response.data);
        imageAlbumList.addAll(profileViewImageAlbumData.value!.imageAlbums!.data!);
        imageAlbumListSubLink.value = profileViewImageAlbumData.value!.imageAlbums!.nextPageUrl;
        if (imageAlbumListSubLink.value != null) {
          imageAlbumListScrolled.value = false;
        } else {
          imageAlbumListScrolled.value = true;
        }
        isImageAlbumListLoading.value = false;
      } else {
        isImageAlbumListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isImageAlbumListLoading.value = true;
      ll('getImageAlbum error: $e');
    }
  }

  //*Video APi implement
  final Rx<ProfileViewVideoModel?> videoData = Rx<ProfileViewVideoModel?>(null);
  final RxList<VideoData> videoList = RxList<VideoData>([]);
  final Rx<String?> videoListSubLink = Rx<String?>(null);
  final RxBool videoListScrolled = RxBool(false);
  final RxBool isVideoListLoading = RxBool(false);
  Future<void> getVideos() async {
    try {
      isVideoListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/videos?take=20",
      ) as CommonDM;
      if (response.success == true) {
        videoList.clear();
        videoListScrolled.value = false;
        videoData.value = ProfileViewVideoModel.fromJson(response.data);
        videoList.addAll(videoData.value!.videos!.data!);
        videoListSubLink.value = videoData.value!.videos!.nextPageUrl;
        if (videoListSubLink.value != null) {
          videoListScrolled.value = false;
        } else {
          videoListScrolled.value = true;
        }
        isVideoListLoading.value = false;
      } else {
        isVideoListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isVideoListLoading.value = true;
      ll('getImageAlbum error: $e');
    }
  }

  //* Profile view post data
  final Rx<ProfileViewPostModel?> profileViewPostData = Rx<ProfileViewPostModel?>(null);
  final RxList<PostDataRx> profileViewPostList = RxList<PostDataRx>([]);
  final RxBool isProfileViewPostLoading = RxBool(false);
  final Rx<String?> profileViewPostListSubLink = Rx<String?>(null);
  final RxBool profileViewPostListScrolled = RxBool(false);
  Future<void> getProfileViewPostList() async {
    try {
      isProfileViewPostLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/user-profile/${userName.value}/posts?take=10&category_id=${interestCatagoriesIndex.value}",
      ) as CommonDM;
      if (response.success == true) {
        profileViewPostList.clear();
        profileViewPostListScrolled.value = false;
        profileViewPostData.value = ProfileViewPostModel.fromJson(response.data);
        profileViewPostList.addAll(profileViewPostData.value!.posts!.data);
        profileViewPostListSubLink.value = profileViewPostData.value!.posts!.nextPageUrl;
        if (profileViewPostListSubLink.value != null) {
          profileViewPostListScrolled.value = false;
        } else {
          profileViewPostListScrolled.value = true;
        }
        isProfileViewPostLoading.value = false;
      } else {
        isProfileViewPostLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileViewPostLoading.value = true;

      ll('getProfileViewPostList error: $e');
    }
  }

  //!Kid Profile view api implement
  //* Profile overview API Implementation
  final RxString kidOrStorePageId = RxString("");
  Rx<ProfileViewKidOverviewModel?> userProfileViewKidData = Rx<ProfileViewKidOverviewModel?>(null);
  Rx<Kid?> kidProfileData = Rx<Kid?>(null);
  Rx<School?> kidProfileSchoolData = Rx<School?>(null);
  RxList<Contact?> kidProfileContactList = RxList<Contact?>([]);
  Future<void> getKidProfileOverview({required String kidPageId}) async {
    try {
      isUserProfileViewOverviewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/kid-profile/$kidPageId/overview",
      ) as CommonDM;
      if (response.success == true) {
        kidProfileContactList.clear();
        userProfileViewKidData.value = ProfileViewKidOverviewModel.fromJson(response.data);
        kidProfileData.value = userProfileViewKidData.value!.kid;
        kidProfileSchoolData.value = userProfileViewKidData.value!.school;
        kidProfileContactList.addAll(userProfileViewKidData.value!.contacts!);
        isUserProfileViewOverviewLoading.value = false;
      } else {
        isUserProfileViewOverviewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUserProfileViewOverviewLoading.value = true;
      ll('getKidProfileOverview error: $e');
    }
  }

  //* Profile view kid post data
  final Rx<ProfileViewKidPostModel?> profileViewKidPostData = Rx<ProfileViewKidPostModel?>(null);
  final RxList<PostDataRx> profileViewKidPostList = RxList<PostDataRx>([]);
  final Rx<String?> profileViewKidPostListSubLink = Rx<String?>(null);
  final RxBool profileViewKidPostListScrolled = RxBool(false);
  Future<void> getProfileViewKidPostList({required String kidPageId}) async {
    try {
      isProfileViewPostLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/kid-profile/$kidPageId/posts?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewKidPostList.clear();
        profileViewKidPostListScrolled.value = false;
        profileViewKidPostData.value = ProfileViewKidPostModel.fromJson(response.data);
        profileViewKidPostList.addAll(profileViewKidPostData.value!.posts!.data!);
        profileViewKidPostListSubLink.value = profileViewKidPostData.value!.posts!.nextPageUrl;
        if (profileViewKidPostListSubLink.value != null) {
          profileViewKidPostListScrolled.value = false;
        } else {
          profileViewKidPostListScrolled.value = true;
        }
        isProfileViewPostLoading.value = false;
      } else {
        isProfileViewPostLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileViewPostLoading.value = true;
      ll('getProfileViewKidPostList error: $e');
    }
  }

  //* Kid Image APi implement
  final Rx<ProfileViewImageModel?> profileViewKidImageData = Rx<ProfileViewImageModel?>(null);
  final RxList<ImageData> kidAllImageList = RxList<ImageData>([]);
  final Rx<String?> kidAllImageListSubLink = Rx<String?>(null);
  final RxBool kidAllImageListScrolled = RxBool(false);
  Future<void> getProfileViewKidAllImage({required String kidPageId}) async {
    try {
      isAllImageListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/kid-profile/$kidPageId/images?take=10",
      ) as CommonDM;
      if (response.success == true) {
        kidAllImageList.clear();
        kidAllImageListScrolled.value = false;
        profileViewKidImageData.value = ProfileViewImageModel.fromJson(response.data);
        kidAllImageList.addAll(profileViewKidImageData.value!.images!.data!);
        kidAllImageListSubLink.value = profileViewKidImageData.value!.images!.nextPageUrl;
        if (kidAllImageListSubLink.value != null) {
          kidAllImageListScrolled.value = false;
        } else {
          kidAllImageListScrolled.value = true;
        }
        isAllImageListLoading.value = false;
      } else {
        isAllImageListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAllImageListLoading.value = true;
      ll('getProfileViewKidAllImage error: $e');
    }
  }

  // //*Kid Image Album APi implement
  final Rx<ProfileViewImageAlbumModel?> profileViewKidImageAlbumData = Rx<ProfileViewImageAlbumModel?>(null);
  final RxList<ImageAlbumData> profileViewKidImageAlbumList = RxList<ImageAlbumData>([]);
  final Rx<String?> profileViewKidImageAlbumListSubLink = Rx<String?>(null);
  final RxBool profileViewKidImageAlbumListScrolled = RxBool(false);
  Future<void> getProfileViewKidImageAlbum({required String kidPageId}) async {
    try {
      isImageAlbumListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/kid-profile/$kidPageId/image-albums?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewKidImageAlbumList.clear();
        profileViewKidImageAlbumListScrolled.value = false;
        profileViewKidImageAlbumData.value = ProfileViewImageAlbumModel.fromJson(response.data);
        profileViewKidImageAlbumList.addAll(profileViewKidImageAlbumData.value!.imageAlbums!.data!);
        profileViewKidImageAlbumListSubLink.value = profileViewKidImageAlbumData.value!.imageAlbums!.nextPageUrl;
        if (profileViewKidImageAlbumListSubLink.value != null) {
          profileViewKidImageAlbumListScrolled.value = false;
        } else {
          profileViewKidImageAlbumListScrolled.value = true;
        }
        isImageAlbumListLoading.value = false;
      } else {
        isImageAlbumListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isImageAlbumListLoading.value = true;
      ll('getProfileViewKidImageAlbum error: $e');
    }
  }

  // //*Kid Video APi implement
  // final Rx<ProfileViewVideoModel?> videoData = Rx<ProfileViewVideoModel?>(null);
  // final RxList<VideoData> videoList = RxList<VideoData>([]);
  // final Rx<String?> videoListSubLink = Rx<String?>(null);
  // final RxBool videoListScrolled = RxBool(false);
  // final RxBool isVideoListLoading = RxBool(false);
  // Future<void> getVideos() async {
  //   try {
  //     isVideoListLoading.value = true;
  //     String? token = await spController.getBearerToken();
  //     var response = await apiController.commonApiCall(
  //       requestMethod: kGet,
  //       token: token,
  //       url: "/mobile/user/user-profile/${userName.value}/videos?take=20",
  //     ) as CommonDM;
  //     if (response.success == true) {
  //       videoList.clear();
  //       videoListScrolled.value = false;
  //       videoData.value = ProfileViewVideoModel.fromJson(response.data);
  //       videoList.addAll(videoData.value!.videos!.data!);
  //       videoListSubLink.value = videoData.value!.videos!.nextPageUrl;
  //       if (videoListSubLink.value != null) {
  //         videoListScrolled.value = false;
  //       } else {
  //         videoListScrolled.value = true;
  //       }
  //       isVideoListLoading.value = false;
  //     } else {
  //       isVideoListLoading.value = true;
  //       ErrorModel errorModel = ErrorModel.fromJson(response.data);
  //       if (errorModel.errors.isEmpty) {
  //         globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
  //       } else {
  //         globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
  //       }
  //     }
  //   } catch (e) {
  //     isVideoListLoading.value = true;
  //     ll('getImageAlbum error: $e');
  //   }
  // }

  //*Kid Award APi implement
  final Rx<ProfileViewAwardModel?> profileViewKidllAwardListData = Rx<ProfileViewAwardModel?>(null);
  final RxList<AllAwardData> profileViewKidAllAwardList = RxList<AllAwardData>([]);
  final Rx<String?> profileViewKidAwardListSubLink = Rx<String?>(null);
  final RxBool profileViewKidAwardListScrolled = RxBool(false);
  Future<void> getProfileViewKidAwardList({required String kidPageId}) async {
    try {
      isawardListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/kid-profile/$kidPageId/awards?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewKidAllAwardList.clear();
        profileViewKidAwardListScrolled.value = false;
        profileViewKidllAwardListData.value = ProfileViewAwardModel.fromJson(response.data);
        profileViewKidAllAwardList.addAll(profileViewKidllAwardListData.value!.awards!.data!);
        profileViewKidAwardListSubLink.value = profileViewKidllAwardListData.value!.awards!.nextPageUrl;
        if (profileViewKidAwardListSubLink.value != null) {
          profileViewKidAwardListScrolled.value = false;
        } else {
          profileViewKidAwardListScrolled.value = true;
        }
        isawardListLoading.value = false;
      } else {
        isawardListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isawardListLoading.value = true;
      ll('getProfileViewKidAwardList error: $e');
    }
  }

  //*Kid Video APi implement
  final Rx<ProfileViewVideoModel?> profileViewKidVideoData = Rx<ProfileViewVideoModel?>(null);
  final RxList<VideoData> profileViewKidVideoList = RxList<VideoData>([]);
  final Rx<String?> profileViewKidVideoListSubLink = Rx<String?>(null);
  final RxBool profileViewKidVideoListScrolled = RxBool(false);
  Future<void> getProfileViewKidVideos({required String kidPageId}) async {
    try {
      isVideoListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/kid-profile/$kidPageId/videos?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewKidVideoList.clear();
        profileViewKidVideoListScrolled.value = false;
        profileViewKidVideoData.value = ProfileViewVideoModel.fromJson(response.data);
        profileViewKidVideoList.addAll(profileViewKidVideoData.value!.videos!.data!);
        profileViewKidVideoListSubLink.value = profileViewKidVideoData.value!.videos!.nextPageUrl;
        if (profileViewKidVideoListSubLink.value != null) {
          profileViewKidVideoListScrolled.value = false;
        } else {
          profileViewKidVideoListScrolled.value = true;
        }
        isVideoListLoading.value = false;
      } else {
        isVideoListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isVideoListLoading.value = true;
      ll('getProfileViewKidVideos error: $e');
    }
  }

  //!Store Profile view api implement
  //* Profile overview API Implementation
  Rx<ProfileViewStoreOverviewModel?> profileViewStoreData = Rx<ProfileViewStoreOverviewModel?>(null);
  Rx<Store?> storeProfileData = Rx<Store?>(null);
  RxList<Contact?> storeProfileContactList = RxList<Contact?>([]);
  Future<void> getProfileViewStoreOverview({required String storePageId}) async {
    try {
      isUserProfileViewOverviewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/store-profile/$storePageId/overview",
      ) as CommonDM;
      if (response.success == true) {
        storeProfileContactList.clear();
        profileViewStoreData.value = ProfileViewStoreOverviewModel.fromJson(response.data);
        storeProfileData.value = profileViewStoreData.value!.store;
        storeProfileContactList.addAll(profileViewStoreData.value!.contacts!);
        isUserProfileViewOverviewLoading.value = false;
      } else {
        isUserProfileViewOverviewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUserProfileViewOverviewLoading.value = true;
      ll('getKidProfileOverview error: $e');
    }
  }

  //* Profile view kid post data
  final Rx<ProfileViewKidPostModel?> profileViewStorePostData = Rx<ProfileViewKidPostModel?>(null);
  final RxList<PostDataRx> profileViewStorePostList = RxList<PostDataRx>([]);
  final Rx<String?> profileViewStorePostListSubLink = Rx<String?>(null);
  final RxBool profileViewStorePostListScrolled = RxBool(false);
  Future<void> getProfileViewStorePostList({required String storePageId}) async {
    try {
      isProfileViewPostLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/store-profile/$storePageId/posts?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewStorePostList.clear();
        profileViewStorePostListScrolled.value = false;
        profileViewStorePostData.value = ProfileViewKidPostModel.fromJson(response.data);
        profileViewStorePostList.addAll(profileViewStorePostData.value!.posts!.data!);
        profileViewStorePostListSubLink.value = profileViewStorePostData.value!.posts!.nextPageUrl;
        if (profileViewStorePostListSubLink.value != null) {
          profileViewStorePostListScrolled.value = false;
        } else {
          profileViewStorePostListScrolled.value = true;
        }
        isProfileViewPostLoading.value = false;
      } else {
        isProfileViewPostLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileViewPostLoading.value = true;
      ll('getProfileViewStorePostList error: $e');
    }
  }

  //* Kid Image APi implement
  final Rx<ProfileViewImageModel?> profileViewStoreImageData = Rx<ProfileViewImageModel?>(null);
  final RxList<ImageData> storeAllImageList = RxList<ImageData>([]);
  final Rx<String?> storeAllImageListSubLink = Rx<String?>(null);
  final RxBool storeAllImageListScrolled = RxBool(false);
  Future<void> getProfileViewStoreAllImage({required String storePageId}) async {
    try {
      isAllImageListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/store-profile/$storePageId/images?take=10",
      ) as CommonDM;
      if (response.success == true) {
        storeAllImageList.clear();
        storeAllImageListScrolled.value = false;
        profileViewStoreImageData.value = ProfileViewImageModel.fromJson(response.data);
        storeAllImageList.addAll(profileViewStoreImageData.value!.images!.data!);
        storeAllImageListSubLink.value = profileViewStoreImageData.value!.images!.nextPageUrl;
        if (storeAllImageListSubLink.value != null) {
          storeAllImageListScrolled.value = false;
        } else {
          storeAllImageListScrolled.value = true;
        }
        isAllImageListLoading.value = false;
      } else {
        isAllImageListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAllImageListLoading.value = true;
      ll('getProfileViewStoreAllImage error: $e');
    }
  }

  // //*Kid Image Album APi implement
  final Rx<ProfileViewImageAlbumModel?> profileViewStoreImageAlbumData = Rx<ProfileViewImageAlbumModel?>(null);
  final RxList<ImageAlbumData> profileViewStoreImageAlbumList = RxList<ImageAlbumData>([]);
  final Rx<String?> profileViewStoreImageAlbumListSubLink = Rx<String?>(null);
  final RxBool profileViewStoreImageAlbumListScrolled = RxBool(false);
  Future<void> getProfileViewStoreImageAlbum({required String storePageId}) async {
    try {
      isImageAlbumListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/store-profile/$storePageId/image-albums?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewStoreImageAlbumList.clear();
        profileViewStoreImageAlbumListScrolled.value = false;
        profileViewStoreImageAlbumData.value = ProfileViewImageAlbumModel.fromJson(response.data);
        profileViewStoreImageAlbumList.addAll(profileViewStoreImageAlbumData.value!.imageAlbums!.data!);
        profileViewStoreImageAlbumListSubLink.value = profileViewStoreImageAlbumData.value!.imageAlbums!.nextPageUrl;
        if (profileViewStoreImageAlbumListSubLink.value != null) {
          profileViewStoreImageAlbumListScrolled.value = false;
        } else {
          profileViewStoreImageAlbumListScrolled.value = true;
        }
        isImageAlbumListLoading.value = false;
      } else {
        isImageAlbumListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isImageAlbumListLoading.value = true;
      ll('getProfileViewStoreImageAlbum error: $e');
    }
  }

  //*Store Video APi implement
  final Rx<ProfileViewVideoModel?> profileViewStoreVideoData = Rx<ProfileViewVideoModel?>(null);
  final RxList<VideoData> profileViewStoreVideoList = RxList<VideoData>([]);
  final Rx<String?> profileViewStoreVideoListSubLink = Rx<String?>(null);
  final RxBool profileViewStoreVideoListScrolled = RxBool(false);
  Future<void> getProfileViewStoreVideos({required String storePageId}) async {
    try {
      isVideoListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/store-profile/$storePageId/videos?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewStoreVideoList.clear();
        profileViewStoreVideoListScrolled.value = false;
        profileViewStoreVideoData.value = ProfileViewVideoModel.fromJson(response.data);
        profileViewStoreVideoList.addAll(profileViewStoreVideoData.value!.videos!.data!);
        profileViewStoreVideoListSubLink.value = profileViewStoreVideoData.value!.videos!.nextPageUrl;
        if (profileViewStoreVideoListSubLink.value != null) {
          profileViewStoreVideoListScrolled.value = false;
        } else {
          profileViewStoreVideoListScrolled.value = true;
        }
        isVideoListLoading.value = false;
      } else {
        isVideoListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isVideoListLoading.value = true;
      ll('getProfileViewStoreVideos error: $e');
    }
  }

  //*Store Video APi implement
  final Rx<ProfileViewStoreReviewModel?> profileViewStoreReviewData = Rx<ProfileViewStoreReviewModel?>(null);
  final RxList<ReviewData> profileViewStoreReviewList = RxList<ReviewData>([]);
  final Rx<String?> profileViewStoreReviewListSubLink = Rx<String?>(null);
  final RxBool profileViewStoreReviewListScrolled = RxBool(false);
  final RxBool isStoreReviewLoading = RxBool(false);
  Future<void> getProfileViewStoreReview({required String storePageId}) async {
    try {
      isStoreReviewLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "/mobile/user/store-profile/$storePageId/reviews?take=10",
      ) as CommonDM;
      if (response.success == true) {
        profileViewStoreReviewList.clear();
        profileViewStoreReviewListScrolled.value = false;
        profileViewStoreReviewData.value = ProfileViewStoreReviewModel.fromJson(response.data);
        profileViewStoreReviewList.addAll(profileViewStoreReviewData.value!.reviews!.data!);
        profileViewStoreReviewListSubLink.value = profileViewStoreReviewData.value!.reviews!.nextPageUrl;
        if (profileViewStoreReviewListSubLink.value != null) {
          profileViewStoreReviewListScrolled.value = false;
        } else {
          profileViewStoreReviewListScrolled.value = true;
        }
        isStoreReviewLoading.value = false;
      } else {
        isStoreReviewLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isStoreReviewLoading.value = true;
      ll('getProfileViewStoreReview error: $e');
    }
  }

  //* Education Section
  String workEducationSubTitleText(DateTime? startDate, dynamic endDate) {
    if (startDate != null && endDate != null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)}- $endDate';
    } else if (startDate == null && endDate != null) {
      return DateFormat("dd MMMM, yyyy").format(endDate);
    } else if (startDate != null && endDate == null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} - present';
    } else {
      return "";
    }
  }

  String? schoolSubtitleText(DateTime? startDate, DateTime? endDate) {
    if (startDate != null && endDate != null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} - ${DateFormat("dd MMMM, yyyy").format(endDate)}';
    } else if (startDate == null && endDate != null) {
      return 'School year ${endDate.year}';
    } else if (startDate != null && endDate == null) {
      return '${DateFormat("dd MMMM, yyyy").format(startDate)} to present';
    } else {
      return "";
    }
  }

  final TextEditingController followerSearchController = TextEditingController();
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
