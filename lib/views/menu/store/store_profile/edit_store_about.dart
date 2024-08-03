import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_edit_about.dart';
import 'package:intl/intl.dart';

class StoreEditAbout extends StatelessWidget {
  StoreEditAbout({super.key});
  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksAbout.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                StoreCategoryContent(),
                kH8sizedBox,
                StoreLocationContent(),
                kH8sizedBox,
                StoreContactInfoContent(),
                kH8sizedBox,
                StoreWebsiteSocialLinkContent(),
                kH8sizedBox,
                StorePrivacyAndLegalInfoContent(),
                kH8sizedBox,
                StorePaymentContent(),
                kH8sizedBox,
                StoreBINContent(),
                kH8sizedBox,
                StoreQrCodeContent(),
                kH8sizedBox,
                StoreLegalPaperContent(),
                kH8sizedBox,
                StoreReviewContent(),
                kH8sizedBox,
                StorePageTransperencyContent(pageId: storeController.storesData.value!.pageId.toString(),creatingDate: storeController.storesData.value?.createdAt,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StoreCategoryContent extends StatelessWidget {
  StoreCategoryContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            Obx(() => InfoContainer(
                  suffixText: ksCategory.tr,
                  subtitlePrefixText: storeController.storeCategory.value ?? ksCategory.tr,
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: false,
                  suffixOnPressed: () async {
                    storeController.storeCategoryTextEditingController.text = storeController.storeCategory.value ?? '';
                    Get.toNamed(krEditStoreCategory);
                    await storeController.getAllBusinessCategory();
                  },
                )),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class StoreLocationContent extends StatelessWidget {
  StoreLocationContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: cWhiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                InfoContainer(
                  suffixText: ksStoreLocation.tr,
                  suffixTextStyle: semiBold18TextStyle(cBlackColor),
                  isAddButton: true,
                  suffixOnPressed: () async {
                    storeController.isEditOrAdd.value = false;
                    storeController.storeLocationTextEditingController.text = '';
                    storeController.isStoreLocationSuffixIconVisible.value = false;
                    Get.toNamed(krEditStoreLocation);
                    await storeController.getCityList();
                  },
                ),
                kH12sizedBox,
                for (int i = 0; i < storeController.storeLocationList.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: k12Padding),
                    child: InfoContainer(
                      suffixText: '',
                      prefixText: checkNullOrStringNull(storeController.storeLocationList[i].location),
                      isAddButton: false,
                      suffixOnPressed: () async {
                        storeController.isEditOrAdd.value = true;
                        storeController.storeLocationTextEditingController.text = storeController.storeLocationList[i].location;
                        storeController.isStoreLocationSuffixIconVisible.value = false;
                        storeController.selectedStoreLocationId.value = storeController.storeLocationList[i].id;
                        Get.toNamed(krEditStoreLocation);
                      },
                    ),
                  ),
                kH16sizedBox,
              ],
            ),
          ),
        ));
  }
}

class StoreContactInfoContent extends StatelessWidget {
  StoreContactInfoContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: cWhiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                InfoContainer(
                  suffixText: ksContactInfo.tr,
                  suffixTextStyle: semiBold18TextStyle(cBlackColor),
                  isAddButton: null,
                  suffixOnPressed: () {},
                ),
                InfoContainer(
                  suffixText: ksPhone.tr,
                  suffixTextStyle: semiBold18TextStyle(cBlackColor),
                  isAddButton: true,
                  suffixOnPressed: () {
                    storeController.isEditOrAdd.value = false;
                    storeController.storePhoneNumberTextEditingController.text = "";
                    storeController.storeContactId.value = -1;
                    Get.toNamed(krEditStorePhoneNumber);
                  },
                ),
                kH12sizedBox,
                for (int i = 0; i < storeController.contactList.length; i++)
                  if (storeController.contactList[i].type == "phone")
                    Padding(
                      padding: const EdgeInsets.only(bottom: k12Padding),
                      child: InfoContainer(
                        suffixText: '',
                        prefixText: checkNullOrStringNull(storeController.contactList[i].value),
                        isAddButton: false,
                        suffixOnPressed: () async {
                          storeController.isEditOrAdd.value = true;
                          storeController.storeContactId.value = storeController.contactList[i].id;
                          storeController.storePhoneNumberTextEditingController.text = storeController.contactList[i].value;
                          Get.toNamed(krEditStorePhoneNumber);
                        },
                      ),
                    ),
                InfoContainer(
                  suffixText: ksEmail.tr,
                  suffixTextStyle: semiBold18TextStyle(cBlackColor),
                  isAddButton: true,
                  suffixOnPressed: () {
                    storeController.isEditOrAdd.value = false;
                    storeController.storeContactId.value = -1;
                    storeController.storeEmailTextEditingController.text = "";
                    Get.toNamed(krEditStoreEmail);
                  },
                ),
                kH12sizedBox,
                for (int i = 0; i < storeController.contactList.length; i++)
                  if (storeController.contactList[i].type == "email")
                    Padding(
                      padding: const EdgeInsets.only(bottom: k12Padding),
                      child: InfoContainer(
                        suffixText: '',
                        prefixText: checkNullOrStringNull(storeController.contactList[i].value),
                        isAddButton: false,
                        suffixOnPressed: () async {
                          storeController.isEditOrAdd.value = true;
                          storeController.storeContactId.value = storeController.contactList[i].id;
                          storeController.storeEmailTextEditingController.text = storeController.contactList[i].value;
                          Get.toNamed(krEditStoreEmail);
                        },
                      ),
                    ),
              ],
            ),
          ),
        ));
  }
}

class StoreWebsiteSocialLinkContent extends StatelessWidget {
  StoreWebsiteSocialLinkContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: cWhiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                InfoContainer(
                  suffixText: ksWebsiteAndSocialLinks.tr,
                  suffixTextStyle: semiBold18TextStyle(cBlackColor),
                  isAddButton: true,
                  suffixOnPressed: () {
                    storeController.isEditOrAdd.value = false;
                    storeController.storeSocialLinkTextEditingController.text = "";
                    storeController.selectedStoreSocialLinkSource.value = "";
                    storeController.storeLinkId.value = -1;
                    storeController.isStoreSocialLinkSaveEnabled.value = false;
                    Get.toNamed(krEditStoreSocialLink);
                  },
                ),
                kH12sizedBox,
                for (int i = 0; i < storeController.allLinkList.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: k12Padding),
                    child: InfoContainer(
                      suffixText: '',
                      prefixText: checkNullOrStringNull(storeController.allLinkList[i].link),
                      isAddButton: false,
                      suffixOnPressed: () {
                        storeController.isEditOrAdd.value = true;
                        storeController.storeSocialLinkTextEditingController.text = storeController.allLinkList[i].link ?? "";
                        storeController.selectedStoreSocialLinkSource.value = storeController.allLinkList[i].type!;
                        storeController.storeLinkId.value = storeController.allLinkList[i].id!;
                        Get.toNamed(krEditStoreSocialLink);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}

class StorePrivacyAndLegalInfoContent extends StatelessWidget {
  StorePrivacyAndLegalInfoContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            Obx(() => InfoContainer(
                  suffixText: ksPrivacyAndLegalInfo.tr,
                  subtitlePrefixText: storeController.storePrivacyLink.value,
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: storeController.storePrivacyLink.value == null ? true : false,
                  suffixOnPressed: () {
                    storeController.storePrivacyLinkTextEditingController.text = storeController.storePrivacyLink.value ?? "";
                    if (storeController.storePrivacyLink.value == null) {
                      storeController.isEditOrAdd.value = false;
                    } else {
                      storeController.isEditOrAdd.value = true;
                    }
                    Get.toNamed(krEditStorePrivacyLink);
                  },
                )),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class StorePaymentContent extends StatelessWidget {
  StorePaymentContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            InfoContainer(
              suffixText: ksPayment.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              isAddButton: true,
              suffixOnPressed: () {
                storeController.isEditOrAdd.value = false;
                storeController.storePaymentTextEditingController.text = "";
                storeController.selectedStorePaymentMethod.value = "";
                Get.toNamed(krEditStorePayment);
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.paymentMethodList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.paymentMethodList[i]['payment']), //!Use here api
                  subtitlePrefixText: checkNullOrStringNull(storeController.paymentMethodList[i]['paymentMethod']), //!Use here api
                  isAddButton: false,
                  suffixOnPressed: () async {
                    storeController.isEditOrAdd.value = true;
                    storeController.storePaymentTextEditingController.text = storeController.paymentMethodList[i]['payment'];
                    storeController.selectedStorePaymentMethod.value = storeController.paymentMethodList[i]['paymentMethod'];
                    Get.toNamed(krEditStorePayment);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class StoreBINContent extends StatelessWidget {
  StoreBINContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            Obx(() => InfoContainer(
                  suffixText: ksBIN.tr,
                  subtitlePrefixText: storeController.storeBIN.value == "" ? null : storeController.storeBIN.value,
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: storeController.storeBIN.value == "" ? true : false,
                  suffixOnPressed: () {
                    if (storeController.storeBIN.value == "") {
                      storeController.storeBINTextEditingController.text = "";
                    } else {
                      storeController.storeBINTextEditingController.text = storeController.storeBIN.value??"";
                    }
                    Get.toNamed(krEditStoreBIN);
                  },
                )),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class StoreQrCodeContent extends StatelessWidget {
  StoreQrCodeContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            Obx(() => InfoContainer(
                  suffixText: ksQRCode.tr,
                  subtitlePrefixText: storeController.qrCode.value == "" ? null : storeController.qrCode.value,
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: storeController.qrCode.value == "" ? true : false,
                  suffixOnPressed: () {
                    if (storeController.qrCode.value == "") {
                      storeController.storeQrCodeTextEditingController.text = "";
                    } else {
                      storeController.storeQrCodeTextEditingController.text = storeController.qrCode.value??"";
                    }
                    Get.toNamed(krEditStoreQrCode);
                  },
                )),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class StoreLegalPaperContent extends StatelessWidget {
  StoreLegalPaperContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            InfoContainer(
              suffixText: ksLegalPapers.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              isAddButton: true,
              suffixOnPressed: () {
                storeController.selectedImages.clear();
                Get.toNamed(krStoreAddLegalDocument);
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.legalPaperAllInfoList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.legalPaperAllInfoList[i]['fileName']), //!Use here api
                  subtitlePrefixText: checkNullOrStringNull(storeController.legalPaperAllInfoList[i]['fileSize']),
                  suffixOnPressed: () async {
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class StoreReviewContent extends StatelessWidget {
  StoreReviewContent({super.key});
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Text(
              "Not Yet Rated (0 Reviews)",
              style: regular16TextStyle(cBlackColor),
            ),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class StorePageTransperencyContent extends StatelessWidget {
  StorePageTransperencyContent({super.key, required this.pageId, this.creatingDate});
  final StoreController storeController = Get.find<StoreController>();
  final String pageId;
  final DateTime? creatingDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Text(
              ksPageTransparency,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            Text(
              "BipHip is showing informatino to help people understand the purpose of your page. You won't be able to edit what is shown here.",
              style: regular14TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              pageId,
              style: regular16TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Text(
              ksPageId.tr,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              DateFormat('dd MMM, yyyy').format(creatingDate ?? DateTime.now()),
              style: regular16TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Text(
              ksCreatingDate.tr,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              "Admin Info",
              style: regular16TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Text(
              "This page can't have admin right now. We will add admin feature in coming updates.",
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              "This page is currently not running ads",
              style: regular16TextStyle(cBlackColor),
            ),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}
