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
                StorePageTransperencyContent(),
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
                  suffixOnPressed: () {
                    // KidHelper().resetKidRelationEditPage();
                    // Get.toNamed(krKidEditRelation);
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
    return Container(
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
              suffixOnPressed: () {
                // kidHelper.addKidEducationBackground();
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.storeLocationList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.storeLocationList[i]), //*Use here api
                  isAddButton: false,
                  suffixOnPressed: () async {
                    // kidHelper.editKidSchool(i);
                  },
                ),
              ),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class StoreContactInfoContent extends StatelessWidget {
  StoreContactInfoContent({super.key});
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
              suffixText: ksContactInfo.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              isAddButton: true,
              suffixOnPressed: () {
                // kidHelper.addKidEducationBackground();
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.storeNumberList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.storeNumberList[i]['phone']), //*Use here api
                  isAddButton: false,
                  suffixOnPressed: () async {
                    storeController.storePhoneNumberTextEditingController.text = storeController.storeNumberList[i]['phone'];
                    Get.toNamed(krEditStorePhoneNumber);
                  },
                ),
              ),
            kH12sizedBox,
            for (int i = 0; i < storeController.storeEmailList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.storeEmailList[i]['email']), //*Use here api
                  isAddButton: false,
                  suffixOnPressed: () async {
                    storeController.storeEmailTextEditingController.text = storeController.storeEmailList[i]['email'];
                    Get.toNamed(krEditStoreEmail);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class StoreWebsiteSocialLinkContent extends StatelessWidget {
  StoreWebsiteSocialLinkContent({super.key});
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
              suffixText: ksWebsiteAndSocialLinks.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              isAddButton: true,
              suffixOnPressed: () {},
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.websiteAndSocialLinkList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.websiteAndSocialLinkList[i]), //*Use here api
                  isAddButton: false,
                  suffixOnPressed: () async {
                    // storeController.storePhoneNumberTextEditingController.text = storeController.websiteAndSocialLinkList[i]['phone'];
                    Get.toNamed(krEditStorePhoneNumber);
                  },
                ),
              ),
          ],
        ),
      ),
    );
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
                    // KidHelper().resetKidRelationEditPage();
                    // Get.toNamed(krKidEditRelation);
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
              suffixOnPressed: () {},
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.paymentMethodList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.paymentMethodList[i]['payment']), //*Use here api
                  subtitlePrefixText: checkNullOrStringNull(storeController.paymentMethodList[i]['paymentGetway']), //*Use here api
                  isAddButton: false,
                  suffixOnPressed: () async {
                    // storeController.storePhoneNumberTextEditingController.text = storeController.websiteAndSocialLinkList[i]['phone'];
                    Get.toNamed(krEditStorePhoneNumber);
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
                  subtitlePrefixText: storeController.storeBIN.value,
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: false,
                  suffixOnPressed: () {
                    // KidHelper().resetKidRelationEditPage();
                    // Get.toNamed(krKidEditRelation);
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
                  subtitlePrefixText: storeController.qrCode.value,
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: false,
                  suffixOnPressed: () {
                    // KidHelper().resetKidRelationEditPage();
                    // Get.toNamed(krKidEditRelation);
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
                // kidHelper.addKidEducationBackground();
              },
            ),
            kH12sizedBox,
            for (int i = 0; i < storeController.legalPaperAllInfoList.length; i++) //! using api
              Padding(
                padding: const EdgeInsets.only(bottom: k12Padding),
                child: InfoContainer(
                  suffixText: '',
                  prefixText: checkNullOrStringNull(storeController.legalPaperAllInfoList[i]['fileName']), //*Use here api
                  subtitlePrefixText: checkNullOrStringNull(storeController.legalPaperAllInfoList[i]['fileSize']),
                  suffixOnPressed: () async {
                    // kidHelper.editKidSchool(i);
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
  StorePageTransperencyContent({super.key});
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
              // kidsController.kidOverviewData.value?.kids?.pageId ?? ksNA,//!From api data
              '12345678',
              style: regular16TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Text(
              ksPageId.tr,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH16sizedBox,
            Text(
              // DateFormat('dd MMM, yyyy').format(kidsController.kidOverviewData.value?.kids!.createdAt ?? DateTime.now()),//! data from Api
              DateFormat('dd MMM, yyyy').format(DateTime.now()),
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
