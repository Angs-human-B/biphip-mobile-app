import 'package:bip_hip/models/search/search_filter_data_model.dart';
import 'package:bip_hip/models/search/search_history_model.dart';
import 'package:bip_hip/models/search/search_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:video_player/video_player.dart';

class AllSearchController extends GetxController {
  
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final TextEditingController searchTextEditingController = TextEditingController();
  final RxBool isSearchSuffixIconVisible = RxBool(false);
  final RxString searchedValue = RxString("");
  final RxString searchPeopleProfilePicture = RxString("");
  final RxBool isSearched = RxBool(false);
  final RxInt selectedFilterIndex = RxInt(-1);
  final RxString selectedFilterValue = RxString("");
  final RxBool isFilterSelected = RxBool(false);
  final RxBool isRecentPostCheckBoxSelected = RxBool(false);
  final RxString temporarySelectedPostedBy = RxString("");
  final RxString selectedPostedBy = RxString("");
  final RxBool isPostedByBottomSheetState = RxBool(false);
  final RxString temporarySelectedDatePosted = RxString("");
  final RxString selectedDatePosted = RxString("");
  final RxBool isDatePostedBottomSheetState = RxBool(false);
  final RxString temporarySelectedCategory = RxString("");
  final RxString selectedCategory = RxString("");
  final RxInt temporarySelectedCategoryId = RxInt(-1);
  final RxInt selectedCategoryId = RxInt(-1);
  final RxBool isCategoryBottomSheetState = RxBool(false);
  final RxString temporarySelectedSellPostType = RxString("");
  final RxString selectedSellPostType = RxString("");
  final RxInt temporarySelectedSellPostTypeIndex = RxInt(-1);
  final RxInt selectedSellPostTypeIndex = RxInt(-1);
  final RxBool isSellPostTypeBottomSheetState = RxBool(false);
  final RxString temporarySelectedSellPostCondition = RxString("");
  final RxString selectedSellPostCondition = RxString("");
  final RxInt temporarySelectedSellPostConditionId = RxInt(-1);
  final RxInt selectedSellPostConditionId = RxInt(-1);
  final RxBool isSellPostConditionBottomSheetState = RxBool(false);
  final RxString temporarySelectedSellPostProductCategory = RxString("");
  final RxString selectedSellPostProductCategory = RxString("");
  final RxInt temporarySelectedSellPostProductCategoryId = RxInt(-1);
  final RxInt selectedSellPostProductCategoryId = RxInt(-1);
  final RxBool isSellPostProductConditionBottomSheetState = RxBool(false);
  final RxString temporarySelectedSubCategory = RxString("");
  final RxString selectedSubCategory = RxString("");
  final RxBool isSubCategoryBottomSheetState = RxBool(false);
  final RxBool isPostsBottomSheetResetOrShowResult = RxBool(false);
  final RxBool isPhotosVideosBottomSheetResetOrShowResult = RxBool(false);
  final RxBool isKidsNewsBottomSheetResetOrShowResult = RxBool(false);
  final RxBool isSellPostBottomSheetResetOrShowResult = RxBool(false);

  void resetKidsNewsBottomSheetData() {
    selectedSubCategory.value = "";
    selectedDatePosted.value = "";
    selectedPostedBy.value = "";
    isKidsNewsBottomSheetResetOrShowResult.value = false;
  }

  void resetPhotosVideosBottomSheetData() {
    selectedPostedBy.value = "";
    selectedDatePosted.value = "";
    isPhotosVideosBottomSheetResetOrShowResult.value = false;
  }

  void resetPostsBottomSheetData() {
    isRecentPostCheckBoxSelected.value = false;
    selectedPostedBy.value = "";
    selectedDatePosted.value = "";
    selectedCategory.value = "";
    isPostsBottomSheetResetOrShowResult.value = false;
  }

  void resetSellPostBottomSheetData() {
    selectedSellPostType.value = "";
    selectedSellPostCondition.value = "";
    selectedPostedBy.value = "";
    selectedSellPostProductCategory.value = "";
    isSellPostBottomSheetResetOrShowResult.value = false;
  }

  void kidsNewsBottomSheetState() {
    if (selectedSubCategory.value != "" || selectedDatePosted.value != "" || selectedPostedBy.value != "") {
      isKidsNewsBottomSheetResetOrShowResult.value = true;
    } else {
      isKidsNewsBottomSheetResetOrShowResult.value = false;
    }
  }

  void photosVideosBottomSheetState() {
    if (selectedPostedBy.value != "" || selectedDatePosted.value != "") {
      isPhotosVideosBottomSheetResetOrShowResult.value = true;
    } else {
      isPhotosVideosBottomSheetResetOrShowResult.value = false;
    }
  }

  void postsBottomSheetState() {
    if (isRecentPostCheckBoxSelected.value || selectedPostedBy.value != "" || selectedDatePosted.value != "" || selectedCategory.value != "") {
      isPostsBottomSheetResetOrShowResult.value = true;
    } else {
      isPostsBottomSheetResetOrShowResult.value = false;
    }
  }

  void sellPostBottomSheetState() {
    if (selectedSellPostType.value != "" ||
        selectedSellPostCondition.value != "" ||
        selectedPostedBy.value != "" ||
        selectedSellPostProductCategory.value != "") {
      isSellPostBottomSheetResetOrShowResult.value = true;
    } else {
      isSellPostBottomSheetResetOrShowResult.value = false;
    }
  }
  void resetSearchData() {
    searchTextEditingController.clear();
    isSearchSuffixIconVisible.value = false;
    isSearched.value = false;
    selectedFilterIndex.value = -1;
    selectedFilterValue.value = "";
  }

  void resetBottomSheetData() {
    temporarySelectedPostedBy.value = "";
    selectedPostedBy.value = "";
    isPostedByBottomSheetState.value = false;
    temporarySelectedDatePosted.value = "";
    selectedDatePosted.value = "";
    isDatePostedBottomSheetState.value = false;
    temporarySelectedCategory.value = "";
    selectedCategory.value = "";
    isCategoryBottomSheetState.value = false;
    temporarySelectedSubCategory.value = "";
    selectedSubCategory.value = "";
    isSubCategoryBottomSheetState.value = false;
    temporarySelectedSellPostType.value = "";
    selectedSellPostType.value = "";
    temporarySelectedSellPostTypeIndex.value = -1;
    selectedSellPostTypeIndex.value = -1;
    isSellPostTypeBottomSheetState.value = false;
    temporarySelectedSellPostCondition.value = "";
    selectedSellPostCondition.value = "";
    isSellPostConditionBottomSheetState.value = false;
    temporarySelectedSellPostProductCategory.value = "";
    selectedSellPostProductCategory.value = "";
    isSellPostProductConditionBottomSheetState.value = false;
    isPostsBottomSheetResetOrShowResult.value = false;
    isPhotosVideosBottomSheetResetOrShowResult.value = false;
    isKidsNewsBottomSheetResetOrShowResult.value = false;
    isSellPostBottomSheetResetOrShowResult.value = false;
    isRecentPostCheckBoxSelected.value = false;
    temporarySelectedSellPostProductCategoryId.value = -1;
    selectedSellPostProductCategoryId.value = -1;
    temporarySelectedCategoryId.value = -1;
    selectedCategoryId.value = -1;
    temporarySelectedSellPostConditionId.value = -1;
    selectedSellPostConditionId.value = -1;
  }

  //! Search Api implement
  //   //*Search History List Api Call
  final Rx<SearchHistoryModel?> searchHistoryData = Rx<SearchHistoryModel?>(null);
  final RxList<SearchHistoryListData> searchHistoryList = RxList<SearchHistoryListData>([]);
  final RxBool isSearchHistoryLoading = RxBool(false);
  Future<void> getSearchHistory() async {
    try {
      isSearchHistoryLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuSearchHistory,
      ) as CommonDM;
      if (response.success == true) {
        searchHistoryList.clear();
        searchHistoryData.value = SearchHistoryModel.fromJson(response.data);
        searchHistoryList.addAll(searchHistoryData.value!.searchHistories!.data);
        isSearchHistoryLoading.value = false;
      } else {
        isSearchHistoryLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSearchHistoryLoading.value = true;
      ll('getSearchHistory error: $e');
    }
  }

  //*Delete Search history Api Call
  final RxBool isDeleteSearchHistory = RxBool(false);
  Future<void> deleteSearchHistory({required int id}) async {
    try {
      isDeleteSearchHistory.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteSearchHistory/${id.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int i = 0; i < searchHistoryList.length; i++) {
          if (searchHistoryList[i].id == id) {
            searchHistoryList.removeAt(i);
          }
        }
        isDeleteSearchHistory.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isDeleteSearchHistory.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isDeleteSearchHistory.value = false;
      ll('deleteSearchHistory error: $e');
    }
  }

  //*Delete All Search history Api Call
  final RxBool isDeleteAllSearchHistory = RxBool(false);
  Future<void> deleteAllSearchHistory() async {
    try {
      isDeleteAllSearchHistory.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: kuDeleteAllSearchHistory,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        searchHistoryList.clear();
        isDeleteAllSearchHistory.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isDeleteAllSearchHistory.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isDeleteAllSearchHistory.value = false;
      ll('deleteAllSearchHistory error: $e');
    }
  }

  //   //*Search Filter data Api Call
  final RxList filterTypeList = RxList([]);
  final Rx<SearchFilterDataModel?> searchFilterData = Rx<SearchFilterDataModel?>(null);
  final Rx<All?> allFilterData = Rx<All?>(null);
  final Rx<AllPosts?> postsFilterData = Rx<AllPosts?>(null);
  final Rx<People?> peopleFilterData = Rx<People?>(null);
  final Rx<People?> photoFilterData = Rx<People?>(null);
  final Rx<People?> videoFilterData = Rx<People?>(null);
  final Rx<SellPost?> sellPostFilterData = Rx<SellPost?>(null);
  final Rx<Kids?> kidsFilterData = Rx<Kids?>(null);
  final Rx<Kids?> newsFilterData = Rx<Kids?>(null);
  final RxList<All> postedByList = RxList<All>([]);
  final RxList<PostedDate> datePostedList = RxList<PostedDate>([]);
  final RxBool isSearchFilterDataLoading = RxBool(false);
  Future<void> getSearchFilterData() async {
    try {
      isSearchFilterDataLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuSearchFilterData,
      ) as CommonDM;
      if (response.success == true) {
        filterTypeList.clear();
        postedByList.clear();
        datePostedList.clear();
        searchFilterData.value = SearchFilterDataModel.fromJson(response.data);
        allFilterData.value = searchFilterData.value?.all;
        postsFilterData.value = searchFilterData.value!.allPosts;
        peopleFilterData.value = searchFilterData.value?.people;
        photoFilterData.value = searchFilterData.value?.photo;
        videoFilterData.value = searchFilterData.value?.video;
        sellPostFilterData.value = searchFilterData.value?.sellPost;
        kidsFilterData.value = searchFilterData.value?.kids;
        newsFilterData.value = searchFilterData.value?.news;
        postedByList.addAll(searchFilterData.value!.allPosts!.postedBy);
        datePostedList.addAll(searchFilterData.value!.allPosts!.postedDate);
        //*filter list
        filterTypeList.add(searchFilterData.value?.all?.value);
        filterTypeList.add(searchFilterData.value?.allPosts?.value);
        filterTypeList.add(searchFilterData.value?.people?.value);
        filterTypeList.add(searchFilterData.value?.photo?.value);
        filterTypeList.add(searchFilterData.value?.video?.value);
        filterTypeList.add(searchFilterData.value?.sellPost?.value);
        filterTypeList.add(searchFilterData.value?.kids?.value);
        filterTypeList.add(searchFilterData.value?.news?.value);
        isSearchFilterDataLoading.value = false;
      } else {
        isSearchFilterDataLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSearchFilterDataLoading.value = true;
      ll('getSearchFilterData error: $e');
    }
  }

  //! Search Api implement
  //   //*Search History List Api Call
  final Rx<SearchModel?> searchData = Rx<SearchModel?>(null);
  final Rx<Users?> userData = Rx<Users?>(null);
  final Rx<Posts?> postData = Rx<Posts?>(null);
  final Rx<Photos?> photosData = Rx<Photos?>(null);
  final Rx<Photos?> videosData = Rx<Photos?>(null);
  final Rx<Posts?> sellPostsData = Rx<Posts?>(null);
  final Rx<Posts?> kidPostsData = Rx<Posts?>(null);
  final Rx<Posts?> newsPostsData = Rx<Posts?>(null);
  final RxList<UserElement> userList = RxList<UserElement>([]);
  final RxList<PostsData> postsList = RxList<PostsData>([]);
  final RxList<PhotosData> photosList = RxList<PhotosData>([]);
  final RxList<PhotosData> videosList = RxList<PhotosData>([]);
  final RxList<PostsData> sellPostList = RxList<PostsData>([]);
  final RxList<PostsData> kidPostList = RxList<PostsData>([]);
  final RxList<PostsData> newsPostList = RxList<PostsData>([]);
  final RxBool isSearchLoading = RxBool(false);
  Future<void> getSearch() async {
    try {
      isSearchLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: getUrlLink(),
      ) as CommonDM;
      if (response.success == true) {
        searchData.value = SearchModel.fromJson(response.data);
        if (selectedFilterValue.value.toString() == "People") {
          userList.clear();
        } else if (selectedFilterValue.value.toString() == "Post") {
          postsList.clear();
        } else if (selectedFilterValue.value.toString() == "Photos") {
          photosList.clear();
        } else if (selectedFilterValue.value.toString() == "Videos") {
          videosList.clear();
        } else if (selectedFilterValue.value.toString() == "Kids") {
          kidPostList.clear();
        } else if (selectedFilterValue.value.toString() == "News") {
          newsPostList.clear();
        } 
      else if (selectedFilterValue.value.toString().toLowerCase() == "Sell Posts".toLowerCase()) {
          sellPostList.clear();
        }
        else {
          userList.clear();
          postsList.clear();
          photosList.clear();
          videosList.clear();
          sellPostList.clear();
          kidPostList.clear();
          newsPostList.clear();
        }
        userData.value = searchData.value?.users;
        postData.value = searchData.value?.posts;
        photosData.value = searchData.value?.photos;
        videosData.value = searchData.value?.videos;
        sellPostsData.value = searchData.value?.sellposts;
        kidPostsData.value = searchData.value?.kidposts;
        newsPostsData.value = searchData.value?.newsposts;
        if (selectedFilterValue.value.toString() == "People") {
          userList.addAll(searchData.value!.users!.data);
        } else if (selectedFilterValue.value.toString() == "Post") {
          postsList.addAll(searchData.value!.posts!.data);
        } else if (selectedFilterValue.value.toString() == "Photos") {
          photosList.addAll(searchData.value!.photos!.data);
        } else if (selectedFilterValue.value.toString() == "Videos") {
          videosList.addAll(searchData.value!.videos!.data);
        } else if (selectedFilterValue.value.toString() == "Kids") {
          kidPostList.addAll(searchData.value!.kidposts!.data);
        } else if (selectedFilterValue.value.toString() == "News") {
          newsPostList.addAll(searchData.value!.newsposts!.data);
        }
        else if (selectedFilterValue.value.toString().toLowerCase() == "Sell Posts".toLowerCase()) {
          sellPostList.addAll(searchData.value!.sellposts!.data);
        }
         else {
          userList.addAll(searchData.value!.users!.data);
          postsList.addAll(searchData.value!.posts!.data);
          photosList.addAll(searchData.value!.photos!.data);
          videosList.addAll(searchData.value!.videos!.data);
          sellPostList.addAll(searchData.value!.sellposts!.data);
          kidPostList.addAll(searchData.value!.kidposts!.data);
          newsPostList.addAll(searchData.value!.newsposts!.data);
        }
        await getSearchHistory();
        isSearchLoading.value = false;
      } else {
        isSearchLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSearchLoading.value = true;
      ll('getSearch error: $e');
    }
  }

  String getUrlLink() {
    //  "$kuSearch?type=${selectedFilterValue.value.toString().toLowerCase()}&keywords=${searchTextEditingController.text.toString().trim()}&recent_post=${isRecentPostCheckBoxSelected.value.toString()}&posted_by=${selectedPostedBy.value.toString()}&posted_date=${selectedDatePosted.value.toString()}&sell_post_type=${selectedSellPostTypeIndex.value.toString()}&take=20",
    String finalLink = "$kuSearch?type=${selectedFilterValue.value.toString().toLowerCase()}&keywords=${searchTextEditingController.text.toString()}&take=20";
    if (selectedFilterValue.value.toString() == "All") {
      finalLink = "$kuSearch?type=${selectedFilterValue.value.toString().toLowerCase()}&keywords=${searchTextEditingController.text.toString()}&take=20";
      return finalLink;
    } else if (selectedFilterValue.value.toString() == "Post") {
      finalLink =
          "$kuSearch?type=posts&keywords=${searchTextEditingController.text.toString()}&recent_post=${isRecentPostCheckBoxSelected.value.toString()}&take=20";
      if (selectedPostedBy.value.toString() != "") {
        finalLink += "&posted_by=${selectedPostedBy.value.toString()}";
      }
      if (selectedDatePosted.value.toString() != "") {
        finalLink += "&posted_date=${selectedDatePosted.value.toString()}";
      }
      if (selectedCategory.value.toString() != "") {
        finalLink += "&category_by=${selectedCategoryId.value.toString()}";
      }
      return finalLink;
    } else if (selectedFilterValue.value.toString() == "People") {
      // finalLink = "$kuSearch?type=${selectedFilterValue.value.toString().toLowerCase()}&keywords=${searchTextEditingController.text.toString()}&take=20";
      if (selectedPostedBy.value.toString() != "") {
        int peopleTypeValue = -1;
        if (selectedPostedBy.value.toString().toLowerCase() == "all") {
          peopleTypeValue = 0;
        } else if (selectedPostedBy.value.toString().toLowerCase() == "friend") {
          peopleTypeValue = 1;
        } else if (selectedPostedBy.value.toString().toLowerCase() == "family") {
          peopleTypeValue = 2;
        } else if (selectedPostedBy.value.toString().toLowerCase() == "Friend & family".toLowerCase()) {
          peopleTypeValue = 3;
        }
        finalLink += "&people_type=${peopleTypeValue.toString()}";
      }
      return finalLink;
    } else if (selectedFilterValue.value.toString() == "Photos" || selectedFilterValue.value.toString() == "Videos") {
      if (selectedPostedBy.value.toString() != "") {
        finalLink += "&posted_by=${selectedPostedBy.value.toString()}";
      }
      if (selectedDatePosted.value.toString() != "") {
        finalLink += "&posted_date=${selectedDatePosted.value.toString()}";
      }
      return finalLink;
    } else if (selectedFilterValue.value.toString() == "Kids" || selectedFilterValue.value.toString() == "News") {
      if (selectedPostedBy.value.toString() != "") {
        finalLink += "&posted_by=${selectedPostedBy.value.toString()}";
      }
      if (selectedDatePosted.value.toString() != "") {
        finalLink += "&posted_date=${selectedDatePosted.value.toString()}";
      }
      return finalLink;
    } else {
      if (selectedSellPostProductCategory.value.toString() != "") {
        finalLink += "&sell_post_category=${selectedSellPostProductCategoryId.value.toString()}";
      }
      if (selectedSellPostType.value.toString() != "") {
        finalLink += "&sell_post_type=${selectedSellPostTypeIndex.value.toString()}";
      }
      if (selectedSellPostCondition.value.toString() != "") {
        finalLink += "&sell_post_condition=${selectedSellPostConditionId.value.toString()}";
      }
      return finalLink;
    }
  }

  late VideoPlayerController videoPlayerController;
  late Future<void> initializedVideoPlayerFuture;
    final RxString videoUrl = RxString("");
    void customOnInit() {
    videoPlayerController = VideoPlayerController.network(videoUrl.value);
    initializedVideoPlayerFuture = videoPlayerController.initialize().then((value) {
      videoPlayerController.play();
      videoPlayerController.setLooping(false);
    });
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
