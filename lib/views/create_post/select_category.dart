import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/create_post/create_post_widget/common_category_button.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';

class SelectCategory extends StatelessWidget {
  SelectCategory({super.key});

  final CreatePostController _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: "Select Category",
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      _createPostController.selectCategoryTextChange(context);
                     
                    },
                    child: Text(
                      "Next",
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                    Text(
                      "ENTERTAINMENT",
                      style: regular14TextStyle(cSmallBodyTextColor),
                    ),
                    kH8sizedBox,
                    Wrap(
                      children: [
                        for (int i = 0; i < _createPostController.categoryList.length - 1; i++)
                          Obx(
                            () => CategoryComponent(
                              onPress: () {
                                _createPostController.selectCategoryStatusChange(i);
                              },
                              suffixWidget: Transform.scale(
                                scale: .7,
                                child: CustomRadioButton(
                                  onChanged: () {
                                    _createPostController.selectCategoryStatusChange(i);
                                  },
                                  isSelected: _createPostController.categoryStatusList[i],
                                ),
                              ),
                              icon: _createPostController.categoryList[i]['icon'],
                              iconColor: _createPostController.categoryList[i]['icon_color'],
                              iconSize: isDeviceScreenLarge() ? h20 : h16,
                              title: _createPostController.categoryList[i]['title'],
                              titleStyle: medium14TextStyle(cBlackColor),
                            ),
                          ),
                      ],
                    ),
                    kH8sizedBox,
                    Text(
                      "*To add kid category, you need to follow the further steps.",
                      style: regular12TextStyle(cPlaceHolderColor),
                    ),
                    kH16sizedBox,
                    const CustomDivider(),
                    kH16sizedBox,
                    Text(
                      "SELL",
                      style: regular14TextStyle(cSmallBodyTextColor),
                    ),
                    kH8sizedBox,
                    Obx(
                      () => CategoryComponent(
                        onPress: () {
                          _createPostController.selectCategoryStatusChange(_createPostController.categoryList.length - 1);
                        },
                        suffixWidget: Transform.scale(
                          scale: .7,
                          child: CustomRadioButton(
                            onChanged: () {
                              _createPostController.selectCategoryStatusChange(_createPostController.categoryList.length - 1);
                            },
                            isSelected: _createPostController.categoryStatusList[_createPostController.categoryList.length - 1],
                          ),
                        ),
                        icon: _createPostController.categoryList[_createPostController.categoryList.length - 1]['icon'],
                        iconColor: _createPostController.categoryList[_createPostController.categoryList.length - 1]['icon_color'],
                        iconSize: isDeviceScreenLarge() ? h20 : h16,
                        title: _createPostController.categoryList[_createPostController.categoryList.length - 1]['title'],
                        titleStyle: medium14TextStyle(cBlackColor),
                      ),
                    ),
                    kH8sizedBox,
                    Text(
                      "*You can sell all kind of product here. Including your brand on that will boost your selling.",
                      style: regular12TextStyle(cPlaceHolderColor),
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
