import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SearchHistory extends StatelessWidget {
  SearchHistory({super.key});

  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (allSearchController.isSearched.value == false && allSearchController.searchHistoryList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k16Padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ksRecent.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  InkWell(
                    onTap: () {
                      allSearchController.deleteAllSearchHistory();
                    },
                    child: Text(
                      ksClearAll.tr,
                      style: semiBold16TextStyle(cRedColor),
                    ),
                  ),
                ],
              ),
            ),
          if (allSearchController.isSearched.value == false)
            Padding(
              padding: const EdgeInsets.only(left: k12Padding, top: k16Padding),
              child: Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(k0Padding),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allSearchController.searchHistoryList.length,
                      separatorBuilder: (context, index) => kH4sizedBox,
                      itemBuilder: (context, index) {
                        return CustomListTile(
                          leading: ClipOval(
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                "",
                                width: h40,
                                height: h40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.user,
                                  size: kIconSize28,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                              ),
                            ),
                          ),
                          title: Text(
                            allSearchController.searchHistoryList[index].keywords ?? "",
                            style: medium16TextStyle(cBlackColor),
                          ),
                          trailing: CustomIconButton(
                            onPress: () {
                              allSearchController.deleteSearchHistory(id: allSearchController.searchHistoryList[index].id!);
                            },
                            icon: BipHip.circleCrossNew,
                            size: kIconSize16,
                          ),
                          onPressed: () async {
                            unfocus(context);
                            allSearchController.searchTextEditingController.text = allSearchController.searchHistoryList[index].keywords!;
                            allSearchController.isSearchSuffixIconVisible.value = true;
                            allSearchController.selectedFilterValue.value = "all";
                            allSearchController.selectedFilterIndex.value = 0;
                            allSearchController.isSearched.value = true;
                            await allSearchController.getSearch();
                          },
                        );
                      }),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
