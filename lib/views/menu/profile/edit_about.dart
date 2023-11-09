import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/birthday_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/contact_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/education_background_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/gender_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/interest_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/place_edit_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/profession_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/relationship_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/website_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/workplace_section.dart';
import 'package:bip_hip/widgets/common/button/custom_modified_text_button.dart';

class EditAboutInfo extends StatelessWidget {
  EditAboutInfo({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

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
                body: SizedBox(
                  height: height - kAppBarSize,
                  width: width,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kH8sizedBox,
                        PlaceEditSection(),
                        kH8sizedBox,
                        EducationBackgroundSection(),
                        kH8sizedBox,
                        RelationshipSection(),
                        if (profileController.showAllEditOption.value) kH8sizedBox,
                        if (profileController.showAllEditOption.value) GenderSection(),
                        if (profileController.showAllEditOption.value) kH8sizedBox,
                        if (profileController.showAllEditOption.value) BirthdaySection(),
                        if (profileController.showAllEditOption.value) kH8sizedBox,
                        if (profileController.showAllEditOption.value) ProfessionSection(),
                        if (profileController.showAllEditOption.value) kH8sizedBox,
                        if (profileController.showAllEditOption.value) InterestSection(),
                        kH8sizedBox,
                        WorkplaceSection(),
                        kH8sizedBox,
                        if (profileController.showAllEditOption.value) ContactSection(),
                        kH8sizedBox,
                        if (profileController.showAllEditOption.value) WebsiteSection(),
                        kH12sizedBox
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (profileController.isEditProfileLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (profileController.isEditProfileLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class InfoContainer2 extends StatelessWidget {
  const InfoContainer2(
      {super.key,
      required this.suffixText,
      this.suffixOnPressed,
      this.prefixText,
      required this.isAddButton,
      this.subtitlePrefixText,
      this.subtitleSuffixText,
      this.suffixTextStyle});
  final String suffixText;
  final String? prefixText, subtitlePrefixText, subtitleSuffixText;
  final TextStyle? suffixTextStyle;
  final VoidCallback? suffixOnPressed;
  final bool isAddButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    overflow: TextOverflow.clip,
                    text: TextSpan(children: [
                      if (prefixText != null) TextSpan(text: '$prefixText ', style: regular16TextStyle(cBlackColor)),
                      TextSpan(
                        text: suffixText,
                        style: suffixTextStyle ?? semiBold16TextStyle(cBlackColor),
                      )
                    ])),
                if (subtitlePrefixText != null || subtitleSuffixText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: k4Padding),
                    child: RichText(
                        overflow: TextOverflow.clip,
                        text: TextSpan(children: [
                          TextSpan(text: '$subtitlePrefixText ', style: regular12TextStyle(cSmallBodyTextColor)),
                          TextSpan(
                            text: subtitleSuffixText,
                            style: regular12TextStyle(cSmallBodyTextColor),
                          )
                        ])),
                  ),
              ],
            ),
          ),
          isAddButton
              ? CustomTextButtonV2(
                  onPressed: suffixOnPressed,
                  text: ksAdd.tr,
                  textStyle: semiBold16TextStyle(cPrimaryColor),
                  prefixWidget: Icon(
                    BipHip.addNew,
                    color: cPrimaryColor,
                    size: isDeviceScreenLarge() ? h20 : h16,
                  ),
                )
              : InkWell(
                  onTap: suffixOnPressed,
                  child: Icon(
                    BipHip.edit,
                    size: screenWiseSize(kIconSize22, 4),
                    color: cIconColor,
                  ),
                ),
        ],
      ),
    );
  }
}

class CancelSaveButton extends StatelessWidget {
  const CancelSaveButton({super.key, required this.onPressedCancel, required this.onPressedSave});
  final VoidCallback onPressedCancel, onPressedSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomElevatedButton(
            label: ksCancel.tr,
            textStyle: semiBold14TextStyle(cRedColor),
            buttonColor: cWhiteColor,
            borderColor: cRedColor,
            buttonHeight: h32,
            buttonWidth: 80,
            onPressed: onPressedCancel),
        kW16sizedBox,
        CustomElevatedButton(label: ksSave.tr, textStyle: semiBold14TextStyle(cWhiteColor), buttonHeight: h32, buttonWidth: 80, onPressed: onPressedSave),
      ],
    );
  }
}

class RowTextButton extends StatelessWidget {
  const RowTextButton(
      {super.key,
      required this.text,
      required this.buttonText,
      required this.showAddButton,
      this.onPressedAdd,
      required this.buttonWidth,
      this.suffixWidget,
      this.textStyle});
  final String text, buttonText;
  final bool showAddButton;
  final VoidCallback? onPressedAdd;
  final double buttonWidth;
  final Widget? suffixWidget;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: textStyle ?? semiBold16TextStyle(cBlackColor),
        ),
        if (showAddButton && suffixWidget == null)
          CustomTextButtonV2(
            onPressed: onPressedAdd,
            text: buttonText,
            textStyle: semiBold14TextStyle(cPrimaryColor),
            prefixWidget: Icon(
              BipHip.addNew,
              color: cPrimaryColor,
              size: isDeviceScreenLarge() ? h20 : h16,
            ),
          ),
        if (suffixWidget != null)
          TextButton(
            onPressed: onPressedAdd,
            style: kTextButtonStyle,
            child: suffixWidget!,
          ),
      ],
    );
  }
}
