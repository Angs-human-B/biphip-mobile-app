import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';
import 'package:flutter/cupertino.dart';


class SelectBirthday extends StatelessWidget {
  SelectBirthday({super.key});

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
              onBack: () async {
                Get.back();
              },
              action:const [
                Padding(
                  padding:  EdgeInsets.only(right: 8.0),
                  child:CustomCircularProgressBar(percent: 0.32,),
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
                        title: ksWhatBirthday,
                        subTitle: ksChangeBirthday,
                      ),
                      kH50sizedBox,
                      CustomSelectionButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: height * 0.4,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (value) {
                                      _authenticationController.birthDay.value = value.toString();
                                    },
                                  ),
                                );
                              });
                        },
                        text: _authenticationController.birthDay.value,
                        hintText: ksSelectDOB,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.birthDay.value != ''
                            ? () {
                                Get.toNamed(krSelectGender);
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
