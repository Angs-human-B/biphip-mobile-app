import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidsNewsSubCategoryContent extends StatelessWidget {
  KidsNewsSubCategoryContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.selectedFilterValue.value == "Kids"
              ? allSearchController.searchFilterData.value!.kids!.subCategory.length
              : allSearchController.searchFilterData.value!.news!.subCategory.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: (allSearchController.selectedFilterValue.value == "Kids"
                          ? allSearchController.temporarySelectedSubCategory.value == allSearchController.searchFilterData.value!.kids!.subCategory[index].value
                          : allSearchController.temporarySelectedSubCategory.value ==
                              allSearchController.searchFilterData.value!.news!.subCategory[index].value)
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    if (allSearchController.selectedFilterValue.value == "Kids") {
                      allSearchController.temporarySelectedSubCategory.value = allSearchController.searchFilterData.value?.kids?.subCategory[index].value ?? "";
                    } else {
                      allSearchController.temporarySelectedSubCategory.value = allSearchController.searchFilterData.value?.news?.subCategory[index].value ?? "";
                    }
                    if (allSearchController.temporarySelectedSubCategory.value == '') {
                      allSearchController.isSubCategoryBottomSheetState.value = false;
                    } else {
                      allSearchController.isSubCategoryBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.selectedFilterValue.value == "Kids"
                      ? allSearchController.searchFilterData.value!.kids!.subCategory[index].value
                      : allSearchController.searchFilterData.value!.news!.subCategory[index].value,
                  borderColor: (allSearchController.selectedFilterValue.value == "Kids"
                          ? allSearchController.temporarySelectedSubCategory.value == allSearchController.searchFilterData.value!.kids!.subCategory[index].value
                          : allSearchController.temporarySelectedSubCategory.value ==
                              allSearchController.searchFilterData.value!.news!.subCategory[index].value)
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      if (allSearchController.selectedFilterValue.value == "Kids") {
                        allSearchController.temporarySelectedSubCategory.value =
                            allSearchController.searchFilterData.value?.kids?.subCategory[index].value ?? "";
                      } else {
                        allSearchController.temporarySelectedSubCategory.value =
                            allSearchController.searchFilterData.value?.news?.subCategory[index].value ?? "";
                      }
                      if (allSearchController.temporarySelectedSubCategory.value == '') {
                        allSearchController.isSubCategoryBottomSheetState.value = false;
                      } else {
                        allSearchController.isSubCategoryBottomSheetState.value = true;
                      }
                    },
                    isSelected: (allSearchController.selectedFilterValue.value == "Kids"
                        ? allSearchController.temporarySelectedSubCategory.value == allSearchController.searchFilterData.value!.kids!.subCategory[index].value
                        : allSearchController.temporarySelectedSubCategory.value == allSearchController.searchFilterData.value!.news!.subCategory[index].value),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
