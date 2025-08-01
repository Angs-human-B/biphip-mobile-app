import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class PhotoDetails extends StatelessWidget {
  PhotoDetails({super.key});

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
              title: ksPhotos.tr,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Container(
                      decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                      height: 400,
                      width: (width - 40),
                      child: ClipRRect(
                        borderRadius: k8CircularBorderRadius,
                        child: Image.network(
                          Get.find<GalleryController>().imageDetailsData.value!.image!.fullPath.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.user,
                            size: kIconSize200,
                            color: cIconColor,
                          ),
                          loadingBuilder: imageLoadingBuilder,
                          frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                            return child;
                          },
                        ),
                      ),
                    ),
                    kH20sizedBox,
         
                    const CustomDivider(),
                    kH20sizedBox,
                    Text(
                      ksComment.tr,
                      style: semiBold14TextStyle(cBlackColor),
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

class InteractionStats extends StatelessWidget {
  const InteractionStats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const Icon(
                BipHip.view,
                color: cGreenColor,
              ),
              kH4sizedBox,
              Text(
                '7.1 k',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.love,
                color: cRedColor,
              ),
              kH4sizedBox,
              Text(
                '1.1 k',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.comment,
                color: cStoryTellingColor,
              ),
              kH4sizedBox,
              Text(
                '790',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.share,
                color: cPrimaryColor,
              ),
              kH4sizedBox,
              Text(
                '440',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          ),
          kW20sizedBox,
          Column(
            children: [
              const Icon(
                BipHip.giftNew,
                color: cSecondaryColor,
              ),
              kH4sizedBox,
              Text(
                '440',
                style: semiBold8TextStyle(cBlackColor),
              )
            ],
          )
        ],
      ),
    );
  }
}

class UserInteractionView extends StatelessWidget {
  const UserInteractionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            const SizedBox(
              width: 75,
              height: 21,
            ),
            for (int index = 0; index < 6; index++)
              Positioned(
                left: index * 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: cPrimaryColor,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: cPrimaryColor, width: 1),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      kiProfileDefaultImageUrl,
                      fit: BoxFit.cover,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
        kH10sizedBox,
        Text(
          'Tanmoy and 432+ more liked',
          overflow: TextOverflow.clip,
          style: semiBold8TextStyle(cBlackColor),
        )
      ],
    );
  }
}
