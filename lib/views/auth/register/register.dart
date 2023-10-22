import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/utils/custom_container.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class Register extends StatelessWidget {
  Register({super.key});

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
              title: ksRegistration.tr,
              hasBackButton: false,
              onBack: () async {
                Get.back();
              },
              action: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CustomCircularProgressBar(
                    percent: .16,
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
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      kH24sizedBox,
                      if (_authenticationController.isReferredRegistration.value)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                          child: CustomTintContainer(
                            width: width,
                            borderRadius: k100CircularBorderRadius,
                            widget: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k12Padding),
                              child: RichText(
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: '${ksYouAreRegisteringWith.tr} ', style: regular14TextStyle(cBlackColor)),
                                    TextSpan(
                                      text: 'John Doe',
                                      style: semiBold14TextStyle(cBlackColor),
                                    ),
                                    TextSpan(
                                      text: '\'s ${ksReferCodeSmall.tr}',
                                      style: regular14TextStyle(cBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      kH24sizedBox,
                      TopTitleAndSubtitle(
                        title: ksWhatFullName.tr,
                        subTitle: ksWriteRealName.tr,
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerFirstNameTextEditingController,
                        errorText: _authenticationController.firstNameError.value,
                        hint: ksFirstName.tr,
                        onChanged: (text) {
                          _authenticationController.checkName();
                          if (_authenticationController.registerFirstNameTextEditingController.text.trim() == '') {
                            _authenticationController.firstNameError.value = ksEmptyFirstNameErrorMessage.tr;
                          } else {
                            _authenticationController.firstNameError.value = "";
                          }
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                      ),
                      kH4sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerLastNameTextEditingController,
                        errorText: _authenticationController.lastNameError.value,
                        hint: ksLastName.tr,
                        onChanged: (text) {
                          _authenticationController.checkName();
                          if (_authenticationController.registerLastNameTextEditingController.text.trim() == '') {
                            _authenticationController.lastNameError.value = ksEmptyLastNameErrorMessage.tr;
                          } else {
                            _authenticationController.lastNameError.value = "";
                          }
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.name,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext.tr,
                        onPressed: _authenticationController.checkValidName.value
                            ? () {
                               unfocus(context);
                                Get.find<ProfileController>().isRouteFromAboutInfo.value = false;
                                _authenticationController.birthDay.value = '';
                                Get.toNamed(krSelectBirthday);
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle: _authenticationController.checkValidName.value
                            ? semiBold16TextStyle(cWhiteColor)
                            : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                      ),
                      kH24sizedBox,
                      LinkupTextRow(
                        prefix: ksAlreadyHaveAccount.tr,
                        suffix: ksLogin.tr,
                        onPressed: () {
                           unfocus(context);
                          Get.toNamed(krLogin);
                        },
                      )
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
