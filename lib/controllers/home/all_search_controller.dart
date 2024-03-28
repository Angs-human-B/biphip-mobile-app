import 'package:bip_hip/models/search/search_filter_data_model.dart';
import 'package:bip_hip/models/search/search_history_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

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
  // final RxList postedByList = RxList([
  //   {"icon": BipHip.world, "type": "Anyone"},
  //   {"icon": BipHip.friends, "type": "Friend"},
  //   {"icon": BipHip.addFamily, "type": "Family"},
  //   {"icon": BipHip.friends, "type": "Friends & Family"},
  // ]);
  final RxString temporarySelectedPostedBy = RxString("");
  final RxString selectedPostedBy = RxString("");
  final RxBool isPostedByBottomSheetState = RxBool(false);
  final RxString temporarySelectedDatePosted = RxString("");
  final RxString selectedDatePosted = RxString("");
  final RxBool isDatePostedBottomSheetState = RxBool(false);
  final RxString temporarySelectedCategory = RxString("");
  final RxString selectedCategory = RxString("");
  final RxBool isCategoryBottomSheetState = RxBool(false);
  final RxString temporarySelectedSellPostType = RxString("");
  final RxString selectedSellPostType = RxString("");
  final RxInt temporarySelectedSellPostTypeIndex = RxInt(-1);
  final RxInt selectedSellPostTypeIndex = RxInt(-1);
  final RxBool isSellPostTypeBottomSheetState = RxBool(false);
  final RxString temporarySelectedSellPostCondition = RxString("");
  final RxString selectedSellPostCondition = RxString("");
  final RxBool isSellPostConditionBottomSheetState = RxBool(false);
  final RxString temporarySelectedSellPostProductCategory = RxString("");
  final RxString selectedSellPostProductCategory = RxString("");
  final RxBool isSellPostProductConditionBottomSheetState = RxBool(false);
  final RxString temporarySelectedSubCategory = RxString("");
  final RxString selectedSubCategory = RxString("");
  final RxBool isSubCategoryBottomSheetState = RxBool(false);
  final RxBool isPostsBottomSheetResetOrShowResult = RxBool(false);
  final RxBool isPhotosVideosBottomSheetResetOrShowResult = RxBool(false);
  final RxBool isKidsNewsBottomSheetResetOrShowResult = RxBool(false);
  final RxBool isSellPostBottomSheetResetOrShowResult = RxBool(false);
  // void resetBottomSheetAllData() {
  //   //*kids News
  //   selectedSubCategory.value = "";
  //   selectedDatePosted.value = "";
  //   selectedPostedBy.value = "";
  //   isKidsNewsBottomSheetResetOrShowResult.value = false;
  //   //*Photos, Videos
  //   selectedPostedBy.value = "";
  //   selectedDatePosted.value = "";
  //   isPhotosVideosBottomSheetResetOrShowResult.value = false;
  //   //*Posts
  //   isRecentPostCheckBoxSelected.value = false;
  //   selectedPostedBy.value = "";
  //   selectedDatePosted.value = "";
  //   selectedCategory.value = "";
  //   isPostsBottomSheetResetOrShowResult.value = false;
  //   //* Sell Posts
  //   selectedSellPostType.value = "";
  //   selectedSellPostCondition.value = "";
  //   selectedPostedBy.value = "";
  //   selectedSellPostProductCategory.value = "";
  //   isSellPostBottomSheetResetOrShowResult.value = false;
  // }
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

  // final List subCategoryList = ["Kids subcategory", "News subcategory", "International News", "Sports News"];
  // final List productCategoryList = ["Any", "Gadgets", "Fashion", "Electronics", "Phone", "Laptop"];
  // final List conditionList = ["Any", "New", "used", "Used Like New", "Used Like Poor", "Like New"];
  // final RxList recentSearchList = RxList([
  //   {
  //     "name": "Wahid Murad",
  //     "image":
  //         "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  //   },
  //   {
  //     "name": "Wahid",
  //     "image":
  //         "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  //   },
  //   {
  //     "name": "Murad",
  //     "image":
  //         "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  //   },
  //   {
  //     "name": "User",
  //     "image":
  //         "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  //   },
  //   {
  //     "name": "New User",
  //     "image":
  //         "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  //   },
  //   {
  //     "name": "Test User",
  //     "image":
  //         "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  //   },
  // ]);
  // final RxList datePostedList = RxList([
  //   {"date": "AnyDate"},
  //   {"date": "2024"},
  //   {"date": "2023"},
  //   {"date": "2022"},
  //   {"date": "2021"},
  //   {"date": "2020"},
  //   {"date": "2019"},
  //   {"date": "2018"},
  //   {"date": "2017"},
  //   {"date": "2016"},
  //   {"date": "2015"},
  //   {"date": "2014"},
  // ]);

  // final RxList categoryList = RxList([
  //   "Any Category",
  //   "Poetry",
  //   "Painting",
  //   "Kids",
  //   "Storytelling",
  //   "Photography",
  //   "News",
  // ]);
  final RxList userList = RxList([
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "1",
      "mutualFriend": "1 mutual friend",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "1"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "0"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "0"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "0"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "0"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "0",
      "mutualFriend": "2 mutual friend",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "name": "Wahid Murad",
      "isFriend": "0",
      "mutualFriend": "1 mutual friend",
    },
  ]);
  final List imageList = [
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
  ];
  final List videosList = [
    {
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Behavior in a wild fox a wild fox",
      "name": "Wahid Murad",
      "date": "8 Feb, 2023",
      "totalView": "40.06k views",
      "time": "00:12",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=257x4&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Behavior in a wild fox a wild fox",
      "name": "Wahid Murad",
      "date": "8 Feb, 2023",
      "totalView": "40.06k views",
      "time": "00:12",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Behavior in a wild fox a wild fox",
      "name": "Wahid Murad",
      "date": "8 Feb, 2023",
      "totalView": "40.06k views",
      "time": "00:12",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Behavior in a wild fox a wild fox",
      "name": "Wahid Murad",
      "date": "8 Feb, 2023",
      "totalView": "40.06k views",
      "time": "00:12",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Behavior in a wild fox a wild fox",
      "name": "Wahid Murad",
      "date": "8 Feb, 2023",
      "totalView": "40.06k views",
      "time": "00:12",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Behavior in a wild fox a wild fox",
      "name": "Wahid Murad",
      "date": "8 Feb, 2023",
      "totalView": "40.06k views",
      "time": "00:12",
    },
  ];
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
  final Rx<All?> allData = Rx<All?>(null);
  final Rx<Posts?> postsData = Rx<Posts?>(null);
  final Rx<People?> peopleData = Rx<People?>(null);
  final Rx<People?> photoData = Rx<People?>(null);
  final Rx<People?> videoData = Rx<People?>(null);
  final Rx<SellPost?> sellPostData = Rx<SellPost?>(null);
  final Rx<Kids?> kidsData = Rx<Kids?>(null);
  final Rx<Kids?> newsData = Rx<Kids?>(null);
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
        allData.value = searchFilterData.value?.all;
        postsData.value = searchFilterData.value?.posts;
        peopleData.value = searchFilterData.value?.people;
        photoData.value = searchFilterData.value?.photo;
        videoData.value = searchFilterData.value?.video;
        sellPostData.value = searchFilterData.value?.sellPost;
        kidsData.value = searchFilterData.value?.kids;
        newsData.value = searchFilterData.value?.news;
        postedByList.addAll(searchFilterData.value!.posts!.postedBy);
        datePostedList.addAll(searchFilterData.value!.posts!.postedDate);
        //*filter list
        filterTypeList.add(searchFilterData.value?.all?.value);
        filterTypeList.add(searchFilterData.value?.posts?.value);
        filterTypeList.add(searchFilterData.value?.people?.value);
        filterTypeList.add(searchFilterData.value?.photo?.value);
        filterTypeList.add(searchFilterData.value?.video?.value);
        filterTypeList.add(searchFilterData.value?.sellPost?.value);
        filterTypeList.add(searchFilterData.value?.kids?.value);
        filterTypeList.add(searchFilterData.value?.news?.value);
        // ll();
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
}
