import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class SelectBirthday extends StatelessWidget {
  SelectBirthday({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final ProfileController _profileController = Get.find<ProfileController>();

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
              title: _profileController.isRouteFromAboutInfo.value ? ksEditBirthday.tr : ksRegistration.tr,
              onBack: () async {
                Get.back();
              },
              action: [
                if (!_profileController.isRouteFromAboutInfo.value)
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: CustomCircularProgressBar(
                      percent: 0.32,
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
                      if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                      if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                      TopTitleAndSubtitle(
                        title: !_profileController.isRouteFromAboutInfo.value ? ksWhatBirthday.tr : '',
                        subTitle: !_profileController.isRouteFromAboutInfo.value ? ksChangeBirthday.tr : ksChangeYourBirthdayFromHere.tr,
                      ),
                      _profileController.isRouteFromAboutInfo.value ? kH20sizedBox : kH50sizedBox,
                      CustomSelectionButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: height * 0.4,
                                  child: CupertinoDatePicker(
                                    maximumDate: DateTime.now().subtract(const Duration(days: 15 * 365)),
                                    initialDateTime: _authenticationController.birthDay.value != ''
                                        ? DateTime.parse(_authenticationController.birthDay.value)
                                        : DateTime.now().subtract(const Duration(days: 16 * 365)),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (value) {
                                      _authenticationController.birthDay.value = DateFormat("yyyy-MM-dd").format(value);
                                    },
                                  ),
                                );
                              });
                        },
                        text: _authenticationController.birthDay.value != '' ? _authenticationController.birthDay.value : '',
                        hintText: ksSelectDOB.tr,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: _profileController.isRouteFromAboutInfo.value ? ksSave.tr : ksNext.tr,
                        onPressed: _authenticationController.birthDay.value != ''
                            ? () async {
                                if (!_profileController.isRouteFromAboutInfo.value) {
                                  Get.toNamed(krSelectGender);
                                } else {
                                  _profileController.birthday.value = _authenticationController.birthDay.value;
                                  Get.back();
                                  await _profileController.updateDOB();
                                  _profileController.isRouteFromAboutInfo.value = false;
                                }
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle: _authenticationController.birthDay.value != ''
                            ? semiBold16TextStyle(cWhiteColor)
                            : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
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
