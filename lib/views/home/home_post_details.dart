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
                        title: homeController.postData.value!.post.user!.fullName!,
                        onBack: () {
                          Get.back();
                        },
                      ),
                    ),
                    floatingActionButton: Container(
                      decoration: const BoxDecoration(color: cWhiteColor, border: Border(top: BorderSide(color: cLineColor))),
                      height: 120,
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
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                child: PostUpperContainer(
                                  taggedFriend: homeController.postData.value!.post.taggedFriends,
                                  userName: homeController.postData.value!.post.user!.fullName!,
                                  isCategorized: false,
                                  privacy: BipHip.world,
                                  postTime: homeController.postTimeDifference(homeController.postData.value!.post.createdAt),
                                  userImage: homeController.postData.value!.post.user!.profilePicture!,
                                  category:
                                      homeController.postData.value!.post.postCategory == null ? null : homeController.postData.value!.post.postCategory!.name,
                                  categoryIcon: homeController.postData.value!.post.postCategory == null
                                      ? null
                                      : homeController.getCategoryIcon(homeController.postData.value!.post.postCategory?.id),
                                  categoryIconColor: homeController.postData.value!.post.postCategory == null
                                      ? null
                                      : homeController.getCategoryColor(homeController.postData.value!.post.postCategory?.id),
                                  kidName: homeController.postData.value!.post.kid == null ? null : homeController.postData.value!.post.kid!.name, //API
                                  kidAge:
                                      homeController.postData.value!.post.kid == null ? null : homeController.postData.value!.post.kid!.age.toString(), //API
                                  brandName: homeController.postData.value!.post.brand == null ? null : homeController.postData.value!.post.brand!.name, //API
                                ),
                              ),
                              kH12sizedBox,
                              CommonPostDetailsWidget(
                                mediaList: homeController.postData.value!.post.images,
                                isCommentShown: true,
                                showBottomSection: true,
                                postText: homeController.postData.value!.post.postCategory?.name == 'News'
                                    ? homeController.postData.value!.post.description ?? ''
                                    : homeController.postData.value!.post.content ?? '', //API
                                // title: homeController.postData.value!.post.title, //API
                                title: homeController.postData.value!.post.title, //API
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
