
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
          itemCount: allSearchController.conditionList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedSellPostCondition.value == allSearchController.conditionList[index]
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedSellPostCondition.value = allSearchController.conditionList[index];
                    // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                    if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                      allSearchController.isSellPostConditionBottomSheetState.value = false;
                    } else {
                      allSearchController.isSellPostConditionBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.conditionList[index],
                  borderColor:
                      allSearchController.temporarySelectedSellPostCondition.value == allSearchController.conditionList[index] ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedSellPostCondition.value = allSearchController.conditionList[index];
                      if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                        allSearchController.isSellPostConditionBottomSheetState.value = false;
                      } else {
                        allSearchController.isSellPostConditionBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedSellPostCondition.value == allSearchController.conditionList[index],
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

