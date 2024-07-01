import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class DatePostedContent extends StatelessWidget {
  DatePostedContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.datePostedList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedDatePosted.value == allSearchController.datePostedList[index].value.toString()
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedDatePosted.value = allSearchController.datePostedList[index].value.toString();
                    if (allSearchController.temporarySelectedDatePosted.value == "") {
                      allSearchController.isDatePostedBottomSheetState.value = false;
                    } else {
                      allSearchController.isDatePostedBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.datePostedList[index].value.toString(),
                  borderColor: allSearchController.temporarySelectedDatePosted.value == allSearchController.datePostedList[index].value.toString()
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedDatePosted.value = allSearchController.datePostedList[index].value.toString();
                      // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                      if (allSearchController.temporarySelectedDatePosted.value == "") {
                        allSearchController.isDatePostedBottomSheetState.value = false;
                      } else {
                        allSearchController.isDatePostedBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedDatePosted.value == allSearchController.datePostedList[index].value.toString(),
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
