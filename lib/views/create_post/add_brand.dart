// import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBrandPage extends StatelessWidget {
  const AddBrandPage({super.key});

  // final CreatePostController _createPostController = Get.find<CreatePostController>();

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
                    onPressed: () {
                      unfocus(context);
                      Get.back();
                    },
                    child: Text(
                      ksAdd.tr,
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
                          controller: TextEditingController(),
                          hint: ksWriteBrandName.tr,
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                        ),
                        Text(
                          ksAddSocialLinks.tr,
                          style: medium14TextStyle(cBlackColor),
                        ),
                        kH8sizedBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: SvgPicture.asset(
                                kiWebSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 36,
                                width: 36,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "${ksWriteHere.tr}...",
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
                                kiFacebookSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 36,
                                width: 36,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "${ksWriteHere.tr}...",
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
                                kiLinkedListSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 36,
                                width: 36,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "${ksWriteHere.tr}...",
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
                                kiTwitterSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 36,
                                width: 36,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "${ksWriteHere.tr}...",
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
                                kiYoutubeSvgImageUrl,
                                fit: BoxFit.fill,
                                height: 36,
                                width: 36,
                              ),
                            ),
                            kW8sizedBox,
                            Expanded(
                              child: CustomModifiedTextField(
                                controller: TextEditingController(),
                                hint: "${ksWriteHere.tr}...",
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
