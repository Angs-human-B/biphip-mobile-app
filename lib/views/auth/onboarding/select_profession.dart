import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class SelectProfessionScreen extends StatelessWidget {
  SelectProfessionScreen({super.key});

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
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              isCenterTitle: _profileController.isRouteFromAboutInfo.value,
              hasBackButton: _profileController.isRouteFromAboutInfo.value,
              title: _profileController.isRouteFromAboutInfo.value ? ksEditYourProfession.tr : '',
              onBack: () {
                Get.back();
              },
              action: [
                if (!_profileController.isRouteFromAboutInfo.value)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CustomTextButton(
                        onPressed: () {
                          Get.toNamed(krSelectInterest);
                        },
                        text: ksSkip.tr,
                        textStyle: regular14TextStyle(cPrimaryColor)),
                  )
              ],
            ),
          ),
          backgroundColor: cWhiteColor,
          body: SizedBox(
            width: width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Obx(
                  () => Column(
                    children: [
                      if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                      if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                      TopTitleAndSubtitle(
                        title: !_profileController.isRouteFromAboutInfo.value ? ksChooseProfession.tr : '',
                        subTitle: ksChooseProfessionSubtitle.tr,
                      ),
                      kH16sizedBox,
                      Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 8.0,
                        children: [
                          for (int i = 0; i < _globalController.professionList.length; i++)
                            CustomChoiceChips(
                              label: _globalController.professionList[i],
                              isSelected: (_authenticationController.professionIndex.value == i && _authenticationController.isProfessionSelected.value),
                              onSelected: (value) {
                                _authenticationController.professionIndex.value = i;

                                _authenticationController.isProfessionSelected.value = value;
                              },
                            )
                        ],
                      ),
                      kH16sizedBox,
                      CustomElevatedButton(
                        label: _profileController.isRouteFromAboutInfo.value ? ksSave.tr : ksNext.tr,
                        onPressed: _authenticationController.isProfessionSelected.value
                            ? () async {
                                if (!_profileController.isRouteFromAboutInfo.value) {
                                  Get.toNamed(krSelectInterest);
                                } else {
                                  _profileController.selectedProfession.value =
                                      _globalController.professionList[_authenticationController.professionIndex.value];
                                  Get.back();
                                  await _profileController.setProfession(_profileController.selectedProfession.value);

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
      ),
    );
  }
}
