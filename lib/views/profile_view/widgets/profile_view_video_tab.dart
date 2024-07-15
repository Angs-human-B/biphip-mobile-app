import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_video_content_list_widget.dart';
import 'package:intl/intl.dart';

class ProfileViewVideoTab extends StatelessWidget {
  ProfileViewVideoTab({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

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
                      itemCount: profileViewController.videoList.length,
                      itemBuilder: (context, index) {
                        return VideoContentListWidget(
                          videoPreviewImage: profileViewController.videoList[index].fullPath??"",
                          videoTitle: profileViewController.videoList[index].title??ksNA,
                          videoPublishedDate: DateFormat('dd MMM, yyyy').format(profileViewController.videoList[index].createdAt??DateTime.now()),
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
