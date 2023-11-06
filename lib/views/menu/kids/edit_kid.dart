import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class EditKidPage extends StatelessWidget {
  EditKidPage({super.key});

  final KidsController _kidsController = Get.find<KidsController>();
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
                    title: ksEditKid.tr,
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
                          onPressed: _kidsController.isSaveKidButtonEnabled.value
                              ? () async {
                                  unFocus(context);
                                  await _kidsController.editKid();
                                }
                              : null,
                          child: Text(
                            ksSave.tr,
                            style: _kidsController.isSaveKidButtonEnabled.value ? medium14TextStyle(cPrimaryColor) : medium14TextStyle(cIconColor),
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
                    // physics: const AlwaysScrollableScrollPhysics(),
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
                              child: _kidsController.isKidImageChanged.value
                                  ? Image.file(
                                      _kidsController.kidImageFile.value,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                        BipHip.user,
                                        size: kIconSize60,
                                        color: cIconColor,
                                      ),
                                    )
                                  : Image.network(Environment.imageBaseUrl + _kidsController.kidImageLink.value),
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
                                          await _globalController.selectImageSource(
                                              _kidsController.isKidImageChanged, _kidsController.kidImageLink, _kidsController.kidImageFile, 'camera', true);
                                          _kidsController.checkCanEditKidInfo();
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
                                          await _globalController.selectImageSource(
                                              _kidsController.isKidImageChanged, _kidsController.kidImageLink, _kidsController.kidImageFile, 'gallery', true);
                                          _kidsController.checkCanEditKidInfo();
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
                                controller: _kidsController.kidNameTextEditingController,
                                hint: ksWriteKidName.tr,
                                onChanged: (text) {
                                  _kidsController.checkCanEditKidInfo();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                                maxLength: 50,
                              ),
                              kH8sizedBox,
                              CustomModifiedTextField(
                                controller: _kidsController.kidAgeTextEditingController,
                                hint: ksWriteAge.tr,
                                onChanged: (text) {
                                  _kidsController.checkCanEditKidInfo();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.done,
                                inputType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                maxLength: 3,
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
          if (_kidsController.isEditKidLoading.value == true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (_kidsController.isEditKidLoading.value) {
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
