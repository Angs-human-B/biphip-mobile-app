import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';

class SelectGender extends StatelessWidget {
  SelectGender({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
              action: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CustomCircularProgressBar(
                    percent: 0.48,
                  ),
                ),
              ],
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
                        onPressed: () {
                          _globalController.commonBottomSheet(
                              context: context,
                              content: _GenderListContent(
                                authenticationController: _authenticationController,
                              ),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: null,
                              rightText: '',
                              rightTextStyle: regular10TextStyle(cBlackColor),
                              title: 'Select Gender',
                              isRightButtonShow: false,
                              bottomSheetHeight: 260);
                        },
                        text: _authenticationController.gender.value,
                        hintText: "Select gender",
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.gender.value != ''
                            ? () {
                                Get.toNamed(krSetEmail);
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle:
                            _authenticationController.gender.value != '' ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
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

class _GenderListContent extends StatelessWidget {
  const _GenderListContent({
    Key? key,
    required this.authenticationController,
  }) : super(key: key);

  final AuthenticationController authenticationController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text(genders[0]),
              value: genders[0],
              activeColor: cPrimaryColor,
              groupValue: authenticationController.gender.value,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                authenticationController.gender.value = value;
              },
            ),
            RadioListTile(
              title: Text(genders[1]),
              value: genders[1],
              activeColor: cPrimaryColor,
              groupValue: authenticationController.gender.value,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                authenticationController.gender.value = value;
              },
            ),
            RadioListTile(
              title: Text(genders[2]),
              value: genders[2],
              activeColor: cPrimaryColor,
              groupValue: authenticationController.gender.value,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                authenticationController.gender.value = value;
              },
            ),
          ],
        ));
  }
}
