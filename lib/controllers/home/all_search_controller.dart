import 'package:bip_hip/utils/constants/imports.dart';

class AllSearchController extends GetxController {
  final TextEditingController searchTextEditingController = TextEditingController();
  final List filterTypeList = ["All", "Posts", "People", "Photos", "Videos", "Sell Posts", "Kids", "News"];
  final RxInt selectedFilterIndex = RxInt(0);
  final RxBool isFilterSelected = RxBool(false);
  final RxBool isFilterRightButtonActive = RxBool(false);
  final RxBool isRecentPostCheckBoxSelected = RxBool(false);
  final RxBool isPostedBySelected = RxBool(false);
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
