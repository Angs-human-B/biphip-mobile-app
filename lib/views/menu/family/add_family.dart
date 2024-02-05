import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/menu/family/family_helper.dart';
import 'package:bip_hip/shimmers/menu/family/relation_content_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/views/menu/family/widgets/relation_content.dart';

class AddFamily extends StatelessWidget {
  AddFamily({super.key, this.name});
  final String? name;
  final FamilyController familyController = Get.find<FamilyController>();
  final FriendController friendController = Get.find<FriendController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final FamilyHelper familyHelper = FamilyHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    title: ksAddFamilyMember.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      globalController.searchController.clear();
                      Get.back();
                      familyController.isFamilySuffixIconVisible.value = false;
                    },
                    action: [
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(right: h20),
                            child: TextButton(
                              style: kTextButtonStyle,
                              onPressed: (familyController.relationId.value == -1 || familyController.userId.value == -1)
                                  ? null
                                  : () {
                                      unfocus(context);
                                      familyHelper.addFamily();
                                    },
                              child: Text(
                                ksSend.tr,
                                style: (familyController.relationId.value == -1 || familyController.userId.value == -1)
                                    ? semiBold16TextStyle(cIconColor)
                                    : semiBold16TextStyle(cPrimaryColor),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (name != null)
                          Container(
                            width: width - 40,
                            height: 50,
                            color: cGreyBoxColor,
                            child: Row(
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: k8Padding),
                                //   child: Transform.scale(
                                //     scale: 0.85,
                                //     child: Icon(
                                //       BipHip.search,
                                //       size: screenWiseSize(kIconSize20, 4),
                                //     ),
                                //   ),
                                // ),
                                kW8sizedBox,
                                Text(
                                  name!,
                                  style: regular16TextStyle(cBlackColor),
                                ),
                              ],
                            ),
                          ),
                        if (name == null)
                          // RawAutocomplete(
                          //   textEditingController: globalController.searchController,
                          //   focusNode: familyController.addFamilyFocusNode,
                          //   optionsBuilder: (TextEditingValue textEditingValue) async {
                          //     return friendController.tempFriendList.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          //   },
                          //   onSelected: (option) {
                          //     globalController.searchController.text = option;
                          //   },
                          //   optionsViewBuilder: (context, Function(String) onSelected, options) {
                          //     return Align(
                          //       alignment: Alignment.topLeft,
                          //       child: SizedBox(
                          //         width: width - 40,
                          //         child: Material(
                          //           elevation: 4,
                          //           child: ListView.separated(
                          //             shrinkWrap: true,
                          //             padding: EdgeInsets.zero,
                          //             itemBuilder: (context, index) {
                          //               final option = options.elementAt(index);
                          //               return CustomListTile(
                          //                 title: Text(
                          //                   option.toString(),
                          //                   style: medium16TextStyle(cBlackColor),
                          //                 ),
                          //                 onPressed: () {
                          //                   unfocus(context);
                          //                   onSelected(option.toString());
                          //                   familyHelper.addFamilySetAutoComplete(option: option);
                          //                 },
                          //               );
                          //             },
                          //             separatorBuilder: (context, index) => Container(
                          //               height: 1,
                          //               color: cLineColor,
                          //             ),
                          //             itemCount: options.length,
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                          //     return Obx(() => CustomModifiedTextField(
                          //           borderRadius: h8,
                          //           controller: globalController.searchController,
                          //           focusNode: focusNode,
                          //           prefixIcon: BipHip.search,
                          //           suffixIcon: familyController.isFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                          //           hint: ksSearch.tr,
                          //           contentPadding: const EdgeInsets.symmetric(
                          //             vertical: k12Padding,
                          //           ),
                          //           textInputStyle: regular16TextStyle(cBlackColor),
                          //           onSuffixPress: () {
                          //             familyHelper.familySearchReset();
                          //           },
                          //           onSubmit: (v) {
                          //             unfocus(context);
                          //             familyController.isFamilySuffixIconVisible.value = false;
                          //           },
                          //           onChanged: (v) {
                          //             familyHelper.addSearchResultToFamilyList();
                          //           },
                          //         ));
                          //   },
                          // ),

                          // RawAutocomplete<String>(
                          //   textEditingController: globalController.searchController,
                          //   focusNode: familyController.addFamilyFocusNode,
                          //   // optionsBuilder: (TextEditingValue textEditingValue) async {
                          //   //   // Filter the options based on the current input value
                          //   //   return friendController.tempFriendList.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase())).toList();
                          //   // },
                          //   // optionsBuilder: (TextEditingValue textEditingValue) async {
                          //   //   // Filter the tempFriendList based on the current input value
                          //   //   List<String> filteredOptions = [];
                          //   //   for (int i = 0; i < friendController.tempFriendList.length; i += 2) {
                          //   //     String name = friendController.tempFriendList[i];
                          //   //     String imageUrl = friendController.tempFriendList[i + 1];
                          //   //     if (name.toLowerCase().contains(textEditingValue.text.toLowerCase())) {
                          //   //       filteredOptions.add(name);
                          //   //       filteredOptions.add(imageUrl);
                          //   //     }
                          //   //   }
                          //   //   return filteredOptions;
                          //   // },
                          //   optionsBuilder: (TextEditingValue textEditingValue) async {
                          //     // Initialize an empty list to hold the filtered options
                          //     List<String> filteredOptions = [];

                          //     // Iterate over the tempFriendList in steps of 2 to get pairs
                          //     for (int i = 0; i < friendController.tempFriendList.length; i += 2) {
                          //       // Get the name and image URL from the tempFriendList
                          //       String name = friendController.tempFriendList[i];
                          //       String imageUrl = friendController.tempFriendList[i + 1];

                          //       // Check if the name contains the current input text
                          //       if (name.toLowerCase().contains(textEditingValue.text.toLowerCase())) {
                          //         // Add the name and image URL to the filtered options
                          //         filteredOptions.add(name);
                          //         filteredOptions.add(imageUrl);
                          //       }
                          //     }

                          //     // Return the filtered options
                          //     return filteredOptions;
                          //   },

                          //   onSelected: (option) {
                          //     globalController.searchController.text = option;
                          //   },
                          //   optionsViewBuilder: (context, Function(String) onSelected, options) {
                          //     // Check if the options list is empty
                          //     if (options.isEmpty) {
                          //       // Return an empty container or another placeholder widget
                          //       return Container();
                          //     }

                          //     // Create a map to associate each name with its corresponding image URL
                          //     Map<String, String> nameToImageMap = {};
                          //     for (int i = 0; i < options.length; i += 2) {
                          //       // Get the name and image URL from the options list
                          //       final name = options.elementAt(i).toString();
                          //       final imageUrl = options.elementAt(i + 1).toString();

                          //       // Add the name and image URL to the map
                          //       nameToImageMap[name] = imageUrl;
                          //     }

                          //     return Align(
                          //       alignment: Alignment.topLeft,
                          //       child: SizedBox(
                          //         width: width - 40,
                          //         child: Material(
                          //           elevation: 4,
                          //           child: ListView.separated(
                          //             shrinkWrap: true,
                          //             padding: EdgeInsets.zero,
                          //             itemBuilder: (context, index) {
                          //               // Get the name and image URL from the map
                          //               final name = options.elementAt(index * 2).toString();
                          //               final imageUrl = nameToImageMap[name];

                          //               return ListTile(
                          //                 leading: CircleAvatar(
                          //                   backgroundImage: NetworkImage(imageUrl!), // Use AssetImage for local images
                          //                 ),
                          //                 title: Text(
                          //                   name,
                          //                   style: medium16TextStyle(cBlackColor),
                          //                 ),
                          //                 onTap: () {
                          //                   unfocus(context);
                          //                   onSelected(name);
                          //                   familyHelper.addFamilySetAutoComplete(option: name);
                          //                 },
                          //               );
                          //             },
                          //             separatorBuilder: (context, index) => Container(
                          //               height: 1,
                          //               color: cLineColor,
                          //             ),
                          //             itemCount: options.length, // Divide by 2 since there are pairs of strings
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                          //     return Obx(() => CustomModifiedTextField(
                          //           borderRadius: h8,
                          //           controller: globalController.searchController,
                          //           focusNode: focusNode,
                          //           prefixIcon: BipHip.search,
                          //           suffixIcon: familyController.isFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                          //           hint: ksSearch.tr,
                          //           contentPadding: const EdgeInsets.symmetric(
                          //             vertical: k12Padding,
                          //           ),
                          //           textInputStyle: regular16TextStyle(cBlackColor),
                          //           onSuffixPress: () {
                          //             familyHelper.familySearchReset();
                          //           },
                          //           onSubmit: (v) {
                          //             unfocus(context);
                          //             familyController.isFamilySuffixIconVisible.value = false;
                          //           },
                          //           onChanged: (v) {
                          //             familyHelper.addSearchResultToFamilyList();
                          //           },
                          //         ));
                          //   },
                          // ),
                          RawAutocomplete<String>(
                            textEditingController: globalController.searchController,
                            focusNode: familyController.addFamilyFocusNode,
                            optionsBuilder: (TextEditingValue textEditingValue) async {
                              // return friendController.temporaryFriendList.where((word) => word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                              // Filter the tempFriendList based on the current input value
                              List<String> filteredOptions = [];
                              for (int i = 0; i < friendController.temporaryFriendList.length; i += 2) {
                                String name = friendController.temporaryFriendList[i];
                                if (name.toLowerCase().contains(textEditingValue.text.toLowerCase())) {
                                  filteredOptions.add(name);
                                  filteredOptions.add(friendController.temporaryFriendList[i + 1]); // Add the image URL
                                }
                              }
                              return filteredOptions;
                            },
                            onSelected: (option) {
                              globalController.searchController.text = option;
                            },
                            optionsViewBuilder: (context, Function(String) onSelected, options) {
                              // Create a map to associate each name with its corresponding image URL
                              Map<String, String> nameToImageMap = {};
                              for (int i = 0; i < options.length; i += 2) {
                                final name = options.elementAt(i).toString();
                                final imageUrl = options.elementAt(i + 1).toString();
                                nameToImageMap[name] = imageUrl;
                              }

                              return Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Material(
                                    elevation: 4,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        // Calculate the actual index in the original list
                                        int actualIndex = index * 2;
                                        final name = options.elementAt(actualIndex).toString();
                                        final imageUrl = nameToImageMap[name];

                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(imageUrl!), // Use AssetImage for local images
                                          ),
                                          title: Text(
                                            name,
                                            style: medium16TextStyle(cBlackColor),
                                          ),
                                          onTap: () {
                                            unfocus(context);
                                            onSelected(name);
                                            familyHelper.addFamilySetAutoComplete(option: name);
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) => Container(
                                        height: 1,
                                        color: cLineColor,
                                      ),
                                      itemCount: options.length ~/ 2, // Divide by 2 since there are pairs of strings
                                    ),
                                  ),
                                ),
                              );
                            },
                            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                              return Obx(() => CustomModifiedTextField(
                                    borderRadius: h8,
                                    controller: globalController.searchController,
                                    focusNode: focusNode,
                                    prefixIcon: BipHip.search,
                                    suffixIcon: familyController.isFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                    hint: ksSearch.tr,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: k12Padding,
                                    ),
                                    textInputStyle: regular16TextStyle(cBlackColor),
                                    onSuffixPress: () {
                                      familyHelper.familySearchReset();
                                    },
                                    onSubmit: (v) {
                                      unfocus(context);
                                      familyController.isFamilySuffixIconVisible.value = false;
                                    },
                                    onChanged: (v) {
                                      familyHelper.addSearchResultToFamilyList();
                                    },
                                  ));
                            },
                          ),
                        kH12sizedBox,
                        CustomSelectionButton(
                          hintText: ksSelectRelation.tr,
                          text: familyController.relation.value,
                          onPressed: () async {
                            unFocus(context);
                            familyHelper.setRelationBottomSheetValue();
                            familyController.isFamilyRelationListLoading.value = true;
                            Get.find<GlobalController>().commonBottomSheet(
                              context: context,
                              isBottomSheetRightButtonActive: familyController.familyRelationBottomSheetRightButtonState,
                              isScrollControlled: true,
                              isSearchShow: false,
                              bottomSheetHeight: height * .9,
                              content: Obx(() => familyController.isFamilyRelationListLoading.value ? const RelationContentShimmer() : RelationContent()),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                unfocus(context);
                                familyHelper.selectRelation();
                              },
                              rightText: ksDone.tr,
                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                              title: ksSelectRelation.tr,
                              isRightButtonShow: true,
                            );
                            await familyController.getFamilyRelationList();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (familyController.isSendFamilyRequestLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (familyController.isSendFamilyRequestLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
