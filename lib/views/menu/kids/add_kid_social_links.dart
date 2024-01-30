import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class AddKidSocialLinks extends StatelessWidget {
  AddKidSocialLinks({super.key});
  final KidsController kidsController = Get.find<KidsController>();
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
              title: ksAddKid.tr,
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
                      Get.toNamed(krAddKidUploadImage);
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomDivider(
                  thickness: 1,
                ),
                KidTopTitleSubtitleAndCircularProgressBar(
                  title: ksSocialLinks.tr,
                  subTitle: ksAddSocialLinksForKid.tr,
                  circularCenterText: ks3of4.tr,
                  percent: 0.75,
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
                        controller: kidsController.kidWebsiteController,
                        hint: ksWebsite.tr,
                        onChanged: (text) {},
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        maxLength: 256,
                      ),
                      kH8sizedBox,
                      CustomModifiedTextField(
                        controller: kidsController.kidFacebookController,
                        hint: ksFacebook.tr,
                        onChanged: (text) {},
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        maxLength: 256,
                      ),
                      kH8sizedBox,
                      CustomModifiedTextField(
                        controller: kidsController.kidInstagramController,
                        hint: ksInstagram.tr,
                        onChanged: (text) {},
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        maxLength: 256,
                      ),
                      kH8sizedBox,
                      CustomModifiedTextField(
                        controller: kidsController.kidTwitterController,
                        hint: ksTwitter.tr,
                        onChanged: (text) {
                          kidsController.checkNextButtonEnable();
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        maxLength: 256,
                      ),
                      kH8sizedBox,
                      CustomModifiedTextField(
                        controller: kidsController.kidYoutubeController,
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
                kH100sizedBox,
                CustomElevatedButton(
                  buttonWidth: width - 40,
                  buttonHeight: h40,
                  label: ksNext.tr,
                  onPressed: () {
                    unFocus(context);
                    Get.toNamed(krAddKidUploadImage);
                  },
                  textStyle: semiBold16TextStyle(cWhiteColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
