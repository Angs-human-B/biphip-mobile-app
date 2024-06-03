import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final RxString selectedQuizTimeRangeValue = RxString("This Month");
  final RxString temporarySelectedCategory = RxString("All");
  final RxString selectedCategory = RxString("All");
  final RxInt temporarySelectedCategoryId = RxInt(-1);
  final RxInt selectedCategoryId = RxInt(-1);
  final RxBool categoryRightButtonState = RxBool(false);
  final List selectDateTimeFilterList = ["Today", "Yesterday", "This Week", "This Month", "This Year", "Custom"];
  final List categoryFilterList = [
    {"categoryIcon": BipHip.poetry, "categoryName": "Poetry", "id": 1},
    {"categoryIcon": BipHip.painting, "categoryName": "Painting", "id": 2},
    {"categoryIcon": BipHip.kids, "categoryName": "Kids", "id": 3},
    {"categoryIcon": BipHip.storytelling, "categoryName": "Storytelling", "id": 4},
    {"categoryIcon": BipHip.photography, "categoryName": "Photography", "id": 5},
    {"categoryIcon": BipHip.newsFill, "categoryName": "News", "id": 6},
    {"categoryIcon": BipHip.selling, "categoryName": "Selling", "id": 7},
  ];
  Color categoryIconColor(int index) {
    if (categoryFilterList[index]["id"] == 1) {
      return cPoetryColor;
    } else if (categoryFilterList[index]["id"] == 2) {
      return cPaintingColor;
    } else if (categoryFilterList[index]["id"] == 3) {
      return cKidsColor;
    } else if (categoryFilterList[index]["id"] == 4) {
      return cStoryTellingColor;
    } else if (categoryFilterList[index]["id"] == 5) {
      return cPhotographyColor;
    } else if (categoryFilterList[index]["id"] == 6) {
      return cCategoryColor;
    } else {
      return cPrimaryColor;
    }
  }
}
