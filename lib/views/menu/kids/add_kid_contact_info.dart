import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class AddKidContactInfo extends StatelessWidget {
  AddKidContactInfo({super.key});
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
                      Get.toNamed(krAddKidSocialLinks);
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
                  title: ksContactInfo.tr,
                  subTitle: ksAddParentContactInfo.tr,
                  circularCenterText: ks2of4.tr,
                  percent: 0.50,
                ),
                kH16sizedBox,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: CustomDivider(
                    thickness: 1,
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomModifiedTextField(
                          controller: kidsController.kidParentEmailController,
                          hint: ksParentEmail.tr,
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                          maxLength: 50,
                        ),
                        kH8sizedBox,
                        CustomModifiedTextField(
                          controller: kidsController.kidParentPhoneController,
                          hint: ksParentPhone.tr,
                          errorText: kidsController.kidAgeErrorText.value,
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 15,
                        ),
                        kH8sizedBox,
                        CustomModifiedTextField(
                          controller: kidsController.kidParentAddressController,
                          hint: ksParentAddress.tr,
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                          maxLength: 50,
                        ),
                        kH8sizedBox,
                        CustomModifiedTextField(
                          controller: kidsController.kidBioController,
                          hint: ksKidBio.tr,
                          onChanged: (text) {
                            kidsController.kidBioCount.value = text.length;
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.newline,
                          inputType: TextInputType.multiline,
                          maxLines: 5,
                          maxLength: 256,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${kidsController.kidBioCount.value}/256',
                              style: regular14TextStyle(cIconColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                kH100sizedBox,
                CustomElevatedButton(
                  buttonWidth: width - 40,
                  buttonHeight: h40,
                  label: ksNext.tr,
                  onPressed: () {
                    unFocus(context);
                    Get.toNamed(krAddKidSocialLinks);
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
