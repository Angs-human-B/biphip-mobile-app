import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class AddStoreSocialLinks extends StatelessWidget {
  AddStoreSocialLinks({super.key});
  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          resizeToAvoidBottomInset: false,
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
                      Get.toNamed(krAddStoreDocuments);
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
          body: Column(
            children: [
              const CustomDivider(
                thickness: 1,
              ),
              KidTopTitleSubtitleAndCircularProgressBar(
                title: ksSocialLinks.tr,
                subTitle: ksAddSocialLinksForStore.tr,
                circularCenterText: ks3of5.tr,
                percent: 0.6,
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
                    CustomModifiedTextField(
                      controller: storeController.storeWebsiteController,
                      hint: ksWebsite.tr,
                      onChanged: (text) {},
                      onSubmit: (text) {},
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      maxLength: 256,
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      controller: storeController.storeFacebookController,
                      hint: ksFacebook.tr,
                      onChanged: (text) {},
                      onSubmit: (text) {},
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      maxLength: 256,
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      controller: storeController.storeInstagramController,
                      hint: ksInstagram.tr,
                      onChanged: (text) {},
                      onSubmit: (text) {},
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      maxLength: 256,
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      controller: storeController.storeTwitterController,
                      hint: ksTwitter.tr,
                      onChanged: (text) {},
                      onSubmit: (text) {},
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      maxLength: 256,
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      controller: storeController.storeYoutubeController,
                      hint: ksYoutube.tr,
                      onChanged: (text) {},
                      onSubmit: (text) {},
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.text,
                      maxLength: 256,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomElevatedButton(
                buttonWidth: width - 40,
                buttonHeight: h40,
                label: ksNext.tr,
                onPressed: () {
                  unFocus(context);
                  storeController.storeSocialLink();
                  Get.toNamed(krAddStoreDocuments);
                },
                textStyle: semiBold16TextStyle(cWhiteColor),
              ),
              kH20sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
