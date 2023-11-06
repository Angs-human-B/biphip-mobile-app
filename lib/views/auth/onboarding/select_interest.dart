import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/auth_helpers/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SelectInterestScreen extends StatelessWidget {
  SelectInterestScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final RegistrationHelper _registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: _profileController.isRouteFromAboutInfo.value ? cWhiteColor : null,
      decoration: !_profileController.isRouteFromAboutInfo.value
          ? const BoxDecoration(image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover))
          : null,
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
              appBarColor: _profileController.isRouteFromAboutInfo.value ? cWhiteColor : cTransparentColor,
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
          backgroundColor: _profileController.isRouteFromAboutInfo.value ? cWhiteColor : cTransparentColor,
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
                                     _registrationHelper.onSelectingInterest(i);
                                    },
                                  )
                              ],
                            ),
                            kH16sizedBox,
                            CustomElevatedButton(
                              label: _profileController.isRouteFromAboutInfo.value ? ksSave : ksNext.tr,
                              onPressed: _globalController.interestIndex.isNotEmpty
                                  ? () async {
                                      _registrationHelper.onPressedSaveInterest();
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
