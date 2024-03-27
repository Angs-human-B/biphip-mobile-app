import 'package:bip_hip/utils/constants/imports.dart';

class AllSearchController extends GetxController {
  final TextEditingController searchTextEditingController = TextEditingController();
  final RxBool isSearchSuffixIconVisible = RxBool(false);
  final RxString searchedValue = RxString("");
  final RxString searchPeopleProfilePicture = RxString("");
  final RxBool isSearched = RxBool(false);
  final List filterTypeList = ["All", "Posts", "People", "Photos", "Videos", "Sell Posts", "Kids", "News"];
  final RxInt selectedFilterIndex = RxInt(-1);
  final RxBool isFilterSelected = RxBool(false);
  final RxBool isRecentPostCheckBoxSelected = RxBool(false);
  final RxList postedByList = RxList([
    {"icon": BipHip.world, "type": "Anyone"},
    {"icon": BipHip.friends, "type": "Friend"},
    {"icon": BipHip.addFamily, "type": "Family"},
    {"icon": BipHip.friends, "type": "Friends & Family"},
  ]);
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

  final List subCategoryList = ["Kids subcategory", "News subcategory", "International News", "Sports News"];
  final List productCategoryList = ["Any", "Gadgets", "Fashion", "Electronics", "Phone", "Laptop"];
  final List conditionList = ["Any", "New", "used", "Used Like New", "Used Like Poor", "Like New"];
  final RxList recentSearchList = RxList([
    {
      "name": "Wahid Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Wahid",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Murad",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "User",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "New User",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Test User",
      "image":
          "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
  ]);
  final RxList datePostedList = RxList([
    {"date": "AnyDate"},
    {"date": "2024"},
    {"date": "2023"},
    {"date": "2022"},
    {"date": "2021"},
    {"date": "2020"},
    {"date": "2019"},
    {"date": "2018"},
    {"date": "2017"},
    {"date": "2016"},
    {"date": "2015"},
    {"date": "2014"},
  ]);
  final RxList categoryList = RxList([
    "Any Category",
    "Poetry",
    "Painting",
    "Kids",
    "Storytelling",
    "Photography",
    "News",
  ]);
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
}
