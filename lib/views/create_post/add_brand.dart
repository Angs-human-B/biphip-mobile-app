import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBrandPage extends StatelessWidget {
  AddBrandPage({super.key});

  final CreatePostController _createPostController = Get.find<CreatePostController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                      onPressed: () async {
                        _createPostController.createLinkList();
                        await _createPostController.addBrand();
                        // unfocus(context);
                        // Get.back();
                      },
                      child: Text(
                        ksAdd.tr,
                        style: medium14TextStyle(cPrimaryColor),
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
                            _createPostController.brandImageFile.value,
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
                          _globalController.commonBottomSheet(
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
                                      await _globalController.selectImageSource(_createPostController.isBrandImageChanged, _createPostController.brandImageLink,
                                          _createPostController.brandImageFile, 'camera', true);
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
                                      await _globalController.selectImageSource(_createPostController.isBrandImageChanged, _createPostController.brandImageLink,
                                          _createPostController.brandImageFile, 'gallery', true);
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
                            controller: _createPostController.brandNameTextEditingController,
                            hint: ksWriteBrandName.tr,
                            onChanged: (text) {},
                            onSubmit: (text) {},
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.text,
                          ),
                          Text(
                            ksAddSocialLinks.tr,
                            style: medium14TextStyle(cBlackColor),
                          ),
                          kH8sizedBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: SvgPicture.asset(
                                  kiWebSvgImageUrl,
                                  fit: BoxFit.fill,
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                              kW8sizedBox,
                              Expanded(
                                child: CustomModifiedTextField(
                                  controller: _createPostController.brandWebLinkTextEditingController,
                                  hint: "${ksWriteHere.tr}...",
                                  onChanged: (text) {},
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          kH8sizedBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: SvgPicture.asset(
                                  kiFacebookSvgImageUrl,
                                  fit: BoxFit.fill,
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                              kW8sizedBox,
                              Expanded(
                                child: CustomModifiedTextField(
                                  controller: _createPostController.brandFacebookLinkTextEditingController,
                                  hint: "${ksWriteHere.tr}...",
                                  onChanged: (text) {},
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          kH8sizedBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: SvgPicture.asset(
                                  kiLinkedListSvgImageUrl,
                                  fit: BoxFit.fill,
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                              kW8sizedBox,
                              Expanded(
                                child: CustomModifiedTextField(
                                  controller: _createPostController.brandLinkedInLinkTextEditingController,
                                  hint: "${ksWriteHere.tr}...",
                                  onChanged: (text) {},
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          kH8sizedBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: SvgPicture.asset(
                                  kiTwitterSvgImageUrl,
                                  fit: BoxFit.fill,
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                              kW8sizedBox,
                              Expanded(
                                child: CustomModifiedTextField(
                                  controller: _createPostController.brandTwitterTextEditingController,
                                  hint: "${ksWriteHere.tr}...",
                                  onChanged: (text) {},
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          kH8sizedBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: SvgPicture.asset(
                                  kiYoutubeSvgImageUrl,
                                  fit: BoxFit.fill,
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                              kW8sizedBox,
                              Expanded(
                                child: CustomModifiedTextField(
                                  controller: _createPostController.brandYoutubeLinkTextEditingController,
                                  hint: "${ksWriteHere.tr}...",
                                  onChanged: (text) {},
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.done,
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ],
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
    );
  }
}
