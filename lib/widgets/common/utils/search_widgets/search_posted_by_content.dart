import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
// import 'package:bip_hip/widgets/common/utils/search.dart';

class SearchPostedByContent extends StatelessWidget {
  SearchPostedByContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allSearchController.postedByList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  // leading: IconContainer(icon: allSearchController.postedByList[index]["icon"]),
                  itemColor:
                      allSearchController.temporarySelectedPostedBy.value == allSearchController.postedByList[index].value ? cPrimaryTint3Color : cWhiteColor,
                  onPressed: () {
                    allSearchController.temporarySelectedPostedBy.value = allSearchController.postedByList[index].value!;
                    if (allSearchController.temporarySelectedPostedBy.value == '') {
                      allSearchController.isPostedByBottomSheetState.value = false;
                    } else {
                      allSearchController.isPostedByBottomSheetState.value = true;
                    }
                  },
                  title: allSearchController.postedByList[index].value,
                  borderColor:
                      allSearchController.temporarySelectedPostedBy.value == allSearchController.postedByList[index].value ? cPrimaryColor : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      allSearchController.temporarySelectedPostedBy.value = allSearchController.postedByList[index].value!;
                      if (allSearchController.temporarySelectedPostedBy.value == '') {
                        allSearchController.isPostedByBottomSheetState.value = false;
                      } else {
                        allSearchController.isPostedByBottomSheetState.value = true;
                      }
                    },
                    isSelected: allSearchController.temporarySelectedPostedBy.value == allSearchController.postedByList[index].value,
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
