import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/shimmers/home/home_page_details_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_details_widget.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/post/comment_textfield.dart';

class HomePostDetails extends StatelessWidget {
  HomePostDetails({super.key});

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.isPostDetailsPageLoading.value
          ? const HomePostDetailsShimmer()
          : Container(
              color: cWhiteColor,
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: height,
                  child: Scaffold(
                    backgroundColor: cWhiteColor,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kAppBarSize),
                      //* info:: appBar
                      child: CustomAppBar(
                        hasBackButton: true,
                        isCenterTitle: true,
                        title: 'Wahid Murad',
                        onBack: () {
                          Get.back();
                        },
                      ),
                    ),
                    floatingActionButton: Container(
                      decoration: const BoxDecoration(color: cWhiteColor, border: Border(top: BorderSide(color: cLineColor))),
                      height: 112,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: k12Padding,
                          horizontal: k20Padding,
                        ),
                        child: CommentTextField(
                          hintText: '${ksWriteAComment.tr} ...',
                        ),
                      ),
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    body: SizedBox(
                      height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: k12Padding),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                child: PostUpperContainer(userName: 'Wahid Murad', isCategorized: false, privacy: BipHip.world, postTime: '1hr'),
                              ),
                              kH12sizedBox,
                              CommonPostDetailsWidget(
                                isTextualPost: true,
                                mediaList: homeController.postData.value!.post.imageUrls,
                                isCommentShown: true,
                                showBottomSection: true,
                                postText: homeController.postData.value!.post.content,
                              ),
                              const SizedBox(
                                height: 110,
                              ),
                            ],
                          ),
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
