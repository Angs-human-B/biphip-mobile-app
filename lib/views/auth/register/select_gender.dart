import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';


class SelectGender extends StatelessWidget {
  SelectGender({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksRegisterNow.tr,
              onBack: () async {
                Get.back();
              },
            ),
          ),
          backgroundColor: cWhiteColor,
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Obx(
                  () => Column(
                    children: [
                      kH24sizedBox,
                      kH24sizedBox,
                      const TopTitleAndSubtitle(
                        title: 'What\'s your gender?',
                        subTitle: 'You can change your gender from your profile settings.',
                      ),
                      kH50sizedBox,
                      CustomSelectionButton(
                        onPressed: () {},
                        text: _authenticationController.gender.value,
                        hintText: "Select gender",
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.gender.value == ''
                            ? () {
                                Get.toNamed(krSetEmail);
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle:
                            _authenticationController.gender.value != '' ? semiBold16TextStyle(cBlackColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
