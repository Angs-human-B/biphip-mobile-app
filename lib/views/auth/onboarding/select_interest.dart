import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class SelectInterestScreen extends StatelessWidget {
  SelectInterestScreen({super.key});

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
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              hasBackButton: _profileController.isRouteFromAboutInfo.value,
              isCenterTitle: _profileController.isRouteFromAboutInfo.value,
              title: _profileController.isRouteFromAboutInfo.value ? 'Edit Interest' : '',
              onBack: () {
                Get.back();
              },
              action: [
                if (!_profileController.isRouteFromAboutInfo.value)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CustomTextButton(
                        onPressed: () {
                          Get.toNamed(krUploadPicture);
                        },
                        text: ksSkip.tr,
                        textStyle: regular14TextStyle(cPrimaryColor)),
                  )
              ],
            ),
          ),
          backgroundColor: cWhiteColor,
          body: SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Obx(
                () => Column(
                  children: [
                    if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                    if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                    TopTitleAndSubtitle(
                      title: _profileController.isRouteFromAboutInfo.value ? "" : ksChooseInterest.tr,
                      subTitle: ksCHooseInterestSubtitle.tr,
                    ),
                    kH16sizedBox,
                    Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      spacing: 8.0,
                      children: [
                        for (int i = 0; i < interest.length; i++)
                          CustomChoiceChips(
                            label: interest[i],
                            isSelected: (_authenticationController.interestIndex.contains(i) && _authenticationController.isInterestSelected.value),
                            onSelected: (value) {
                              if (!_authenticationController.interestIndex.contains(i)) {
                                _authenticationController.isInterestSelected.value = value;
                                _authenticationController.interestIndex.add(i);
                              } else {
                                _authenticationController.interestIndex.remove(i);
                              }
                            },
                          )
                      ],
                    ),
                    const Spacer(),
                    CustomElevatedButton(
                      label: _profileController.isRouteFromAboutInfo.value ? ksSave : ksNext.tr,
                      onPressed: _authenticationController.interestIndex.isNotEmpty
                          ? () {
                              if (!_profileController.isRouteFromAboutInfo.value) {
                                Get.toNamed(krUploadPicture);
                                _authenticationController.resetChipSelection();
                              } else {
                                _profileController.selectedInterests.clear();
                                for (int i = 0; i < _authenticationController.interestIndex.length; i++) {
                                  _profileController.selectedInterests.add(interest[_authenticationController.interestIndex[i]]);
                                }
                                Get.back();
                                _profileController.isRouteFromAboutInfo.value = false;
                              }
                            }
                          : null,
                      buttonWidth: width - 40,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                    ),
                    kHBottomSizedBox
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
