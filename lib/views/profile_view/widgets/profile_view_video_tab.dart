import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_video_content_list_widget.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:intl/intl.dart';

class ProfileViewVideoTab extends StatelessWidget {
  ProfileViewVideoTab({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  final ProfileViewHelper profileViewHelper = ProfileViewHelper();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (height * 0.42) - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => profileViewController.isVideoListLoading.value
                  ? const ProfileViewVideoShimmer()
                  : (profileViewController.allPhotoList.isEmpty ||
                          profileViewController.kidAllImageList.isEmpty ||
                          profileViewController.storeAllImageList.isEmpty)
                      ? Container(
                          width: width - 40,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(k8BorderRadius),
                            border: Border.all(width: 1, color: cLineColor),
                          ),
                          child: EmptyView(title: ksNoVideoAvailable.tr))
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: profileViewHelper.getUserKidOrStoreVideosListLength(type: profileViewController.profileViewType.value),
                                  itemBuilder: (context, index) {
                                    var item = profileViewHelper.getUserKidOrStoreVideosList(type: profileViewController.profileViewType.value);
                                    return VideoContentListWidget(
                                      videoPreviewImage: item[index].fullPath ?? "",
                                      videoTitle: item[index].title ?? ksNA.tr,
                                      videoPublishedDate: DateFormat('dd MMM, yyyy').format(item[index].createdAt ?? DateTime.now()),
                                      postIndex: index,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileViewVideoShimmer extends StatelessWidget {
  const ProfileViewVideoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH12sizedBox,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => kH16sizedBox,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: k8CircularBorderRadius,
                            child: ShimmerCommon(
                              widget: Container(
                                color: cWhiteColor,
                                height: 150,
                                width: (width - 40),
                              ),
                            ),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              height: 16,
                              width: (width - 40) / 2,
                            ),
                          ),
                          kH4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              height: 16,
                              width: (width - 40) / 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
