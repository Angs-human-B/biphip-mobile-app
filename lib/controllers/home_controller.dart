import 'package:bip_hip/utils/constants/imports.dart';

class HomeController extends GetxController {
  final Rx<Color> categoryIconColor = Rx<Color>(cWhiteColor);
  final Rx<IconData> categoryIcon = Rx<IconData>(BipHip.add);
  final RxBool showSeeMore = RxBool(false);
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
  IconData getCategoryIcon(String category) {
    for (int i = 0; i < postCategory.length; i++) {
      if (postCategory[i]['text'] == category) {
        categoryIcon.value = postCategory[i]['icon'];
      }
    }
    return categoryIcon.value;
  }

  Color getCategoryIconColor(String category) {
    for (int i = 0; i < postCategory.length; i++) {
      if (postCategory[i]['text'] == category) {
        categoryIconColor.value = postCategory[i]['color'];
      }
    }
    return categoryIconColor.value;
  }
}
