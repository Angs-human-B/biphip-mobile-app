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
          itemCount: allSearchController.subCategoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor:
                      allSearchController.temporarySelectedSubCategory.value == allSearchController.subCategoryList[index] ? cPrimaryTint3Color : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedSubCategory.value = allSearchController.subCategoryList[index];
                    if (allSearchController.temporarySelectedSubCategory.value == '') {
                      allSearchController.isSubCategoryBottomSheetState.value = false;
                    } else {
                      allSearchController.isSubCategoryBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.subCategoryList[index],
                  borderColor:
                      allSearchController.temporarySelectedSubCategory.value == allSearchController.subCategoryList[index] ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedSubCategory.value = allSearchController.subCategoryList[index];
                      if (allSearchController.temporarySelectedSubCategory.value == '') {
                        allSearchController.isSubCategoryBottomSheetState.value = false;
                      } else {
                        allSearchController.isSubCategoryBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedSubCategory.value == allSearchController.subCategoryList[index],
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

