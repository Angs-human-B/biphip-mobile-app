import 'dart:io';

import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/store/add_store_documents.dart';
import 'package:flutter_svg/svg.dart';

class StoreAddLegalDocument extends StatelessWidget {
  StoreAddLegalDocument({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: ksAddLegalDocument,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          kH16sizedBox,
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
                          kH16sizedBox,
                          for (int i = 0; i < storeController.selectedImages.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
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
                                        storeController.checkStoreDocumentsNextButtonEnabled();
                                      },
                                      icon: BipHip.delete,
                                      size: kIconSize16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          kH16sizedBox,
                          CustomElevatedButton(
                              label: ksSave,
                              textStyle: semiBold14TextStyle(cWhiteColor),
                              buttonHeight: h42,
                              buttonWidth: width - 40,
                              onPressed: () async {
                                await storeController.updateLegalFiles();
                              }),
                          kH20sizedBox,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (storeController.isLegalFileLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (storeController.isLegalFileLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
