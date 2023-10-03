import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class SelectInterestScreen extends StatelessWidget {
  SelectInterestScreen({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

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
              hasBackButton: false,
              onBack: () {},
              action: [
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
                    kH24sizedBox,
                    kH24sizedBox,
                    TopTitleAndSubtitle(
                      title: ksChooseInterest.tr,
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
                      label: ksNext.tr,
                      onPressed: _authenticationController.interestIndex.isNotEmpty
                          ? () {
                              Get.toNamed(krUploadPicture);
                              _authenticationController.resetChipSelection();
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
