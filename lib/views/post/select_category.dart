import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/widgets/common_category_button.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class SelectCategory extends StatelessWidget {
  SelectCategory({super.key});

  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createPostHelper = CreatePostHelper();

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
              title: ksSelectCategory.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(right: h20, top: 15, bottom: 15),
                    child: createPostController.isPostCategoryListLoading.value
                        ? ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              width: 30,
                            ),
                          )
                        : TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              createPostHelper.selectCategoryTextChange(context);
                            },
                            child: Text(
                              ksNext.tr,
                              style: medium14TextStyle(cPrimaryColor),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          body: Obx(
            () => createPostController.isPostCategoryListLoading.value
                ? const SelectCategoryShimmer()
                : SizedBox(
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
                              ksEntertainmentAllCap.tr,
                              style: regular14TextStyle(cSmallBodyTextColor),
                            ),
                            kH8sizedBox,
                            Wrap(
                              children: [
                                for (int i = 0; i < createPostController.categoryList.length - 1; i++)
                                  Obx(
                                    () => CategoryComponent(
                                      onPress: () {
                                        createPostHelper.selectCategoryStatusChange(i);
                                      },
                                      suffixWidget: Transform.scale(
                                        scale: .7,
                                        child: CustomRadioButton(
                                          onChanged: () {
                                            createPostHelper.selectCategoryStatusChange(i);
                                          },
                                          isSelected: createPostController.categoryStatusList[i],
                                        ),
                                      ),
                                      icon: createPostController.categoryList[i]['icon'],
                                      iconColor: createPostController.categoryList[i]['icon_color'],
                                      iconSize: isDeviceScreenLarge() ? h20 : h16,
                                      title: createPostController.categoryList[i]['name'],
                                      titleStyle: medium14TextStyle(cBlackColor),
                                    ),
                                  ),
                              ],
                            ),
                            kH8sizedBox,
                            Text(
                              "*${ksAddKidInstructions.tr}",
                              style: regular12TextStyle(cPlaceHolderColor),
                            ),
                            kH16sizedBox,
                            const CustomDivider(),
                            kH16sizedBox,
                            Text(
                              ksSellAllCap.tr,
                              style: regular14TextStyle(cSmallBodyTextColor),
                            ),
                            kH8sizedBox,
                            Obx(
                              () => CategoryComponent(
                                onPress: () {
                                  createPostHelper.selectCategoryStatusChange(createPostController.categoryList.length - 1);
                                },
                                suffixWidget: Transform.scale(
                                  scale: .7,
                                  child: CustomRadioButton(
                                    onChanged: () {
                                      createPostHelper.selectCategoryStatusChange(createPostController.categoryList.length - 1);
                                    },
                                    isSelected: createPostController.categoryStatusList[createPostController.categoryList.length - 1],
                                  ),
                                ),
                                icon: createPostController.categoryList[createPostController.categoryList.length - 1]['icon'],
                                iconColor: createPostController.categoryList[createPostController.categoryList.length - 1]['icon_color'],
                                iconSize: isDeviceScreenLarge() ? h20 : h16,
                                title: createPostController.categoryList[createPostController.categoryList.length - 1]['title'],
                                titleStyle: medium14TextStyle(cBlackColor),
                              ),
                            ),
                            kH8sizedBox,
                            Text(
                              "*${ksSellInformation.tr}",
                              style: regular12TextStyle(cPlaceHolderColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class SelectCategoryShimmer extends StatelessWidget {
  const SelectCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              ShimmerCommon(
                widget: Container(
                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                  height: 14,
                  width: 100,
                ),
              ),
              kH8sizedBox,
              Wrap(
                children: [
                  for (int i = 0; i < 6; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      child: ShimmerCommon(
                        widget: Container(
                          decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                          height: isDeviceScreenLarge() ? h36 : h32,
                          width: 100,
                        ),
                      ),
                    ),
                ],
              ),
              kH8sizedBox,
              ShimmerCommon(
                widget: Container(
                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                  height: 10,
                  width: width * 0.7,
                ),
              ),
              kH16sizedBox,
              const CustomDivider(),
              kH16sizedBox,
              ShimmerCommon(
                widget: Container(
                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                  height: 14,
                  width: 30,
                ),
              ),
              kH8sizedBox,
              ShimmerCommon(
                widget: Container(
                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k4CircularBorderRadius),
                  height: isDeviceScreenLarge() ? h36 : h32,
                  width: 100,
                ),
              ),
              kH8sizedBox,
              ShimmerCommon(
                widget: Container(
                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                  height: 10,
                  width: width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KidListShimmer extends StatelessWidget {
  const KidListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k16Padding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: CustomListTile(
                  borderColor: cLineColor,
                  leading: ShimmerCommon(
                    widget: Container(
                      decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                      height: h24,
                      width: h24,
                    ),
                  ),
                  title: ShimmerCommon(
                    widget: Container(
                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                      height: 14,
                      width: 80,
                    ),
                  ),
                  trailing: ShimmerCommon(
                    widget: Container(
                      decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                      height: 20,
                      width: 20,
                    ),
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
