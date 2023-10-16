import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class SelectGender extends StatelessWidget {
  SelectGender({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final ProfileController _profileController = Get.find<ProfileController>();
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
              title: ksRegistration.tr,
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
                      TopTitleAndSubtitle(
                        title: ksWhatGender.tr,
                        subTitle: ksChangeGender.tr,
                      ),
                      kH50sizedBox,
                      CustomSelectionButton(
                        onPressed: () {
                          _globalController.commonBottomSheet(
                            context: context,
                            content: _GenderListContent(
                              profileController: _profileController,
                            ),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {
                              if (_profileController.tempSelectedGender.value != '') {
                                _authenticationController.gender.value = _profileController.tempSelectedGender.value;
                                _profileController.isGenderSelected.value = true;
                              }
                              Get.back();
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: ksSelectGender.tr,
                            isRightButtonShow: true,
                            isScrollControlled: true,
                            bottomSheetHeight: height * 0.4,
                          );
                        },
                        text: _authenticationController.gender.value,
                        hintText: ksSelectGender.tr,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext.tr,
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

// class _GenderListContent extends StatelessWidget {
//   const _GenderListContent({
//     Key? key,
//     required this.authenticationController,
//   }) : super(key: key);

//   final AuthenticationController authenticationController;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Column(
//           // mainAxisSize: MainAxisSize.min,
//           children: [
//             RadioListTile(
//               title: Text(genders[0]),
//               value: genders[0],
//               activeColor: cPrimaryColor,
//               contentPadding: EdgeInsets.zero,
//               groupValue: authenticationController.gender.value,
//               controlAffinity: ListTileControlAffinity.trailing,
//               onChanged: (value) {
//                 authenticationController.gender.value = value;
//               },
//             ),
//             RadioListTile(
//               title: Text(genders[1]),
//               value: genders[1],
//               activeColor: cPrimaryColor,
//               contentPadding: EdgeInsets.zero,
//               groupValue: authenticationController.gender.value,
//               controlAffinity: ListTileControlAffinity.trailing,
//               onChanged: (value) {
//                 authenticationController.gender.value = value;
//               },
//             ),
//             RadioListTile(
//               title: Text(genders[2]),
//               value: genders[2],
//               activeColor: cPrimaryColor,
//               contentPadding: EdgeInsets.zero,
//               groupValue: authenticationController.gender.value,
//               controlAffinity: ListTileControlAffinity.trailing,
//               onChanged: (value) {
//                 authenticationController.gender.value = value;
//               },
//             ),
//           ],
//         ));
//   }
// }

class _GenderListContent extends StatelessWidget {
  const _GenderListContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: profileController.genderList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => RadioListTile(
                title: Text(profileController.genderList[index]),
                value: profileController.genderList[index],
                activeColor: cPrimaryColor,
                contentPadding: EdgeInsets.zero,
                groupValue: profileController.tempSelectedGender.value,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  profileController.tempSelectedGender.value = value;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
