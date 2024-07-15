import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatelessWidget {
  VideoDetails({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final CreatePostController createPostController = Get.find<CreatePostController>();

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
              title: ksVideos.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    kH24sizedBox,
                    SizedBox(
                      height: 200,
                      width: width,
                      child: ClipRRect(
                        borderRadius: k8CircularBorderRadius,
                        child: VideoPlayer(profileController.videoPlayerController),
                      ),
                    ),

                    kH20sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kW8sizedBox,
                        Stack(
                          children: [
                            SizedBox(
                              width: (createPostController.category.value == "Kids" || createPostController.category.value == "Selling") ? 70 : h45,
                              child: Row(
                                children: [
                                  Container(
                                    height: h45,
                                    width: h45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      kiProfileDefaultImageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (createPostController.category.value == "Kids" || createPostController.category.value == "Selling")
                              Positioned(
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: Container(
                                  height: h45,
                                  width: h45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    kiProfilePicImageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        kW8sizedBox,
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: RichText(
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Jane Smith',
                                                style: semiBold16TextStyle(cBlackColor),
                                              ),
                                              if (createPostController.isTagAdded.value)
                                                TextSpan(
                                                  text: ' is with ',
                                                  style: regular16TextStyle(cBlackColor),
                                                ),
                                              if (createPostController.isTagAdded.value)
                                                TextSpan(
                                                  text: 'Shohag Jalal & 8 others',
                                                  style: semiBold16TextStyle(cBlackColor),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kH4sizedBox,
                              Obx(
                                () => Row(
                                  children: [
                                    CustomElevatedButton(
                                      isCustomButton: true,
                                      label: createPostController.createPostSelectedPrivacy.value,
                                      prefixIcon: createPostController.createPostSelectedPrivacyIcon.value,
                                      onPressed: () {},
                                      buttonHeight: 22,
                                      buttonColor: cGreyBoxColor,
                                      prefixIconColor: cBlackColor,
                                      textStyle: medium12TextStyle(cBlackColor),
                                    ),
                                    kW8sizedBox,
                                    CustomElevatedButton(
                                      label: createPostController.category.value == "" ? ksSelectCategory.tr : createPostController.category.value,
                                      prefixIcon: createPostController.category.value == "" ? null : createPostController.categoryIcon.value,
                                      prefixIconColor: createPostController.category.value == "" ? null : createPostController.categoryIconColor.value,
                                      onPressed: () {},
                                      buttonHeight: 22,
                                      isCustomButton: true,
                                      buttonColor: cGreyBoxColor,
                                      textStyle: medium12TextStyle(cBlackColor),
                                    ),
                                    if (createPostController.category.value == "Selling") kW8sizedBox,
                                    if (createPostController.category.value == "Selling")
                                      CustomElevatedButton(
                                        label: ksPostType.tr,
                                        onPressed: () {},
                                        buttonHeight: 22,
                                        isCustomButton: true,
                                        prefixIcon: BipHip.webLink,
                                        buttonColor: cGreyBoxColor,
                                        prefixIconColor: cPrimaryColor,
                                        textStyle: medium12TextStyle(cBlackColor),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    kH20sizedBox,

                    const CustomDivider(),
                    kH16sizedBox,
                    Row(
                      children: [
                        Text(
                          ksComment.tr,
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    kH16sizedBox,
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
