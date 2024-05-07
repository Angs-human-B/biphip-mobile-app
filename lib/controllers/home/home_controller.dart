import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/models/post/get_reply_list_model.dart';
import 'package:bip_hip/models/post/new_post_comment.dart';
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
  final RxString sharedPostMyReaction = RxString("");
  final Rx<CountReactions?> sharePostCountReaction = Rx<CountReactions?>(null);
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
        postReplyShow.clear();
        postData.value = PostDataModel.fromJson(response.data);
        for (int i = 0; i < postData.value!.post.comments.length; i++) {
          postReplyShow.add(false);
        }
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

  //   //*get Specific post Comments
  final ScrollController postCommentListScrollController = ScrollController();
  final Rx<PostCommentModel?> postCommentListData = Rx<PostCommentModel?>(null);
  final RxList<CommentDataRx> postCommentList = RxList<CommentDataRx>([]);
  final RxInt postCommentIndex = RxInt(-1);
  final RxBool isPostCommentLoading = RxBool(false);
  final Rx<String?> getPostCommentSubLink = Rx<String?>(null);
  final RxBool getPostCommentScrolled = RxBool(false);
  final RxList<bool> postReplyShow = RxList<bool>([]);
  Future<void> getPostCommentList(int refType, int refId) async {
    try {
      isPostCommentLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetComment?ref_type=${refType.toString()}&ref_id=${refId.toString()}&take=10",
      ) as CommonDM;
      if (response.success == true) {
        postCommentList.clear();
        postReplyShow.clear();
        postData.value!.post.comments.clear();
        getPostCommentScrolled.value = false;
        postCommentListData.value = PostCommentModel.fromJson(response.data);
        postCommentList.addAll(postCommentListData.value!.comments!.data);
        for (int i = 0; i < postCommentList.length; i++) {
          postReplyShow.add(false);
        }
        postData.value!.post.comments.addAll(postCommentList);
        update();
        getPostCommentSubLink.value = postCommentListData.value!.comments!.nextPageUrl;
        if (getPostCommentSubLink.value != null) {
          getPostCommentScrolled.value = false;
        } else {
          getPostCommentScrolled.value = true;
        }
        isPostCommentLoading.value = false;
      } else {
        isPostCommentLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostCommentLoading.value = true;
      ll('getPostCommentList error: $e');
    }
  }

  //*Get More Comment List for pagination
  Future<void> getMorePostCommentList(take, int refType, int refId) async {
    try {
      isPostCommentLoading.value = true;
      String? token = await spController.getBearerToken();
      dynamic commentListSub;
      if (getPostCommentSubLink.value == null) {
        return;
      } else {
        commentListSub = getPostCommentSubLink.value!.split('?');
      }
      String commentListSuffixUrl = '';

      commentListSuffixUrl = '?${commentListSub[1]}&ref_type=${refType.toString()}&ref_id=${refId.toString()}&take=10';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetComment + commentListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        postCommentListData.value = PostCommentModel.fromJson(response.data);
        postData.value!.post.comments.addAll(postCommentListData.value!.comments!.data);
        postReplyShow.clear();
        for (int i = 0; i < postData.value!.post.comments.length; i++) {
          postReplyShow.add(false);
        }
        getPostCommentSubLink.value = postCommentListData.value!.comments!.nextPageUrl;
        if (getPostCommentSubLink.value != null) {
          getPostCommentScrolled.value = false;
        } else {
          getPostCommentScrolled.value = true;
        }
        isPostCommentLoading.value = false;
      } else {
        isPostCommentLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostCommentLoading.value = true;
      ll('getMorePostCommentList error: $e');
    }
  }

  final Rx<ReplyListModel?> postReplyListData = Rx<ReplyListModel?>(null);
  final RxList<CommentReply> postReplyList = RxList<CommentReply>([]);
  final RxBool isPostReplyLoading = RxBool(false);
  Future<void> getPostReplyList(int commentId, commentIndex) async {
    try {
      isPostReplyLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuGetReply?commentId=${commentId.toString()}&take=10",
      ) as CommonDM;
      if (response.success == true) {
        postReplyList.clear();
        postData.value!.post.comments[commentIndex].commentReplies.clear();
        postReplyListData.value = ReplyListModel.fromJson(response.data);
        postReplyList.addAll(postReplyListData.value!.commentReplies!.data);
        postData.value!.post.comments[commentIndex].commentReplies.addAll(postReplyList);
        isPostReplyLoading.value = false;
      } else {
        isPostReplyLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostReplyLoading.value = true;
      ll('getPostReplyList error: $e');
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
