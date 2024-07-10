import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/shimmers/home/home_page_shimmer.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/menu/profile/widgets/profile_post_tab.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_friend_family_widget.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class ProfileViewPostTab extends StatelessWidget {
  ProfileViewPostTab({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: cWhiteColor,
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
                    if (profileViewController.userProfileViewData.value!.currentCity?.city != null)
                      LinkUpIconTextRow(
                        icon: BipHip.address,
                        onPressed: null,
                        prefixText: '${ksLivesIn.tr} ',
                        suffixText: profileViewController.userProfileViewData.value!.currentCity?.city ?? ksNA.tr,
                      ),
                    if (profileViewController.userProfileViewData.value!.currentCity?.city != null &&
                        profileViewController.userProfileViewData.value?.currentCity?.isCurrent == 1)
                      LinkUpIconTextRow(
                        icon: BipHip.location,
                        prefixText: '${ksFrom.tr} ',
                        suffixText: profileViewController.userProfileViewData.value?.currentCity?.city ?? ksNA.tr,
                        onPressed: null,
                      ),
                    CustomTextButton(
                      text: "See ${profileViewController.userProfileData.value?.lastName}'s about info",
                      textStyle: medium16TextStyle(cPrimaryColor),
                      onPressed: () {
                        Get.toNamed(krProfileViewAbout);
                      },
                      mainAxisAlignment: MainAxisAlignment.start,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            kH16sizedBox,
            Container(
              height: h8,
              color: cBackgroundColor,
            ),
            ProfileViewFriendFamilyWidget(),
            kH16sizedBox,
            Container(
              height: h8,
              color: cBackgroundColor,
            ),
            kH16sizedBox,
            Container(
              color: cWhiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Text(
                      ksCatagories.tr,
                      style: semiBold18TextStyle(cBlackColor),
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
                              isSelected:
                                  (profileViewController.interestCatagoriesIndex.value == Get.find<CreatePostController>().createPostCategoryList[i].id),
                              onSelected: (value) {
                                profileViewController.interestCatagoriesIndex.value = Get.find<CreatePostController>().createPostCategoryList[i].id!;
                                if (profileViewController.interestCatagoriesIndex.value == 0) {
                                  Get.find<HomeController>().getTimelinePostList();
                                } else if (profileViewController.interestCatagoriesIndex.value != 0) {
                                  Get.find<HomeController>()
                                      .getFilteredTimelinePostList(categoryId: profileViewController.interestCatagoriesIndex.value, type: 2);
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
