import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/tash%20or%20archive/common_undo_button.dart';
import 'package:bip_hip/views/menu/settings/tash%20or%20archive/common_white_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/profile_view/profile_view_controller.dart';
import '../../../../helpers/profile_view/profile_view_helper.dart';
import '../../../../shimmers/profile/profile_shimmer.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../../../home/widgets/common_post_widget.dart';
import '../how people will find you/modalsheetWidget.dart';

class ReviewPostsSettingsPage extends StatefulWidget {
  const ReviewPostsSettingsPage({Key? key}) : super(key: key);

  @override
  State<ReviewPostsSettingsPage> createState() =>
      _ReviewPostsSettingsPageState();
}

class _ReviewPostsSettingsPageState extends State<ReviewPostsSettingsPage> {
  final ProfileViewController profileViewController =
      Get.find<ProfileViewController>();
  // final HomeController homeController = Get.find<HomeController>();
  // final KidsController kidsController = Get.find<KidsController>();
  final ProfileViewHelper profileViewHelper = ProfileViewHelper();

  @override
  Widget build(BuildContext context) {
    // profileViewController.profileViewType.value = "profile";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            print(profileViewController.profileViewType.value);
            print(profileViewHelper.getUserKidOrStorePostsListLength(
                type: profileViewController.profileViewType.value));
            Get.back();
          },
          title: ksReviewPostsYouTaggedIn.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kH12sizedBox,
            profileViewController.isProfileViewPostLoading.value
                ? const PostCommonShimmer()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                separatorBuilder:(context, index)=>const CustomDivider(),
                    itemCount:Get.find<GlobalController>().commonPostList.length,
                        // profileViewHelper.getUserKidOrStorePostsListLength(
                        //     type: profileViewController.profileViewType.value),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: 15.h),
                          Container(
                            color: cWhiteColor,
                            width: width,
                            child: CommonPostWidget(
                              postIndex: index,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.92,
                            child: CommonBlueButton("Add to profile", null, (){}),
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.92,
                            child: CommonWhiteButton("Hide", null, (){}),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
