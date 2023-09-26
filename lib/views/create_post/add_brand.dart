import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBrandPage extends StatelessWidget {
  AddBrandPage({super.key});

  final CreatePostController _createPostController = Get.find<CreatePostController>();

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
              title: "Add Brand",
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
                    onPressed: () {
                      _createPostController.selectCategoryTextChange(context);
                    },
                    child: Text(
                      "Add",
                      style: medium14TextStyle(cPrimaryColor),
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
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(kiLogoImageUrl),
                    ),
                    isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                    OutLinedButton(
                      onPress: null,
                      buttonText: "Upload Image",
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
                          controller: TextEditingController(),
                          hint: "Write brand name",
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                        ),
                        Text(
                          "Add Social Links (Minimum 1)",
                          style: medium14TextStyle(cBlackColor),
                        ),
                        kH8sizedBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: SvgPicture.asset(
                                kiBadgeSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "Write here...",
                                onChanged: (text) {},
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        kH8sizedBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: SvgPicture.asset(
                                kiBadgeSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "Write here...",
                                onChanged: (text) {},
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        kH8sizedBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: SvgPicture.asset(
                                kiBadgeSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "Write here...",
                                onChanged: (text) {},
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        kH8sizedBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: SvgPicture.asset(
                                kiBadgeSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "Write here...",
                                onChanged: (text) {},
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        kH8sizedBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: SvgPicture.asset(
                                kiBadgeSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "Write here...",
                                onChanged: (text) {},
                                onSubmit: (text) {},
                                inputAction: TextInputAction.next,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ],
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
    );
  }
}
