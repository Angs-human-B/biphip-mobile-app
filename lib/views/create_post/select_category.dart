// import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/create_post/create_post_widget/common_category_button.dart';

class SelectCategory extends StatelessWidget {
  SelectCategory({super.key});

  // final CreatePostController _createPostController = Get.find<CreatePostController>();

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
                    onPressed: () {},
                    child: Text(
                      "Continue",
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
                        CategoryComponent(
                          suffixWidget: Transform.scale(
                            scale: .7,
                            child: CustomRadioButton(
                              onChanged: () {},
                              isSelected: true,
                            ),
                          ),
                          icon: BipHip.poetry,
                          iconColor: cRedColor,
                          iconSize: isDeviceScreenLarge() ? h20 : h16,
                          title: "Poetry",
                          titleStyle: medium14TextStyle(cBlackColor),
                        ),
                        CategoryComponent(
                          suffixWidget: Transform.scale(
                            scale: .7,
                            child: CustomRadioButton(
                              onChanged: () {},
                              isSelected: true,
                            ),
                          ),
                          icon: BipHip.painting,
                          iconColor: cPaintingColor,
                          iconSize: isDeviceScreenLarge() ? h20 : h16,
                          title: "Painting",
                          titleStyle: medium14TextStyle(cBlackColor),
                        ),
                        CategoryComponent(
                          suffixWidget: Transform.scale(
                            scale: .7,
                            child: CustomRadioButton(
                              onChanged: () {},
                              isSelected: true,
                            ),
                          ),
                          icon: BipHip.kids,
                          iconColor: cKidsColor,
                          iconSize: isDeviceScreenLarge() ? h20 : h16,
                          title: "Kids",
                          titleStyle: medium14TextStyle(cBlackColor),
                        ),
                        CategoryComponent(
                          suffixWidget: Transform.scale(
                            scale: .7,
                            child: CustomRadioButton(
                              onChanged: () {},
                              isSelected: true,
                            ),
                          ),
                          icon: BipHip.storytelling,
                          iconColor: cStoryTellingColor,
                          iconSize: isDeviceScreenLarge() ? h20 : h16,
                          title: "Storytelling",
                          titleStyle: medium14TextStyle(cBlackColor),
                        ),
                        CategoryComponent(
                          suffixWidget: Transform.scale(
                            scale: .7,
                            child: CustomRadioButton(
                              onChanged: () {},
                              isSelected: true,
                            ),
                          ),
                          icon: BipHip.photography,
                          iconColor: cPhotographyColor,
                          iconSize: isDeviceScreenLarge() ? h20 : h16,
                          title: "Photography",
                          titleStyle: medium14TextStyle(cBlackColor),
                        ),
                        CategoryComponent(
                          suffixWidget: Transform.scale(
                            scale: .7,
                            child: CustomRadioButton(
                              onChanged: () {},
                              isSelected: true,
                            ),
                          ),
                          icon: BipHip.newsFill,
                          iconColor: cBlackColor,
                          iconSize: isDeviceScreenLarge() ? h20 : h16,
                          title: "News",
                          titleStyle: medium14TextStyle(cBlackColor),
                        ),
                      ],
                    )
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
