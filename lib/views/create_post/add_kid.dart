import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class AddKidPage extends StatelessWidget {
  AddKidPage({super.key});

  final CreatePostController _createPostController = Get.find<CreatePostController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
                    title: ksAddKid.tr,
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
                          onPressed: _createPostController.isSaveButtonEnabled.value
                              ? () async {
                                  if (_createPostController.saveKidInfo.value) {
                                    await _createPostController.addKid();
                                  } else {
                                    Get.back();
                                  }
                                  _createPostController.isKidAdded.value = true;
                                  if ( !_createPostController.isKidAdded.value) {
                                    _globalController.isBottomSheetRightButtonActive.value = false;
                                  } else {
                                    _globalController.isBottomSheetRightButtonActive.value = true;
                                  }
                                }
                              : null,
                          child: Text(
                            ksAdd.tr,
                            style: _createPostController.isSaveButtonEnabled.value ? medium14TextStyle(cPrimaryColor) : medium14TextStyle(cIconColor),
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
                                _createPostController.kidImageFile.value,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.user,
                                  size: kIconSize60,
                                  color: cIconColor,
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
                                          await _globalController.selectImageSource(_createPostController.isKidImageChanged, _createPostController.kidImageLink,
                                              _createPostController.kidImageFile, 'camera', true);
                                          _createPostController.checkCanAddKidInfo();
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
                                          await _globalController.selectImageSource(_createPostController.isKidImageChanged, _createPostController.kidImageLink,
                                              _createPostController.kidImageFile, 'gallery', true);
                                          _createPostController.checkCanAddKidInfo();
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
                                controller: _createPostController.kidNameTextEditingController,
                                hint: ksWriteKidName.tr,
                                onChanged: (text) {
                                  _createPostController.checkCanAddKidInfo();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                                maxLength: 50,
                              ),
                              kH8sizedBox,
                              CustomModifiedTextField(
                                controller: _createPostController.kidAgeTextEditingController,
                                hint: ksWriteAge.tr,
                                onChanged: (text) {
                                  _createPostController.checkCanAddKidInfo();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.done,
                                inputType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                maxLength: 3,
                              ),
                              kH8sizedBox,
                              CustomCheckBox(
                                value: _createPostController.saveKidInfo.value,
                                onChanged: (v) {
                                  _createPostController.saveKidInfo.value = !_createPostController.saveKidInfo.value;
                                },
                                label: ksSaveKidInformation.tr,
                                textStyle: regular14TextStyle(cBlackColor),
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
          if (_createPostController.isAddKidPageLoading.value == true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (_createPostController.isAddKidPageLoading.value) {
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
