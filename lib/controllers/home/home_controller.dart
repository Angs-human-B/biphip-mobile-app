import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class HomeController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final Rx<Color> categoryIconColor = Rx<Color>(cWhiteColor);
  final Rx<IconData> categoryIcon = Rx<IconData>(BipHip.add);
  // final RxBool showSeeMore = RxBool(false);
  final RxBool sharedPostSeeMore = RxBool(true);
  final RxBool seeMore = RxBool(false);
  final RxList imageList = RxList([
    kiDummyImage1ImageUrl,
    kiDummyImage2ImageUrl,
    kiDummyImage3ImageUrl,
    kiDummyImage3ImageUrl,
    kiDummyImage2ImageUrl,
  ]);
  List postCategory = [
    {
      'icon': BipHip.photography,
      'color': cPhotographyColor,
      'text': 'Photography',
    },
    {
      'icon': BipHip.selling,
      'color': cSellingColor,
      'text': 'Selling',
    },
    {
      'icon': BipHip.kids,
      'color': cKidsColor,
      'text': 'Kids',
    },
    {
      'icon': BipHip.newsFill,
      'color': cBlackColor,
      'text': 'News',
    },
  ];

  void changeSeeMoreValue(bool value) {
    value = !value;
    ll(seeMore);
  }

  int getBiddingDuration(DateTime endTime) {
    int diff = endTime.difference(DateTime.now()).inSeconds;
    return diff;
  }

  // All post list API Implementation
  final ScrollController postListScrollController = ScrollController();
  final ScrollController timelinePostListScrollController = ScrollController();
  final Rx<PostListModel?> postListData = Rx<PostListModel?>(null);
  final RxList<PostDataRx> allPostList = RxList<PostDataRx>([]);
  final RxBool isHomePageLoading = RxBool(false);
  final RxBool isHomePagePaginationLoading = RxBool(false);
  final Rx<String?> postListSubLink = Rx<String?>(null);
  final RxBool postListScrolled = RxBool(false);
  Future<void> getPostList() async {
    try {
      isHomePageLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllPosts + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        allPostList.clear();
        globalController.commonPostList.clear();
        postListScrolled.value = false;
        ll(1);
        postListData.value = PostListModel.fromJson(response.data);
        allPostList.addAll(postListData.value!.posts.data);
        globalController.populatePostList(allPostList);
        postListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (postListSubLink.value != null) {
          postListScrolled.value = false;
        } else {
          postListScrolled.value = true;
        }

        isHomePageLoading.value = false;
      } else {
        isHomePageLoading.value = true;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isHomePageLoading.value = true;

      ll('getPostList error: $e');
    }
  }

  //*Get More Post List for pagination
  Future<void> getMorePostList() async {
    try {
      isHomePagePaginationLoading.value = true;
      String? token = await spController.getBearerToken();
      dynamic postListSub;

      if (postListSubLink.value == null) {
        return;
      } else {
        postListSub = postListSubLink.value!.split('?');
      }

      String postListSuffixUrl = '';

      postListSuffixUrl = '?${postListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllPosts + postListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        allPostList.clear();
        postListData.value = PostListModel.fromJson(response.data);
        allPostList.addAll(postListData.value!.posts.data);
        globalController.populatePostList(allPostList);
        postListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (postListSubLink.value != null) {
          postListScrolled.value = false;
        } else {
          postListScrolled.value = true;
        }

        isHomePagePaginationLoading.value = false;
      } else {
        isHomePagePaginationLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isHomePagePaginationLoading.value = true;
      ll('getMorePostList error: $e');
    }
  }

  //* Get Self Timeline posts
  final RxList<PostDataRx> allTimelinePostList = RxList<PostDataRx>([]);
  final RxBool isTimelinePostLoading = RxBool(false);
  final RxBool isTimelinePostPaginationLoading = RxBool(false);
  final Rx<String?> timelinePostListSubLink = Rx<String?>(null);
  final RxBool timelinePostListScrolled = RxBool(false);
  Future<void> getTimelinePostList() async {
    try {
      isTimelinePostLoading.value = true;
      String suffixUrl = '?page=1';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetTimelinePostData + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        allTimelinePostList.clear();
        globalController.commonPostList.clear();
        postListScrolled.value = false;
        postListData.value = PostListModel.fromJson(response.data);
        allTimelinePostList.addAll(postListData.value!.posts.data);
        globalController.populatePostList(allTimelinePostList);
        timelinePostListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (timelinePostListSubLink.value != null) {
          timelinePostListScrolled.value = false;
        } else {
          timelinePostListScrolled.value = true;
        }
        isTimelinePostLoading.value = false;
      } else {
        isTimelinePostLoading.value = true;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isTimelinePostLoading.value = true;

      ll('getTimelinePostList error: $e');
    }
  }

  //*Get More Post List for pagination
  Future<void> getMoreTimelinePostList() async {
    try {
      isTimelinePostPaginationLoading.value = true;
      String? token = await spController.getBearerToken();
      dynamic timelinePostListSub;

      if (timelinePostListSubLink.value == null) {
        return;
      } else {
        timelinePostListSub = timelinePostListSubLink.value!.split('?');
      }

      String timelinePostListSuffixUrl = '';

      timelinePostListSuffixUrl = '?${timelinePostListSub[1]}';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetTimelinePostData + timelinePostListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        allTimelinePostList.clear();
        postListData.value = PostListModel.fromJson(response.data);
        allTimelinePostList.addAll(postListData.value!.posts.data);
        globalController.populatePostList(allTimelinePostList);
        timelinePostListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (timelinePostListSubLink.value != null) {
          timelinePostListScrolled.value = false;
        } else {
          timelinePostListScrolled.value = true;
        }
        isTimelinePostPaginationLoading.value = false;
      } else {
        isTimelinePostPaginationLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isTimelinePostPaginationLoading.value = true;
      ll('getMoreTimelinePostList error: $e');
    }
  }

  //Get post data
  final RxBool isPostDetailsPageLoading = RxBool(false);
  final Rx<PostDataModel?> postData = Rx<PostDataModel?>(null);
  Future<void> getPostData(id) async {
    try {
      isPostDetailsPageLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        url: '$kuGetPostData/$id',
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        postData.value = PostDataModel.fromJson(response.data);
        isPostDetailsPageLoading.value = false;
      } else {
        isPostDetailsPageLoading.value = true;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostDetailsPageLoading.value = true;
      ll('getPostData error: $e');
    }
  }

  List<String> getImageUrl() {
    List<String> images = [];
    if (postData.value!.post.images.isEmpty) {
      return images;
    }
    for (int i = 0; i < postData.value!.post.images.length; i++) {
      images.add(postData.value!.post.images[i].fullPath ?? '');
    }
    return images;
  }

  final RxInt homeTabIndex = RxInt(0);
  final RxList birthdayActionList = RxList([
    {'icon': BipHip.deleteNew, 'action': 'Delete Post'},
    {'icon': BipHip.edit, 'action': 'Edit Post'},
  ]);
  final RxString birthdaySelectedAction = RxString("");

  Future<void> getFilteredTimelinePostList({required int categoryId, required int type}) async {
    //,int typeId
    try {
      isTimelinePostLoading.value = true;
      String suffixUrl = '?page=1';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetPostsByCategoryId$suffixUrl &category_id=${categoryId.toString()}&type=${type.toString()}",
      ) as CommonDM;
      if (response.success == true) {
        allTimelinePostList.clear();
        globalController.commonPostList.clear();
        postListScrolled.value = false;
        postListData.value = PostListModel.fromJson(response.data);
        allTimelinePostList.addAll(postListData.value!.posts.data);
        globalController.populatePostList(allTimelinePostList);
        timelinePostListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (timelinePostListSubLink.value != null) {
          timelinePostListScrolled.value = false;
        } else {
          timelinePostListScrolled.value = true;
        }
        isTimelinePostLoading.value = false;
      } else {
        isTimelinePostLoading.value = true;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isTimelinePostLoading.value = true;

      ll('getTimelinePostList error: $e');
    }
  }

  Future<void> getMoreFilteredTimelinePostList({required int categoryId, required int type}) async {
    try {
      isTimelinePostPaginationLoading.value = true;
      String? token = await spController.getBearerToken();
      dynamic timelinePostListSub;

      if (timelinePostListSubLink.value == null) {
        return;
      } else {
        timelinePostListSub = timelinePostListSubLink.value!.split('?');
      }

      String timelinePostListSuffixUrl = '';

      timelinePostListSuffixUrl = '?${timelinePostListSub[1]}';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        // url: kuGetPostsByCategoryId + timelinePostListSuffixUrl,
        url: "$kuGetPostsByCategoryId$timelinePostListSuffixUrl &category_id=${categoryId.toString()}&type=${type.toString()}",
      ) as CommonDM;

      if (response.success == true) {
        allTimelinePostList.clear();
        postListData.value = PostListModel.fromJson(response.data);
        allTimelinePostList.addAll(postListData.value!.posts.data);
        globalController.commonPostList.addAll(allTimelinePostList);
        timelinePostListSubLink.value = postListData.value!.posts.nextPageUrl;
        if (timelinePostListSubLink.value != null) {
          timelinePostListScrolled.value = false;
        } else {
          timelinePostListScrolled.value = true;
        }
        isTimelinePostPaginationLoading.value = false;
      } else {
        isTimelinePostPaginationLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isTimelinePostPaginationLoading.value = true;
      ll('getMoreTimelinePostList error: $e');
    }
  }
}
