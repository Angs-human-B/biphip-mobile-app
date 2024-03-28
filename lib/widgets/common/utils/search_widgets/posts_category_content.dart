import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PostsCategoryContent extends StatelessWidget {
  PostsCategoryContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.postsData.value?.postCategory.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: allSearchController.temporarySelectedCategory.value == allSearchController.postsData.value?.postCategory[index].value
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedCategory.value = allSearchController.postsData.value!.postCategory[index].value!;
                    // kidsController.temporaryKidRelationId.value = kidsController.kidRelationMap[index]['relation_id']!;
                    if (allSearchController.temporarySelectedCategory.value == '') {
                      allSearchController.isCategoryBottomSheetState.value = false;
                    } else {
                      allSearchController.isCategoryBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.postsData.value!.postCategory[index].value,
                  borderColor: allSearchController.temporarySelectedCategory.value == allSearchController.postsData.value?.postCategory[index].value
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedCategory.value = allSearchController.postsData.value!.postCategory[index].value!;
                      if (allSearchController.temporarySelectedCategory.value == '') {
                        allSearchController.isCategoryBottomSheetState.value = false;
                      } else {
                        allSearchController.isCategoryBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedCategory.value == allSearchController.postsData.value!.postCategory[index].value,
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
