import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';

class AddKidBasicInfo extends StatelessWidget {
  AddKidBasicInfo({super.key});
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
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomDivider(
                  thickness: 1,
                ),
                KidTopTitleSubtitleAndCircularProgressBar(
                  title: ksBasicInfo.tr,
                  subTitle: ksOtherKnowAboutYourKid.tr,
                  circularCenterText: ks1of4.tr,
                  percent: 0.25,
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
                          controller: kidsController.kidNameTextEditingController,
                          hint: ksWriteKidName.tr,
                          errorText: kidsController.kidNameErrorText.value,
                          onChanged: (text) {
                            kidsController.kidNameOnChanged();
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                          maxLength: 50,
                        ),
                        kH8sizedBox,
                        CustomSelectionButton(
                          buttonHeight: h60,
                          onPressed: () async {},
                          text: '',
                          hintText: ksSelectRelation.tr,
                        ),
                        kH16sizedBox,
                        CustomModifiedTextField(
                          controller: kidsController.kidAgeTextEditingController,
                          hint: ksWriteAge.tr,
                          errorText: kidsController.kidAgeErrorText.value,
                          onChanged: (text) {
                            kidsController.kidAgeOnChanged();
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 3,
                        ),
                        kH8sizedBox,
                        CustomSelectionButton(
                          buttonHeight: h60,
                          onPressed: () async {},
                          text: '',
                          hintText: ksSelectGender.tr,
                        ),
                        kH16sizedBox,
                        CustomModifiedTextField(
                          controller: kidsController.kidSchoolNameTextEditingController,
                          hint: ksWriteSchoolName.tr,
                          onChanged: (text) {
                            kidsController.checkNextButtonEnable();
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.text,
                          maxLength: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                isDeviceScreenLarge() ? kH100sizedBox : kH60sizedBox,
                Obx(() => CustomElevatedButton(
                      buttonWidth: width - 40,
                      buttonHeight: h40,
                      label: ksNext.tr,
                      onPressed: kidsController.isNextButtonEnabled.value ? () {} : null,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KidTopTitleSubtitleAndCircularProgressBar extends StatelessWidget {
  const KidTopTitleSubtitleAndCircularProgressBar(
      {super.key, required this.title, required this.subTitle, required this.circularCenterText, required this.percent});
  final String title;
  final String subTitle;
  final String circularCenterText;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: semiBold18TextStyle(cBlackColor),
              ),
              kH4sizedBox,
              Text(
                subTitle,
                style: regular14TextStyle(cSmallBodyTextColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomCircularProgressBar(
              percent: percent,
              radius: h32,
              lineWidth: 5,
              centerWidget: Text(
                circularCenterText,
                style: regular16TextStyle(cBlackColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
