import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/post/post_button_widget.dart';
import 'package:intl/intl.dart';

class PostTab extends StatelessWidget {
  PostTab({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: cWhiteColor,
              child: Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ksDetails.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH12sizedBox,
                      LinkUpIconTextRow(
                        icon: BipHip.birthday,
                        onPressed: null,
                        prefixText: '${ksBornOn.tr} ',
                        suffixText: DateFormat("MMMM dd, yyyy").format(profileController.userData.value!.dob!),
                      ),
                      if (profileController.currentCityData.value?.city != null && profileController.currentCityData.value?.isCurrent == 1)
                        LinkUpIconTextRow(
                          icon: BipHip.address,
                          prefixText: '${ksLivesIn.tr} ',
                          suffixText: '${profileController.currentCityData.value?.city}',
                          onPressed: null,
                        ),
                      CustomTextButton(
                        text: ksSeeYourAboutInfo.tr,
                        textStyle: medium16TextStyle(cPrimaryColor),
                        onPressed: () {
                          Get.toNamed(krEditProfile);
                        },
                        mainAxisAlignment: MainAxisAlignment.start,
                        padding: EdgeInsets.zero,
                      ),
                      kH12sizedBox
                    ],
                  ),
                ),
              ),
            ),
            kH12sizedBox,
            Container(
              color: cWhiteColor,
              child: CustomPostButton(
                name: checkNullOrStringNull(Get.find<GlobalController>().userLastName.value.toString().trim()) != null
                    ? Get.find<GlobalController>().userLastName.value.toString()
                    : Get.find<GlobalController>().userName.value.toString(),
                profilePic: Get.find<GlobalController>().userImage.value.toString(),
                onPressed: () {
                  Get.find<CreatePostController>().isPostedFromProfile.value = true;
                  CreatePostHelper().resetCreatePostData();
                  Get.find<KidsController>().isRouteFromKid.value = false;
                  Get.toNamed(krCreatePost);
                },
              ),
            ),
            kH12sizedBox,
            Container(
              color: cWhiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k12Padding),
                    child: Text(
                      ksCatagories.tr,
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: 50,
                    child: ListView.builder(
                      itemCount: Get.find<CreatePostController>().createPostCategoryList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: k10Padding),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, i) {
                        return Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                            child: CustomChoiceChips(
                              label: Get.find<CreatePostController>().createPostCategoryList[i].name ?? "",
                              isSelected: (profileController.interestCatagoriesIndex.value == Get.find<CreatePostController>().createPostCategoryList[i].id),
                              onSelected: (value) {
                                profileController.interestCatagoriesIndex.value = Get.find<CreatePostController>().createPostCategoryList[i].id!;
                                if (profileController.interestCatagoriesIndex.value == 0) {
                                  Get.find<HomeController>().getTimelinePostList();
                                } else if (profileController.interestCatagoriesIndex.value != 0) {
                                  Get.find<HomeController>().getFilteredTimelinePostList(categoryId: profileController.interestCatagoriesIndex.value, type: 2);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            kH12sizedBox,
            Get.find<HomeController>().isTimelinePostLoading.value
                ? const PostCommonShimmer()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => kH8sizedBox,
                    itemCount: Get.find<GlobalController>().commonPostList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: cWhiteColor,
                        width: width,
                        child: CommonPostWidget(
                          postIndex: index,
                        ),
                      );
                    }),
            if (Get.find<GlobalController>().commonPostList.isNotEmpty &&
                homeController.timelinePostListScrolled.value &&
                homeController.timelinePostListSubLink.value != null)
              const HomePagePaginationShimmer(),
            kH8sizedBox,
          ],
        ));
  }
}

class LinkUpIconTextRow extends StatelessWidget {
  const LinkUpIconTextRow({super.key, required this.icon, required this.prefixText, this.onPressed, required this.suffixText});

  final IconData icon;
  final String prefixText, suffixText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: k12Padding),
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: cIconColor,
              size: screenWiseSize(kIconSize20, 4),
            ),
            kW12sizedBox,
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: prefixText, style: regular14TextStyle(cBlackColor)),
                    TextSpan(text: suffixText, style: semiBold14TextStyle(cBlackColor))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
