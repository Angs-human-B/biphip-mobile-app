import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/homepage.dart';

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

  // All post list API Implementation
  final Rx<PostListModel?> postListData = Rx<PostListModel?>(null);
  final RxList<PostData> allPostList = RxList<PostData>([]);
  final RxBool isHomePageLoading = RxBool(false);
  Future<void> getPostList() async {
    try {
      isHomePageLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllPosts,
      ) as CommonDM;
      if (response.success == true) {
        allPostList.clear();
        postListData.value = PostListModel.fromJson(response.data);
        allPostList.addAll(postListData.value!.posts.data);
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

  congratulationsAlertDialog({required BuildContext context, required Widget content}) {
    showAlertDialog(
      context: context,
      child: CommonAlertDialog(
        hasCloseBtn: true,
        onClose: () => Get.back(),
        addContent: content,
        actions: [
          CustomElevatedButton(
            label: ksOk.tr,
            onPressed: () {
              Get.back();
            },
            buttonWidth: width * .45,
            buttonHeight: 40,
            buttonColor: cPrimaryColor,
          ),
          kH10sizedBox,
        ],
      ),
    );
  }
}
