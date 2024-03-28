import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SellPostProductConditionContent extends StatelessWidget {
  SellPostProductConditionContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.searchFilterData.value!.sellPost!.condition.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedSellPostCondition.value ==
                          allSearchController.searchFilterData.value?.sellPost?.condition[index].value
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedSellPostCondition.value =
                        allSearchController.searchFilterData.value!.sellPost!.condition[index].value!;
                    if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                      allSearchController.isSellPostConditionBottomSheetState.value = false;
                    } else {
                      allSearchController.isSellPostConditionBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.searchFilterData.value?.sellPost?.condition[index].value,
                  borderColor: allSearchController.temporarySelectedSellPostCondition.value ==
                          allSearchController.searchFilterData.value?.sellPost?.condition[index].value
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedSellPostCondition.value =
                          allSearchController.searchFilterData.value!.sellPost!.condition[index].value!;
                      if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                        allSearchController.isSellPostConditionBottomSheetState.value = false;
                      } else {
                        allSearchController.isSellPostConditionBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedSellPostCondition.value ==
                        allSearchController.searchFilterData.value?.sellPost?.condition[index].value,
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
