import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBrandPage extends StatelessWidget {
  AddBrandPage({super.key});

  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createHelper = CreatePostHelper();
  final GlobalController globalController = Get.find<GlobalController>();
  final FocusNode businessTypeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
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
                    title: ksAddBrand.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: h20),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: createPostController.isSaveBrandButtonEnabled.value
                              ? () async {
                                  createPostController.createLinkList();
                                  await createPostController.addBrand(); //!Api call
                                  createPostController.isBrandAdded.value = true;
                                  createPostController.selectedBrandName.value = createPostController.brandNameTextEditingController.text;
                                  createPostController.selectedBrandImageFile.value = createPostController.brandImageFile.value;
                                  Get.back();
                                  createHelper.resetAddBrandPage();
                                }
                              : null,
                          child: Text(
                            ksAdd.tr,
                            style: createPostController.isSaveBrandButtonEnabled.value ? medium14TextStyle(cPrimaryColor) : medium14TextStyle(cLineColor2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: cBlackColor,
                              ),
                              child: Image.file(
                                createPostController.brandImageFile.value,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Padding(
                                  padding: EdgeInsets.only(top: 10, right: 5),
                                  child: Icon(
                                    BipHip.imageFile,
                                    size: kIconSize60,
                                    color: cIconColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                          OutLinedButton(
                            onPress: () {
                              globalController.commonBottomSheet(
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
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomElevatedButton(
                                        label: ksAddPhoto.tr,
                                        prefixIcon: BipHip.camera,
                                        prefixIconColor: cIconColor,
                                        suffixIconColor: cIconColor,
                                        onPressed: () async {
                                          await globalController.selectImageSource(createPostController.isBrandImageChanged,
                                              createPostController.brandImageLink, createPostController.brandImageFile, 'camera', true);
                                          createPostController.checkCanSaveBrand();
                                        },
                                        buttonHeight: h32,
                                        buttonWidth: width - 40,
                                        buttonColor: cWhiteColor,
                                        borderColor: cLineColor,
                                        textStyle: semiBold14TextStyle(cBlackColor),
                                      ),
                                      kH16sizedBox,
                                      CustomElevatedButton(
                                        label: ksChooseFromGallery.tr,
                                        prefixIcon: BipHip.photo,
                                        prefixIconColor: cIconColor,
                                        suffixIconColor: cIconColor,
                                        onPressed: () async {
                                          await globalController.selectImageSource(createPostController.isBrandImageChanged,
                                              createPostController.brandImageLink, createPostController.brandImageFile, 'gallery', true);
                                          createPostController.checkCanSaveBrand();
                                        },
                                        buttonHeight: h32,
                                        buttonWidth: width - 40,
                                        buttonColor: cWhiteColor,
                                        borderColor: cLineColor,
                                        textStyle: semiBold14TextStyle(cBlackColor),
                                      ),
                                    ],
                                  ));
                            },
                            buttonText: ksUploadImage.tr,
                            borderColor: cPrimaryColor,
                            buttonHeight: 32,
                            buttonWidth: 150,
                            suffixWidget: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                BipHip.addImage,
                                size: isDeviceScreenLarge() ? h20 : h16,
                                color: cPrimaryColor,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isDeviceScreenLarge() ? kH40sizedBox : kH30sizedBox,
                              CustomModifiedTextField(
                                controller: createPostController.brandNameTextEditingController,
                                hint: ksWriteBrandName.tr,
                                onChanged: (text) {
                                  createPostController.checkCanSaveBrand();
                                },
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                              RawAutocomplete(
                                textEditingController: createPostController.businessTypeTextEditingController,
                                focusNode: businessTypeFocusNode,
                                optionsBuilder: (TextEditingValue textEditingValue) {
                                  return createPostController.businessType.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                                },
                                onSelected: (option) {
                                  createPostController.businessTypeTextEditingController.text = option;
                                  createPostController.checkCanSaveBrand();
                                },
                                optionsViewBuilder: (context, Function(String) onSelected, options) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: width - 40,
                                      child: Material(
                                        elevation: 4,
                                        child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final option = options.elementAt(index);
                                            return CustomListTile(
                                              title: Text(
                                                option.toString(),
                                                style: medium16TextStyle(cBlackColor),
                                              ),
                                              onPressed: () {
                                                onSelected(option.toString());
                                                createPostController.businessTypeTextEditingController.text = option.toString();
                                                createPostController.checkCanSaveBrand();
                                                createPostController.isAddBrandSuffixIconVisible.value = false;
                                                unfocus(context);
                                              },
                                            );
                                          },
                                          separatorBuilder: (context, index) => Container(
                                            height: 1,
                                            color: cLineColor,
                                          ),
                                          itemCount: options.length,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                  return Obx(
                                    () => CustomModifiedTextField(
                                      focusNode: focusNode,
                                      controller: createPostController.businessTypeTextEditingController,
                                      hint: ksSelectBusinessType.tr,
                                      suffixIcon: createPostController.isAddBrandSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                      onSuffixPress: () {
                                        createPostController.isAddBrandSuffixIconVisible.value = false;
                                        createPostController.businessTypeTextEditingController.clear();
                                        createPostController.checkCanSaveBrand();
                                      },
                                      onChanged: (text) {
                                        if (createPostController.businessTypeTextEditingController.text.trim() != '') {
                                          createPostController.isAddBrandSuffixIconVisible.value = true;
                                        } else {
                                          createPostController.isAddBrandSuffixIconVisible.value = false;
                                        }
                                        createPostController.checkCanSaveBrand();
                                      },
                                      onSubmit: (text) {
                                        createPostController.isAddBrandSuffixIconVisible.value = false;
                                      },
                                      inputAction: TextInputAction.next,
                                      inputType: TextInputType.text,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                ksAddSocialLinks.tr,
                                style: medium14TextStyle(cBlackColor),
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandWebLinkTextEditingController,
                                iconImage: kiWebSvgImageUrl,
                                hintText: 'Enter a valid url',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandFacebookLinkTextEditingController,
                                iconImage: kiFacebookSvgImageUrl,
                                hintText: 'facebook.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandInstagramTextEditingController,
                                iconImage: kiInstagramSvgUrl,
                                // iconImage: kiFacebookImageUrl,
                                hintText: 'instagram.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandLinkedInLinkTextEditingController,
                                iconImage: kiLinkedInSvgImageUrl,
                                hintText: 'linkedin.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandTwitterTextEditingController,
                                iconImage: kiTwitterX2SvgUrl,
                                // iconImage: kiFacebookImageUrl,
                                hintText: 'twitter.com/',
                              ),
                              kH8sizedBox,
                              AddLinkTextFields(
                                textEditingController: createPostController.brandYoutubeLinkTextEditingController,
                                iconImage: kiYoutubeSvgImageUrl,
                                hintText: 'youtube.com/',
                              ),
                              isDeviceScreenLarge() ? kH40sizedBox : kH30sizedBox,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (createPostController.isAddBrandPageLoading.value == true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (createPostController.isAddBrandPageLoading.value) {
                    return false;
                  }
                  return true;
                },
              ),
            ),
        ],
      ),
    );
  }
}

class AddLinkTextFields extends StatelessWidget {
  const AddLinkTextFields({super.key, required this.textEditingController, required this.iconImage, this.hintText});
  final TextEditingController textEditingController;
  final String iconImage;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return AddBrandCustomModifiedTextField(
      controller: textEditingController,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: cLineColor2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(k8BorderRadius)),
      ),
      hint: hintText,
      onChanged: (text) {
        Get.find<CreatePostController>().checkCanSaveBrand();
      },
      prefixWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Container(
              width: isDeviceScreenLarge() ? 49 : 47,
              height: isDeviceScreenLarge() ? 49 : 47,
              decoration: const BoxDecoration(
                color: cGreyBoxColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), bottomLeft: Radius.circular(k8BorderRadius)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(k8Padding),
                child: SvgPicture.asset(
                  iconImage,
                  fit: BoxFit.fill,
                  // height: h28,
                  // width: h28,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: k8Padding),
            child: SizedBox(
              height: isDeviceScreenLarge() ? 49 : 47,
              child: const VerticalDivider(
                thickness: 1,
                width: 1,
                color: cLineColor2,
              ),
            ),
          ),
        ],
      ),
      fillColor: cWhiteColor,
      onSubmit: (text) {},
      inputAction: TextInputAction.next,
      inputType: TextInputType.text,
    );
  }
}

class AddBrandCustomModifiedTextField extends StatelessWidget {
  final String? label, hint, errorText;
  final bool autoFocus, obscureText, readOnly;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength, maxLines, minLines;
  final Function(String)? onChanged;
  final Widget? counter;
  final FocusNode? focusNode;
  final Function()? onSuffixPress;
  final IconData? prefixIcon, suffixIcon;
  final TextStyle? textInputStyle, textHintStyle;
  final Color? fillColor;
  final bool? isFilled;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final InputBorder? border;
  final Widget? prefixWidget;

  const AddBrandCustomModifiedTextField({
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPress,
    this.counter,
    this.autoFocus = false,
    this.obscureText = false,
    this.readOnly = false,
    this.focusNode,
    this.maxLength = 255,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters = const [],
    required this.controller,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.onSubmit,
    this.onChanged,
    Key? key,
    this.errorText,
    this.textInputStyle,
    this.textHintStyle,
    this.contentPadding,
    this.fillColor,
    this.isFilled,
    this.borderRadius,
    this.border,
    this.prefixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputStyle = regular16TextStyle(cBlackColor);
    var hintStyle = regular16TextStyle(cPlaceHolderColor);
    return Theme(
      data: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused) || controller.text.isNotEmpty) {
            return cBlackColor;
          }
          return cIconColor;
        }),
        suffixIconColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused) || controller.text.isNotEmpty) {
            return cBlackColor;
          }
          return cIconColor;
        }),
      )),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        textCapitalization: TextCapitalization.sentences,
        style: textInputStyle ?? inputStyle,
        readOnly: readOnly,
        focusNode: focusNode,
        autofocus: autoFocus,
        maxLength: maxLength,
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        cursorColor: cBlackColor,
        decoration: InputDecoration(
          errorText: errorText,
          errorStyle: regular12TextStyle(cRedColor),
          isDense: true,
          filled: isFilled ?? true,
          prefixIcon: prefixWidget,
          prefixIconConstraints: const BoxConstraints(),
          suffixIconConstraints: const BoxConstraints(),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CustomIconButton(
                    onPress: onSuffixPress,
                    icon: suffixIcon,
                    hasBorder: false,
                    size: screenWiseSize(kIconSize20, 4),
                  ),
                )
              : null,
          fillColor: fillColor ?? cGreyBoxColor,
          alignLabelWithHint: true,
          labelText: label,
          hintText: hint,
          labelStyle: hintStyle,
          hintStyle: textHintStyle ?? hintStyle,
          counter: (counter == null) ? const SizedBox.shrink() : counter,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k16Padding),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? k4BorderRadius),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(k4BorderRadius),
            borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cRedColor),
          ),
          focusedBorder: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(k4BorderRadius),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(k4BorderRadius),
            borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cRedColor),
          ),
          disabledBorder: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(k4BorderRadius),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
          enabledBorder: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(k4BorderRadius),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
        ),
        autocorrect: false,
        keyboardType: inputType,
        textInputAction: inputAction,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
