import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class Search extends StatelessWidget {
  Search({
    Key? key,
    // required this.searchTextEditingController,
    // required this.recentSearchList,
    // required this.onSubmit,
    // this.isShopSearch = false,
    // this.isHomeSearch = false,
    // this.isFavoriteSearch = false,
  }) : super(key: key);

  // final TextEditingController searchTextEditingController;
  // final RxList recentSearchList;
  // final dynamic onSubmit;
  // final bool isShopSearch, isHomeSearch, isFavoriteSearch;
  final AllSearchController allSearchController = Get.find<AllSearchController>();

  @override
  Widget build(BuildContext context) {
    RxBool isSuffix = RxBool(false);
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Obx(
          () => Scaffold(
            //* info:: body
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: CustomIconButton(
                            onPress: () {
                              Get.back();
                            },
                            icon: BipHip.leftArrow,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CustomModifiedTextField(
                              hint: ksSearch.tr,
                              borderRadius: 30,
                              contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: h12),
                              controller: allSearchController.searchTextEditingController,
                              fillColor: cInputFieldColor,
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.done,
                              prefixIcon: BipHip.search,
                              suffixIcon: isSuffix.value ? BipHip.circleCrossNew : null,
                              onSuffixPress: isSuffix.value
                                  ? () {
                                      allSearchController.searchTextEditingController.clear();
                                      isSuffix.value = false;
                                    }
                                  : null,
                              onChanged: (v) {
                                if (v.isEmpty) {
                                  isSuffix.value = false;
                                } else {
                                  isSuffix.value = true;
                                }
                              },
                              onSubmit: (v) async {
                                // unfocus(context);
                                // if (v.isNotEmpty) {
                                //   var item = v.toLowerCase();
                                //   for (int i = 0; i < recentSearchList.length; i++) {
                                //     if (recentSearchList[i] == item) {
                                //       recentSearchList.remove(item);
                                //     }
                                //   }
                                //   recentSearchList.add(item);
                                // } else {
                                //   recentSearchList.add('...');
                                // }
                                // if (recentSearchList.length > 6) recentSearchList.removeAt(0);
                                // final spController = SpController();
                                // await spController.saveRecentSearchList(recentSearchList);
                                // onSubmit();
                                // searchTextEditingController.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    // if (recentSearchList.isNotEmpty)
                    //   Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: h16),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               "Recent Search",
                    //               style: semiBold16TextStyle(cBlackColor),
                    //             ),
                    //             CustomTextButton(
                    //               onPressed: () async {
                    //                 recentSearchList.value = [];
                    //                 final spController = SpController();
                    //                 await spController.saveRecentSearchList(recentSearchList);
                    //               },
                    //               text: "Clear",
                    //               textStyle: regular14TextStyle(cRedColor),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         child: Wrap(
                    //           children: [
                    //             for (int i = recentSearchList.length - 1; i >= 0; i--)
                    //               ChipsWrapContainer(
                    //                 text: recentSearchList[i],
                    //                 onPress: () {
                    //                   searchController.text = recentSearchList[i];
                    //                   searchController.selection = TextSelection.fromPosition(TextPosition(offset: searchController.text.length));
                    //                   isSuffix.value = true;
                    //                 },
                    //               ),
                    //           ],
                    //         ),
                    //       ),
                    //       kH20sizedBox,
                    //     ],
                    //   ),

                    // Wrap(
                    //   alignment: WrapAlignment.start,
                    //   direction: Axis.horizontal,
                    //   spacing: 8.0,
                    //   children: [
                    //     for (int i = 0; i < allSearchController.filterTypeList.length; i++)
                    //       Padding(
                    //         padding: const EdgeInsets.only(bottom: k8Padding),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               color: cWhiteColor,
                    //               border: Border.all(
                    //                 color: cLineColor,
                    //               ),
                    //               borderRadius: k100CircularBorderRadius),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(k8Padding),
                    //             child: Text(
                    //               // profileController.userData.value!.interest[i],
                    //               // kidsController.kidsData.value?.hobbies[i],
                    //               // kidsController.kidsData.value!.hobbies[i],
                    //               allSearchController.filterTypeList[i],
                    //               style: regular14TextStyle(cBlackColor),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //   ],
                    // ),

                    Container(
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
                                return Obx(() => CustomChoiceChips(
                                      label: allSearchController.filterTypeList[i],
                                      isSelected: (allSearchController.selectedFilterIndex.value == i && allSearchController.isFilterSelected.value),
                                      onSelected: (value) {
                                        allSearchController.selectedFilterIndex.value = i;
                                        allSearchController.isFilterSelected.value = value;
                                      },
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    kH12sizedBox,
                    Text(
                      ksPeople.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    if (allSearchController.userList.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: k16Padding),
                        child: Column(
                          children: [
                            ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(k0Padding),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allSearchController.userList.length,
                                separatorBuilder: (context, index) => kH8sizedBox,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: h40,
                                          height: h40,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: cWhiteColor,
                                          ),
                                          child: Image.network(
                                            allSearchController.userList[index]['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      kW12sizedBox,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            allSearchController.userList[index]['name'],
                                            style: semiBold16TextStyle(cBlackColor),
                                          ),
                                          if (allSearchController.userList[index]['mutualFriend'] != null)
                                            Text(
                                              allSearchController.userList[index]['mutualFriend'],
                                              style: regular10TextStyle(cSmallBodyTextColor),
                                            ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        allSearchController.userList[index]['isFriend'] == "0" ? ksAddFriend.tr : ksMessage.tr,
                                        style: regular12TextStyle(cPrimaryColor),
                                      ),
                                    ],
                                  );
                                }),
                            kH16sizedBox,
                            
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChipsWrapContainer extends StatelessWidget {
  const ChipsWrapContainer({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          border: kLineBorder,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding),
          child: Text(
            text,
            style: regular14TextStyle(cPlaceHolderColor),
          ),
        ),
      ),
    );
  }
}
