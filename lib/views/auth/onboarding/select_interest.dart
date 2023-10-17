import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class SelectInterestScreen extends StatelessWidget {
  SelectInterestScreen({super.key});

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
          body: Obx(
            () => _profileController.isInterestListLoading.value
                ? CommonLoadingAnimation(
                    backgroundColor: cWhiteColor,
                    onWillPop: () async {
                      return true;
                    },
                  )
                : SizedBox(
                    width: width,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          children: [
                            if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                            if (!_profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                            TopTitleAndSubtitle(
                              title: _profileController.isRouteFromAboutInfo.value ? "" : ksChooseInterest.tr,
                              subTitle: _profileController.isRouteFromAboutInfo.value ? ksEditInterestSubtitle : ksCHooseInterestSubtitle.tr,
                            ),
                            kH16sizedBox,
                            Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              spacing: 8.0,
                              children: [
                                for (int i = 0; i < _globalController.interestList.length; i++)
                                  CustomChoiceChips(
                                    label: _globalController.interestList[i],
                                    isSelected: (_globalController.interestIndex.contains(i)),
                                    onSelected: (value) {
                                      if (!_globalController.interestIndex.contains(i)) {
                                        _globalController.interestIndex.add(i);
                                      } else {
                                        _globalController.interestIndex.remove(i);
                                      }
                                      ll(_globalController.interestIndex);
                                    },
                                  )
                              ],
                            ),
                            kH16sizedBox,
                            CustomElevatedButton(
                              label: _profileController.isRouteFromAboutInfo.value ? ksSave : ksNext.tr,
                              onPressed: _globalController.interestIndex.isNotEmpty
                                  ? () async {
                                      if (!_profileController.isRouteFromAboutInfo.value) {
                                        for (int i = 0; i < _globalController.interestIndex.length; i++) {
                                          _globalController.selectedInterests.add(_globalController.interestList[_globalController.interestIndex[i]]);
                                        }
                                        Get.toNamed(krUploadPicture);
                                        _globalController.resetChipSelection();
                                      } else {
                                        _globalController.selectedInterests.clear();
                                        for (int i = 0; i < _globalController.interestIndex.length; i++) {
                                          _globalController.selectedInterests.add(_globalController.interestList[_globalController.interestIndex[i]]);
                                        }
                                        Get.back();
                                        _profileController.isRouteFromAboutInfo.value = false;
                                      }
                                      await _profileController.setInterest(_globalController.selectedInterests);
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
