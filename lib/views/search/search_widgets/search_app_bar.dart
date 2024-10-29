import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/helpers/search/search_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SearchAppBar extends StatelessWidget {
  SearchAppBar({super.key});

  final AllSearchController allSearchController = Get.find<AllSearchController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: CustomIconButton(
              onPress: ()async {
                Get.back();
                await Get.find<HomeController>().getPostList();
              },
              icon: BipHip.leftArrow,
              iconColor: cBlackColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: CustomModifiedTextField(
                borderRadius: h8,
                controller: allSearchController.searchTextEditingController,
                focusNode: allSearchController.searchFocusNode,
                prefixIcon: BipHip.search,
                suffixIcon: allSearchController.isSearchSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                hint: ksSearch.tr,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: k12Padding,
                ),
                textInputStyle: regular16TextStyle(cBlackColor),
                onSuffixPress: () {
                  SearchHelper().onPressSearchBarCross();
                },
                onSubmit: (value) async {
                  SearchHelper().onSubmitSearchTextfield();
                },
                onChanged: (value) {
                  SearchHelper().onChangedSearchTextfield();
                },
              ),
            ),
          ),
          if (allSearchController.selectedFilterIndex.value != 0 && allSearchController.isSearched.value)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 6),
              child: CustomIconButton(
                onPress: () {
                  SearchHelper().onPressSearchFilter();
                },
                icon: BipHip.filter,
                size: kIconSize16,
                iconColor: cBlackColor,
              ),
            ),
        ],
      ),
    );
  }
}
