import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_video_content_list_widget.dart';
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileViewHelper.getUserKidOrStoreVideosListLength(type: profileViewController.profileViewType.value),
                      itemBuilder: (context, index) {
                        var item = profileViewHelper.getUserKidOrStoreVideosList(type: profileViewController.profileViewType.value);
                        return  VideoContentListWidget(
                          videoPreviewImage: item[index].fullPath??"",
                          videoTitle: item[index].title??ksNA.tr,
                           videoPublishedDate: DateFormat('dd MMM, yyyy').format(item[index].createdAt??DateTime.now()),
                           postIndex: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
