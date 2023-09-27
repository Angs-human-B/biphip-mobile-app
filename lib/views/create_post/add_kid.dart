import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';

class AddKidPage extends StatelessWidget {
  AddKidPage({super.key});

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
              title: "Add Kid",
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
                    onPressed: () {},
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
                          hint: "Write kid name",
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                          maxLength: 50,
                        ),
                        kH8sizedBox,
                        CustomModifiedTextField(
                          controller: TextEditingController(),
                          hint: "Write age",
                          onChanged: (text) {},
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.number,
                          maxLength: 3,
                        ),
                        kH8sizedBox,
                        CustomCheckBox(
                          value: true,
                          onChanged: (v) {},
                          label: "Save Kid’s information's for further use.",
                          textStyle: regular14TextStyle(cBlackColor),
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
