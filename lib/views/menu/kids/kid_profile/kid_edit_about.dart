import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_basic_info_section.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_contact_section.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_education_background.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_select_hobbies.dart';
import 'package:bip_hip/widgets/common/button/custom_modified_text_button.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:intl/intl.dart';

class KidEditAboutInfo extends StatelessWidget {
  KidEditAboutInfo({super.key});

  final KidsController kidsController = Get.find<KidsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Stack(
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
                      const KidRelationContent(),
                      kH8sizedBox,
                      KidEducationBackground(),
                      kH8sizedBox,
                      KidSelectHobbies(),
                      kH8sizedBox,
                      KidBasicInfoSection(),
                      kH8sizedBox,
                      KidContactSection(),
                      kH8sizedBox,
                      Container(
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
                                kidsController.kidOverviewData.value?.kids?.pageId ?? ksNA,
                                style: regular16TextStyle(cBlackColor),
                              ),
                              kH4sizedBox,
                              Text(
                                ksPageId.tr,
                                style: regular10TextStyle(cSmallBodyTextColor),
                              ),
                              kH16sizedBox,
                              Text(
                                DateFormat('dd MMM, yyyy').format(kidsController.kidOverviewData.value?.kids!.createdAt ?? DateTime.now()),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer(
      {super.key,
      required this.suffixText,
      this.suffixOnPressed,
      this.prefixText,
      this.isAddButton,
      this.subtitlePrefixText,
      this.subtitleSuffixText,
      this.suffixTextStyle,
      this.subTitlePrefixTextStyle});
  final String suffixText;
  final String? prefixText, subtitlePrefixText, subtitleSuffixText;
  final TextStyle? suffixTextStyle, subTitlePrefixTextStyle;
  final VoidCallback? suffixOnPressed;
  final bool? isAddButton;

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
                      text: TextSpan(
                        children: [
                          TextSpan(text: '$subtitlePrefixText ', style: subTitlePrefixTextStyle ?? regular12TextStyle(cSmallBodyTextColor)),
                          TextSpan(
                            text: subtitleSuffixText,
                            style: regular12TextStyle(cSmallBodyTextColor),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isAddButton != null)
            isAddButton!
                ? CustomModifiedTextButton(
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
          CustomModifiedTextButton(
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

class KidRelationContent extends StatelessWidget {
  const KidRelationContent({super.key});

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
                  suffixText: ksRelation.tr,
                  subtitlePrefixText: Get.find<KidsController>().kidRelation.value == null
                      ? ksRelation.tr
                      : checkNullOrStringNull(Get.find<KidsController>().kidRelation.value),
                  subTitlePrefixTextStyle: regular16TextStyle(cBlackColor),
                  isAddButton: false,
                  suffixOnPressed: () {
                    Get.toNamed(krKidEditRelation);
                  },
                )),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}

class KidEditRelationPage extends StatelessWidget {
  KidEditRelationPage({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();
  final FocusNode partnerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(() => Stack(
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
                      title: ksEditRelation.tr,
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
                        SizedBox(
                          height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              children: [
                                kH16sizedBox,
                                CustomSelectionButton(
                                  buttonHeight: h50,
                                  onPressed: () async {
                                    unFocus(context);
                                    kidHelper.kidRelationButtonOnPressed(context);
                                    await kidsController.getKidRelationList();
                                  },
                                  text: kidsController.kidRelation.value,
                                  hintText: kidsController.kidRelation.value == '' ? ksSelectRelationshipStatus.tr : kidsController.kidRelation.value,
                                ),
                                kH16sizedBox,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: CustomElevatedButton(
                              label: ksSave,
                              textStyle: semiBold14TextStyle(cWhiteColor),
                              buttonHeight: h42,
                              buttonWidth: width - 40,
                              onPressed: kidsController.isKidRelationSaveButtonActive.value
                                  ? () async {
                                      unFocus(context);
                                      await kidsController.updateKidRelation();
                                    }
                                  : null),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (kidsController.isKidRelationLoading.value)
                Positioned(
                  child: CommonLoadingAnimation(
                    onWillPop: () async {
                      if (kidsController.isKidRelationLoading.value) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
            ],
          )),
    );
  }
}
