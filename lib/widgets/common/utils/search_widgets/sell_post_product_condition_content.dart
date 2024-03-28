import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SellPostProductCategoryContent extends StatelessWidget {
  SellPostProductCategoryContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.searchFilterData.value!.sellPost?.category.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedSellPostProductCategory.value ==
                          allSearchController.searchFilterData.value!.sellPost?.category[index].value
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedSellPostProductCategory.value =
                        allSearchController.searchFilterData.value!.sellPost?.category[index].value ?? "";
                    if (allSearchController.temporarySelectedSellPostProductCategory.value == '') {
                      allSearchController.isSellPostProductConditionBottomSheetState.value = false;
                    } else {
                      allSearchController.isSellPostProductConditionBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.searchFilterData.value!.sellPost?.category[index].value,
                  borderColor: allSearchController.temporarySelectedSellPostProductCategory.value ==
                          allSearchController.searchFilterData.value!.sellPost?.category[index].value
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedSellPostProductCategory.value =
                          allSearchController.searchFilterData.value!.sellPost?.category[index].value ?? "";
                      if (allSearchController.temporarySelectedSellPostProductCategory.value == '') {
                        allSearchController.isSellPostProductConditionBottomSheetState.value = false;
                      } else {
                        allSearchController.isSellPostProductConditionBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedSellPostProductCategory.value ==
                        allSearchController.searchFilterData.value!.sellPost?.category[index].value,
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
