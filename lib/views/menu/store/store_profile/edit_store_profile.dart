import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/helpers/menu/store/store_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/menu/store/store_profile/store_profile.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EditStoreProfile extends StatelessWidget {
  EditStoreProfile({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final StoreHelper storeHelper = StoreHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Stack(
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
                  title: ksEditProfile.tr,
                  hasBackButton: true,
                  isCenterTitle: true,
                  onBack: () {
                    Get.back();
                  },
                ),
              ),
              body: Obx(
                () => Stack(
                  children: [
                    Container(
                      color: cWhiteColor,
                      height: height - kAppBarSize,
                      width: width,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksProfilePicture.tr,
                                suffix: ksEdit.tr,
                                onEditPressed: () {
                                  storeHelper.storeProfilePicUploadBottomSheet(context);
                                },
                              ),
                              kH12sizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      storeHelper.viewProfilePic();
                                    },
                                    child: Container(
                                      height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                      width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                                      decoration: const BoxDecoration(
                                        color: cBlackColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          storeController.storeProfilePicture.value,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => const Icon(
                                            BipHip.user,
                                            size: kIconSize70,
                                            color: cIconColor,
                                          ),
                                          loadingBuilder: imageLoadingBuilder,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kH20sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksCoverPhoto.tr,
                                suffix: ksEdit.tr,
                                onEditPressed: () {
                                  storeHelper.storeCoverPhotoUploadBottomSheet(context);
                                },
                              ),
                              kH12sizedBox,
                              InkWell(
                                onTap: () {
                                  storeHelper.viewCoverPhoto();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0, color: cLineColor),
                                    borderRadius: k8CircularBorderRadius,
                                    color: cBlackColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: k8CircularBorderRadius,
                                    child: Image.network(
                                      storeController.storeCoverPhoto.value,
                                      height: 150,
                                      width: width,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => SizedBox(
                                        width: width,
                                        height: 150,
                                        child: const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize120,
                                          color: cIconColor,
                                        ),
                                      ),
                                      loadingBuilder: imageLoadingBuilderCover,
                                    ),
                                  ),
                                ),
                              ),
                              kH20sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksBio.tr,
                                suffix: storeController.storeBio.value == null ? ksAdd : ksEdit.tr,
                                onEditPressed: () {
                                  if (storeController.storeBio.value == null) {
                                    storeController.storeBioTextEditingController.text = "";
                                  } else {
                                    storeController.storeBioTextEditingController.text = storeController.storeBio.value ?? "";
                                  }
                                  Get.toNamed(krStoreEditBio);
                                },
                              ),
                              if (storeController.storeBio.value != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: k16Padding),
                                  child: Text(
                                    storeController.storeBio.value ?? '',
                                    style: regular14TextStyle(cIconColor),
                                  ),
                                ),
                              kH16sizedBox,
                              const CustomDivider(
                                thickness: 2,
                              ),
                              kH16sizedBox,
                              RowTextEdit(
                                prefix: ksIntro.tr,
                                suffix: ksEdit.tr,
                                onEditPressed: () async {
                                  await storeController.getStoreLocations();
                                  await storeController.getStoreContacts();
                                  await storeController.getStoreLinks();
                                  Get.toNamed(krStoreEditAbout);
                                },
                              ),
                              kH16sizedBox,
                              StoreIntroContent(),
                              kH16sizedBox,
                              CustomElevatedButton(
                                label: ksEditYouAboutInfo.tr,
                                buttonHeight: h32,
                                buttonWidth: width - 40,
                                buttonColor: cPrimaryColor,
                                textStyle: semiBold14TextStyle(cWhiteColor),
                                onPressed: () async {
                                  await storeController.getStoreLocations();
                                  await storeController.getStoreContacts();
                                  await storeController.getStoreLinks();
                                  Get.toNamed(krStoreEditAbout);
                                },
                              ),
                              kH20sizedBox
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 1,
                      child: CustomDivider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoreIntroContent extends StatelessWidget {
  StoreIntroContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidStoreProfileLinkUpIconTextRow(
              iconOrSvg: const Icon(
                BipHip.info,
                size: kIconSize20,
                color: cPrimaryColor,
              ),
              onPressed: null,
              prefixText: '${ksPage.tr} ',
              suffixText: storeController.storesData.value?.pageType ?? ksNA.tr,
            ),
            KidStoreProfileLinkUpIconTextRow(
              iconOrSvg: const Icon(
                BipHip.info,
                size: kIconSize20,
                color: cPrimaryColor,
              ),
              onPressed: null,
              prefixText: ksBIN.tr,
              suffixText: storeController.storeBIN.value ?? "",
            ),
            StoreProfileLinkUpIconTextRow(
              iconOrSvg: const Icon(
                BipHip.location,
                size: kIconSize20,
                color: cPrimaryColor,
              ),
              onPressed: null,
              prefixText: storeController.storeOverviewData.value?.location ?? ksNA.tr,
              suffixText: '',
            ),
            StoreProfileLinkUpIconTextRow(
              iconOrSvg: const Icon(
                BipHip.mail,
                size: kIconSize20,
                color: cPrimaryColor,
              ),
              onPressed: null,
              prefixText: storeController.storeOverviewData.value?.email ?? ksNA.tr,
              suffixText: '',
            ),
            StoreProfileLinkUpIconTextRow(
              iconOrSvg: const Icon(
                BipHip.phoneFill,
                size: kIconSize20,
                color: cPrimaryColor,
              ),
              onPressed: null,
              prefixText: storeController.storeOverviewData.value?.phone ?? ksNA.tr,
              suffixText: '',
            ),
            StoreProfileLinkUpIconTextRow(
              iconOrSvg: SvgPicture.asset(
                kiWorldSvgImage,
              ),
              onPressed: null,
              prefixText: storeController.storesData.value?.country ?? ksNA,
              suffixText: '',
            ),
            StoreProfileLinkUpIconTextRow(
              iconOrSvg: SvgPicture.asset(
                kiStarSvgImage,
                color: cAmberColor,
              ),
              onPressed: () {
                Get.toNamed(krStoreReview);
              },
              prefixText: ksRating.tr,
              suffixText:
                  "${storeController.storesData.value?.countPageRating.toString() ?? ksNA.tr} (${storeController.storesData.value?.countPageReviews.toString() ?? ksNA.tr})",
            ),
            kH20sizedBox,
            Text(
              ksPayment.tr,
              style: semiBold16TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            StoreProfileLinkUpIconTextRow(
              iconOrSvg: SvgPicture.asset(
                kiNagadSvgImage,
              ),
              onPressed: null,
              prefixText: '01858268951',
              suffixText: '',
            ),
            StoreProfileLinkUpIconTextRow(
              iconOrSvg: SvgPicture.asset(
                kiPaypalSvgImage,
              ),
              onPressed: null,
              prefixText: 'Shohagjalal@gmail.com',
              suffixText: '',
            ),
            kH16sizedBox,
            Text(
              ksLegalPapers.tr,
              style: semiBold16TextStyle(cBlackColor),
            ),
            kH8sizedBox,
            SizedBox(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: storeController.storeLegalPapersList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                  crossAxisCount: 4,
                  crossAxisSpacing: k16Padding,
                  mainAxisSpacing: k16Padding,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Image.network(
                        storeController.storeLegalPapersList[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          BipHip.imageFile,
                          size: kIconSize70,
                          color: cIconColor,
                        ),
                        loadingBuilder: imageLoadingBuilder,
                      ),
                    ),
                  );
                },
              ),
            ),
            kH16sizedBox,
            Text(
              ksQR.tr,
              style: semiBold16TextStyle(cBlackColor),
            ),
            QrImageView(
              data: storeController.qrCode.value ?? "",
              version: QrVersions.auto,
              size: 120,
            ),
          ],
        ));
  }
}
