import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

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

  String postTimeDifference(DateTime inputDate) {
    final now = DateTime.now();
    final difference = now.difference(inputDate);

    if (difference.inDays >= 7) {
      return DateFormat('dd MMMM yyyy').format(inputDate);
    } else if (difference.inDays >= 1) {
      if (difference.inDays == 1) {
        return '${difference.inDays} day ago';
      } else {
        return '${difference.inDays} days ago';
      }
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} h ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} m ago';
    } else {
      return '${difference.inSeconds} s ago';
    }
  }

  // All post list API Implementation
  final ScrollController postListScrollController = ScrollController();
  final ScrollController timelinePostListScrollController = ScrollController();
  final Rx<PostListModel?> postListData = Rx<PostListModel?>(null);
  final RxList<PostData> allPostList = RxList<PostData>([]);
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
        postListScrolled.value = false;
        postListData.value = PostListModel.fromJson(response.data);
        allPostList.addAll(postListData.value!.posts.data);
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
        postListData.value = PostListModel.fromJson(response.data);
        allPostList.addAll(postListData.value!.posts.data);
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
  final RxList<PostData> allTimelinePostList = RxList<PostData>([]);
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
        postListScrolled.value = false;
        postListData.value = PostListModel.fromJson(response.data);
        allTimelinePostList.addAll(postListData.value!.posts.data);
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
        postListData.value = PostListModel.fromJson(response.data);
        allTimelinePostList.addAll(postListData.value!.posts.data);
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

  IconData getCategoryIcon(categoryID) {
    if (categoryID == 3) {
      return BipHip.poetry;
    } else if (categoryID == 4) {
      return BipHip.photography;
    } else if (categoryID == 5) {
      return BipHip.painting;
    } else if (categoryID == 6) {
      return BipHip.storytelling;
    } else if (categoryID == 7) {
      return BipHip.kids;
    } else if (categoryID == 8) {
      return BipHip.newsFill;
    } else {
      return BipHip.selling;
    }
  }

  Color getCategoryColor(categoryID) {
    if (categoryID == 3) {
      return cPoetryColor;
    } else if (categoryID == 4) {
      return cPhotographyColor;
    } else if (categoryID == 5) {
      return cPaintingColor;
    } else if (categoryID == 6) {
      return cStoryTellingColor;
    } else if (categoryID == 7) {
      return cKidsColor;
    } else if (categoryID == 8) {
      return cBlackColor;
    } else {
      return cSellingColor;
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
        // _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
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

//   List<Reaction<String>> reactions = [
//  const Reaction<String>(
//     value: 'love',
//     icon: Icon(Icons.favorite, color: Colors.pink),
//  ),
//  const Reaction<String>(
//     value: 'like',
//     icon: Icon(Icons.thumb_up, color: Colors.blue),
//  ),
//  const Reaction<String>(
//     value: 'angry',
//     icon: Icon(Icons.sentiment_very_dissatisfied, color: Colors.red),
//  ),
//  const Reaction<String>(
//     value: 'haha',
//     icon: Icon(Icons.mood, color: Colors.yellow),
//  ),
//  const Reaction<String>(
//     value: 'wow',
//     icon: Icon(Icons.sentiment_very_satisfied, color: Colors.green),
//  ),
//  const Reaction<String>(
//     value: 'sad',
//     icon: Icon(Icons.sentiment_dissatisfied, color: Colors.purple),
//  ),
// ];
// Reaction<String>? selectedReaction;
  final Rx<String?> selectedReactionText = Rx<String?>(null);
  final ScrollController scrollController = ScrollController();
  final RxBool isReactionSelected = RxBool(false);
  showSelectedReaction() {
    if (selectedReactionText.value == 'Love') {
      return SvgPicture.asset(
        kiLoveSvgImageUrl,
        width: 20,
      );
    } else if (selectedReactionText.value == 'Like') {
      return SvgPicture.asset(
        kiLikeSvgImageUrl,
        width: 20,
      );
    } else if (selectedReactionText.value == 'Haha') {
      return SvgPicture.asset(
        kiHahaSvgImageUrl,
        width: 20,
      );
    } else if (selectedReactionText.value == 'Wow') {
      return SvgPicture.asset(
        kiWowSvgImageUrl,
        width: 20,
      );
    } else if (selectedReactionText.value == 'Sad') {
      return SvgPicture.asset(
        kiSadSvgImageUrl,
        width: 20,
      );
    } else if (selectedReactionText.value == 'Angry') {
      return SvgPicture.asset(
        kiAngrySvgImageUrl,
        width: 20,
      );
    }
  }
}
