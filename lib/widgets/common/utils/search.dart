import 'package:bip_hip/utils/constants/imports.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
    required this.searchController,
    required this.recentSearchList,
    required this.onSubmit,
    this.isShopSearch = false,
    this.isHomeSearch = false,
    this.isFavoriteSearch = false,
  }) : super(key: key);

  final TextEditingController searchController;
  final RxList recentSearchList;
  final dynamic onSubmit;
  final bool isShopSearch, isHomeSearch, isFavoriteSearch;

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
                            hint: "Search here...",
                            borderRadius: 30,
                            contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: h12),
                            controller: searchController,
                            fillColor: cInputFieldColor,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            prefixIcon: BipHip.search,
                            suffixIcon: isSuffix.value ? BipHip.circleCrossNew : null,
                            onSuffixPress: isSuffix.value
                                ? () {
                                    searchController.clear();
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
                              if (v.isNotEmpty) {
                                var item = v.toLowerCase();
                                for (int i = 0; i < recentSearchList.length; i++) {
                                  if (recentSearchList[i] == item) {
                                    recentSearchList.remove(item);
                                  }
                                }
                                recentSearchList.add(item);
                              } else {
                                recentSearchList.add('...');
                              }
                              if (recentSearchList.length > 6) recentSearchList.removeAt(0);
                              final spController = SpController();
                              await spController.saveRecentSearchList(recentSearchList);

                              onSubmit();
                              unfocus(context);
                              searchController.clear();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (recentSearchList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Search",
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                              CustomTextButton(
                                onPressed: () async {
                                  recentSearchList.value = [];
                                  final spController = SpController();
                                  await spController.saveRecentSearchList(recentSearchList);
                                },
                                text: "Clear",
                                textStyle: regular14TextStyle(cRedColor),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Wrap(
                            children: [
                              for (int i = recentSearchList.length - 1; i >= 0; i--)
                                _ChipsWrapContainer(
                                  text: recentSearchList[i],
                                  onPress: () {
                                    searchController.text = recentSearchList[i];
                                    searchController.selection = TextSelection.fromPosition(TextPosition(offset: searchController.text.length));
                                    isSuffix.value = true;
                                  },
                                ),
                            ],
                          ),
                        ),
                        kH20sizedBox,
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipsWrapContainer extends StatelessWidget {
  const _ChipsWrapContainer({
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
