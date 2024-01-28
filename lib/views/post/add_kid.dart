import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class AddKidPage extends StatelessWidget {
  AddKidPage({super.key});

  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createPostHelper = CreatePostHelper();
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
                          onPressed: createPostController.isSaveKidButtonEnabled.value
                              ? () async {
                                  unFocus(context);
                                  await createPostController.addKid();
                                  createPostController.isKidAdded.value = true;
                                }
                              : null,
                          child: Text(
                            ksAdd.tr,
                            style: createPostController.isSaveKidButtonEnabled.value ? medium14TextStyle(cPrimaryColor) : medium14TextStyle(cIconColor),
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
                                createPostController.kidImageFile.value,
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
                              unFocus(context);
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
                                          await globalController.selectImageSource(createPostController.isKidImageChanged, createPostController.kidImageLink,
                                              createPostController.kidImageFile, 'camera', true);
                                          createPostController.checkCanAddKidInfo();
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
                                          await globalController.selectImageSource(createPostController.isKidImageChanged, createPostController.kidImageLink,
                                              createPostController.kidImageFile, 'gallery', true);
                                          createPostController.checkCanAddKidInfo();
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
                                controller: createPostController.kidNameTextEditingController,
                                hint: ksWriteKidName.tr,
                                errorText: createPostController.kidNameErrorText.value,
                                onChanged: (text) {
                                  createPostController.checkCanAddKidInfo();
                                  createPostController.kidNameOnChanged();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                                maxLength: 50,
                              ),
                              kH8sizedBox,
                              CustomModifiedTextField(
                                controller: createPostController.kidAgeTextEditingController,
                                hint: ksWriteAge.tr,
                                onChanged: (text) {
                                  createPostController.checkCanAddKidInfo();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.done,
                                inputType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                maxLength: 3,
                              ),
                              kH8sizedBox,
                              CustomModifiedTextField(
                                controller: createPostController.kidSchoolNameTextEditingController,
                                hint: ksWriteSchoolName.tr,
                                onChanged: (text) {
                                  createPostController.checkCanAddKidInfo();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.done,
                                inputType: TextInputType.text,
                                maxLength: 250,
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
          if (createPostController.isAddKidPageLoading.value == true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (createPostController.isAddKidPageLoading.value) {
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

// class AddKidContent extends StatelessWidget {
//   AddKidContent({super.key});

//   final CreatePostController createPostController = Get.find<CreatePostController>();
//   final CreatePostHelper createPostHelper = CreatePostHelper();
//   final GlobalController globalController = Get.find<GlobalController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
//           ClipOval(
//             child: Container(
//               height: 100,
//               width: 100,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: cBlackColor,
//               ),
//               child: Image.file(
//                 createPostController.kidImageFile.value,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => const Icon(
//                   BipHip.user,
//                   size: kIconSize60,
//                   color: cIconColor,
//                 ),
//               ),
//             ),
//           ),
//           isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
//           OutLinedButton(
//             onPress: () {
//               globalController.commonBottomSheet(
//                   context: context,
//                   onPressCloseButton: () {
//                     Get.back();
//                   },
//                   onPressRightButton: () {},
//                   rightText: '',
//                   rightTextStyle: regular14TextStyle(cBiddingColor),
//                   title: ksUploadPhoto.tr,
//                   isRightButtonShow: false,
//                   isScrollControlled: false,
//                   bottomSheetHeight: 180,
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CustomElevatedButton(
//                         label: ksAddPhoto.tr,
//                         prefixIcon: BipHip.camera,
//                         prefixIconColor: cIconColor,
//                         suffixIconColor: cIconColor,
//                         onPressed: () async {
//                           await globalController.selectImageSource(
//                               createPostController.isKidImageChanged, createPostController.kidImageLink, createPostController.kidImageFile, 'camera', true);
//                           createPostController.checkCanAddKidInfo();
//                         },
//                         buttonHeight: h32,
//                         buttonWidth: width - 40,
//                         buttonColor: cWhiteColor,
//                         borderColor: cLineColor,
//                         textStyle: semiBold14TextStyle(cBlackColor),
//                       ),
//                       kH16sizedBox,
//                       CustomElevatedButton(
//                         label: ksChooseFromGallery.tr,
//                         prefixIcon: BipHip.photo,
//                         prefixIconColor: cIconColor,
//                         suffixIconColor: cIconColor,
//                         onPressed: () async {
//                           await globalController.selectImageSource(
//                               createPostController.isKidImageChanged, createPostController.kidImageLink, createPostController.kidImageFile, 'gallery', true);
//                           createPostController.checkCanAddKidInfo();
//                         },
//                         buttonHeight: h32,
//                         buttonWidth: width - 40,
//                         buttonColor: cWhiteColor,
//                         borderColor: cLineColor,
//                         textStyle: semiBold14TextStyle(cBlackColor),
//                       ),
//                     ],
//                   ));
//             },
//             buttonText: ksUploadImage.tr,
//             borderColor: cPrimaryColor,
//             buttonHeight: 32,
//             buttonWidth: 150,
//             suffixWidget: Padding(
//               padding: const EdgeInsets.only(right: 4.0),
//               child: Icon(
//                 BipHip.addImage,
//                 size: isDeviceScreenLarge() ? h20 : h16,
//                 color: cPrimaryColor,
//               ),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               isDeviceScreenLarge() ? kH40sizedBox : kH30sizedBox,
//               CustomModifiedTextField(
//                 controller: createPostController.kidNameTextEditingController,
//                 hint: ksWriteKidName.tr,
//                 onChanged: (text) {
//                   createPostController.checkCanAddKidInfo();
//                 },
//                 onSubmit: (text) {},
//                 inputAction: TextInputAction.next,
//                 inputType: TextInputType.text,
//                 maxLength: 50,
//               ),
//               kH8sizedBox,
//               CustomModifiedTextField(
//                 controller: createPostController.kidAgeTextEditingController,
//                 hint: ksWriteAge.tr,
//                 onChanged: (text) {
//                   createPostController.checkCanAddKidInfo();
//                 },
//                 onSubmit: (text) {},
//                 inputAction: TextInputAction.next,
//                 inputType: TextInputType.number,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 maxLength: 3,
//               ),
//               kH8sizedBox,
//               CustomModifiedTextField(
//                 controller: createPostController.kidSchoolNameTextEditingController,
//                 hint: ksWriteSchoolName.tr,
//                 onChanged: (text) {
//                   createPostController.checkCanAddKidInfo();
//                 },
//                 onSubmit: (text) {},
//                 inputAction: TextInputAction.done,
//                 inputType: TextInputType.text,
//                 maxLength: 250,
//               ),
//               kH8sizedBox,
//               CustomCheckBox(
//                 value: createPostController.saveKidInfo.value,
//                 onChanged: (v) {
//                   createPostController.saveKidInfo.value = !createPostController.saveKidInfo.value;
//                 },
//                 label: ksSaveKidInformation.tr,
//                 textStyle: regular14TextStyle(cBlackColor),
//               ),
//               isDeviceScreenLarge() ? kH40sizedBox : kH30sizedBox,
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
