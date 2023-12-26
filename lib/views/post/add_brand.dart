import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBrandPage extends StatelessWidget {
  AddBrandPage({super.key});

  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createHelper = CreatePostHelper();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
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
                    title: ksAddBrand.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: h20),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: createPostController.isSaveBrandButtonEnabled.value
                              ? () async {
                                  createPostController.createLinkList();
                                  // await createPostController.addBrand();//!Api call
                                  createPostController.isBrandAdded.value = true;
                                  createPostController.selectedBrandName.value = createPostController.brandNameTextEditingController.text;
                                  createPostController.selectedBrandImageFile.value = createPostController.brandImageFile.value;
                                  Get.back();
                                  createHelper.resetAddBrandPage();
                                }
                              : null,
                          child: Text(
                            ksAdd.tr,
                            style: createPostController.isSaveBrandButtonEnabled.value ? medium14TextStyle(cPrimaryColor) : medium14TextStyle(cLineColor2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: cBlackColor,
                              ),
                              child: Image.file(
                                createPostController.brandImageFile.value,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Padding(
                                  padding: EdgeInsets.only(top: 10, right: 5),
                                  child: Icon(
                                    BipHip.imageFile,
                                    size: kIconSize60,
                                    color: cIconColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                          OutLinedButton(
                            onPress: () {
                              globalController.commonBottomSheet(
                                  context: context,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: () {},
                                  rightText: '',
                                  rightTextStyle: regular14TextStyle(cBiddingColor),
                                  title: ksUploadPhoto.tr,
                                  isRightButtonShow: false,
                                  isScrollControlled: false,
                                  bottomSheetHeight: 180,
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomElevatedButton(
                                        label: ksAddPhoto.tr,
                                        prefixIcon: BipHip.camera,
                                        prefixIconColor: cIconColor,
                                        suffixIconColor: cIconColor,
                                        onPressed: () async {
                                          await globalController.selectImageSource(createPostController.isBrandImageChanged,
                                              createPostController.brandImageLink, createPostController.brandImageFile, 'camera', true);
                                          createPostController.checkCanSaveBrand();
                                        },
                                        buttonHeight: h32,
                                        buttonWidth: width - 40,
                                        buttonColor: cWhiteColor,
                                        borderColor: cLineColor,
                                        textStyle: semiBold14TextStyle(cBlackColor),
                                      ),
                                      kH16sizedBox,
                                      CustomElevatedButton(
                                        label: ksChooseFromGallery.tr,
                                        prefixIcon: BipHip.photo,
                                        prefixIconColor: cIconColor,
                                        suffixIconColor: cIconColor,
                                        onPressed: () async {
                                          await globalController.selectImageSource(createPostController.isBrandImageChanged,
                                              createPostController.brandImageLink, createPostController.brandImageFile, 'gallery', true);
                                          createPostController.checkCanSaveBrand();
                                        },
                                        buttonHeight: h32,
                                        buttonWidth: width - 40,
                                        buttonColor: cWhiteColor,
                                        borderColor: cLineColor,
                                        textStyle: semiBold14TextStyle(cBlackColor),
                                      ),
                                    ],
                                  ));
                            },
                            buttonText: ksUploadImage.tr,
                            borderColor: cPrimaryColor,
                            buttonHeight: 32,
                            buttonWidth: 150,
                            suffixWidget: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                BipHip.addImage,
                                size: isDeviceScreenLarge() ? h20 : h16,
                                color: cPrimaryColor,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isDeviceScreenLarge() ? kH40sizedBox : kH30sizedBox,
                              CustomModifiedTextField(
                                controller: createPostController.brandNameTextEditingController,
                                hint: ksWriteBrandName.tr,
                                onChanged: (text) {
                                  createPostController.checkCanSaveBrand();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                              CustomModifiedTextField(
                                controller: createPostController.businessTypeTextEditingController,
                                hint: ksSelectBusinessType.tr,
                                onChanged: (text) {
                                  createPostController.checkCanSaveBrand();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                              Text(
                                ksAddSocialLinks.tr,
                                style: medium14TextStyle(cBlackColor),
                              ),
                              kH8sizedBox,
                              // AddLinkTextFields(
                              //   textEditingController: createPostController.brandWebLinkTextEditingController,
                              //   iconImage: kiWebSvgImageUrl,
                              // ),
                              AddLinkTextFields(
                                textEditingController: createPostController.brandWebLinkTextEditingController,
                                iconImage: kiWebSvgImageUrl,
                                hintText: 'Enter a valid url',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandFacebookLinkTextEditingController,
                                iconImage: kiFacebookSvgImageUrl,
                                hintText: 'facebook.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandInstagramTextEditingController,
                                iconImage: kiInstagramSvgUrl,
                                // iconImage: kiFacebookImageUrl,
                                hintText: 'instagram.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandLinkedInLinkTextEditingController,
                                iconImage: kiLinkedInSvgImageUrl,
                                hintText: 'linkedin.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandTwitterTextEditingController,
                                iconImage: kiTwitterX2SvgUrl,
                                // iconImage: kiFacebookImageUrl,
                                hintText: 'twitter.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandYoutubeLinkTextEditingController,
                                iconImage: kiYoutubeSvgImageUrl,
                                hintText: 'youtube.com/',
                              ),
                              isDeviceScreenLarge() ? kH40sizedBox : kH30sizedBox,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (createPostController.isAddBrandPageLoading.value == true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (createPostController.isAddBrandPageLoading.value) {
                    return false;
                  }
                  return true;
                },
              ),
            ),
        ],
      ),
    );
  }
}

class AddLinkTextFields extends StatelessWidget {
  const AddLinkTextFields({super.key, required this.textEditingController, required this.iconImage, this.hintText});
  final TextEditingController textEditingController;
  final String iconImage;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), bottomLeft: Radius.circular(k8BorderRadius)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: k8Padding),
            child: Container(
              // clipBehavior: Clip.hardEdge,
              height: isDeviceScreenLarge() ? 51 : 48,
              width: isDeviceScreenLarge() ? 51 : 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), bottomLeft: Radius.circular(k8BorderRadius)),
                color: cGreyBoxColor,
                border: Border.all(color: cLineColor2, width: 1),
                // border: Border(
                //   left: BorderSide(color: cLineColor2, width: 1),
                //   bottom: BorderSide(color: cLineColor2, width: 1),
                //   top: BorderSide(color: cLineColor2, width: 1),
                //   right: BorderSide(color: cWhiteColor, width: 0),
                // ),
                // gradient: LinearGradient(
                //   stops: [0.02, 0.02],
                //   colors: [cLineColor2, cGreyBoxColor],
                // ),
                // boxShadow: [
                //   BoxShadow(color: cLineColor2, spreadRadius: 1),
                // ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(k8Padding),
                child: SvgPicture.asset(
                  iconImage,
                  fit: BoxFit.fill,
                  height: h28,
                  width: h28,
                ),
              ),
            ),
          ),
        ),
        // kW8sizedBox,
        // kH4sizedBox,
        Expanded(
          child: CustomModifiedTextField(
            controller: textEditingController,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: cLineColor2,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(k8BorderRadius),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(k8BorderRadius),
              ),
            ),
            hint: hintText,
            onChanged: (text) {
              Get.find<CreatePostController>().checkCanSaveBrand();
            },
            fillColor: cWhiteColor,
            onSubmit: (text) {},
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}

// class OutlineAddLinkTextField extends StatelessWidget {
//   const OutlineAddLinkTextField({super.key, required this.outlinedButtonText, required this.textEditingController});
//   final String outlinedButtonText;
//   final TextEditingController textEditingController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width - 40,
//       height: 40,
//       color: cRedColor,
//       child: Row(
//         children: [
//           Text(outlinedButtonText),
//           CustomModifiedTextField(
//             controller: textEditingController,
//             hint: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
