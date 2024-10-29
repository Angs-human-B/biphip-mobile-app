import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class SearchFilterChips extends StatelessWidget {
  SearchFilterChips({super.key});

  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: k16Padding),
      child: Container(
        color: cWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: 50,
              child: ListView.builder(
                itemCount: allSearchController.filterTypeList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                    child: Obx(() => CustomChoiceChips(
                          label: allSearchController.filterTypeList[i],
                          isSelected: (allSearchController.selectedFilterIndex.value == i),
                          onSelected: (value) async {
                            allSearchController.selectedFilterIndex.value = i;
                            allSearchController.selectedFilterValue.value = allSearchController.filterTypeList[i];
                            allSearchController.resetBottomSheetData();
                            allSearchController.filterPostCategory();
                          },
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
