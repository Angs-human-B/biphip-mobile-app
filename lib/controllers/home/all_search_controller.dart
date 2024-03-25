import 'package:bip_hip/utils/constants/imports.dart';

class AllSearchController extends GetxController {
  final TextEditingController searchTextEditingController = TextEditingController();
  final List filterTypeList = ["All", "Posts", "People", "Photos", "Videos", "Sell Posts", "Kids", "News"];
  final RxInt selectedFilterIndex = RxInt(0);
  final RxBool isFilterSelected = RxBool(false);
  final RxBool isFilterRightButtonActive = RxBool(false);
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
}
