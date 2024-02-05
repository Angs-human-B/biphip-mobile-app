import 'dart:io';
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class AddStoreDocuments extends StatelessWidget {
  AddStoreDocuments({super.key});
  final StoreController storeController = Get.find<StoreController>();

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
              title: ksCreateStore.tr,
              hasBackButton: false,
              leadingWidth: 80,
              leadingWidget: Center(
                child: InkWell(
                  onTap: () {
                    unFocus(context);
                    Get.back();
                  },
                  child: Text(
                    ksPrevious.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              ),
              isCenterTitle: true,
              onBack: () {},
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      unFocus(context);
                      Get.toNamed(krAddStoreUploadImage);
                    },
                    child: Text(
                      ksSkip.tr,
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDivider(
                    thickness: 1,
                  ),
                  KidTopTitleSubtitleAndCircularProgressBar(
                    title: ksDocuments.tr,
                    subTitle: ksElevateBusinessImageAndDocument.tr,
                    circularCenterText: ks4of5.tr,
                    percent: 0.8,
                  ),
                  kH16sizedBox,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: CustomDivider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kH16sizedBox,
                        Text(
                          ksBusinessIdentificationNumber.tr,
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                        kH8sizedBox,
                        CustomModifiedTextField(
                          controller: storeController.businessIdentificationNumberController,
                          hint: ksBIN.tr,
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                          ],
                          maxLength: 20,
                        ),
                        kH8sizedBox,
                        Text(
                          ksLegalPapers.tr,
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                        kH8sizedBox,
                        Text(
                          ksLegalPapersLicenseOrImage.tr,
                          style: regular14TextStyle(cSmallBodyTextColor),
                        ),
                        kH8sizedBox,
                        InkWell(
                          onTap: () {
                            unFocus(context);
                            Get.find<GlobalController>().commonBottomSheet(
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
                                content: StoreDocumentsPictureUploadContent());
                          },
                          child: Container(
                            width: width - 40,
                            height: 140,
                            decoration: BoxDecoration(
                              color: cInputFieldColor,
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  kiUploadImage,
                                  height: 40,
                                ),
                                kH4sizedBox,
                                Text(
                                  ksFileSize10MBLimit,
                                  style: regular14TextStyle(cSmallBodyTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kH16sizedBox,
                  for (int i = 0; i < storeController.selectedImages.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, bottom: k16Padding),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => CommonFilePhotoView(
                                fileImage: File(storeController.selectedImages[i].path),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cInputFieldColor,
                            borderRadius: BorderRadius.circular(k8BorderRadius),
                          ),
                          child: ListTile(
                            title: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                String fileName = storeController.selectedImages[i].name;
                                String fileExtension = '';
                                if (constraints.maxWidth < fileName.length * 10) {
                                  fileExtension = '.${fileName.split('.').last}';
                                }
                                return Column(
                                  children: [
                                    if (storeController.progress.value > 0 && storeController.progress.value < 1)
                                      LinearProgressIndicator(
                                        value: storeController.progress.value,
                                        borderRadius: BorderRadius.circular(k16BorderRadius),
                                      ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            fileName,
                                            style: regular14TextStyle(cBlackColor),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          fileExtension,
                                          style: regular14TextStyle(cBlackColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            subtitle: Text(
                              '${(storeController.selectedImages[i].path.length).toStringAsFixed(0)}KB',
                              style: regular12TextStyle(cSmallBodyTextColor),
                            ),
                            trailing: CustomIconButton(
                              onPress: () {
                                storeController.selectedImages.removeAt(i);
                              },
                              icon: BipHip.delete,
                              size: kIconSize16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  kH16sizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                    ),
                    child: Text(
                      ksQRCode,
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                  ),
                  kH8sizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                    ),
                    child: CustomModifiedTextField(
                      controller: storeController.storeQRCodeController,
                      hint: ksQRCode.tr,
                      onChanged: (text) {},
                      onSubmit: (text) {},
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.text,
                      maxLength: 50,
                    ),
                  ),
                  kH60sizedBox,
                  CustomElevatedButton(
                    buttonWidth: width - 40,
                    buttonHeight: h40,
                    label: ksNext.tr,
                    onPressed: () {
                      unFocus(context);
                      Get.toNamed(krAddStoreUploadImage);
                    },
                    textStyle: semiBold16TextStyle(cWhiteColor),
                  ),
                  kH20sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StoreDocumentsPictureUploadContent extends StatelessWidget {
  StoreDocumentsPictureUploadContent({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () {
            storeController.captureImageFromCamera();
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
          onPressed: () {
            storeController.pickImageFromGallery();
            storeController.startUpload();
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}

class CommonFilePhotoView extends StatelessWidget {
  const CommonFilePhotoView({super.key, required this.fileImage});
  final File fileImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              systemUiOverlayStyle: SystemUiOverlayStyle.light,
              appBarColor: Colors.black,
              hasBackButton: true,
              iconColor: cWhiteColor,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: width,
                    height: height * 0.7,
                    child: Image.file(
                      fileImage,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.imageFile,
                        size: kIconSize100,
                        color: cIconColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
