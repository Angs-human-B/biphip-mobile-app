import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SelectInterestScreen extends StatelessWidget {
  SelectInterestScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      // color: cWhiteColor ,
      decoration: !profileController.isRouteFromAboutInfo.value
          ? const BoxDecoration(color: cWhiteColor, image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover))
          : null,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              hasBackButton: profileController.isRouteFromAboutInfo.value,
              isCenterTitle: profileController.isRouteFromAboutInfo.value,
              title: profileController.isRouteFromAboutInfo.value ? 'Edit Interest' : '',
              appBarColor: profileController.isRouteFromAboutInfo.value ? cWhiteColor : cTransparentColor,
              onBack: () {
                Get.back();
              },
              action: [
                if (!profileController.isRouteFromAboutInfo.value)
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
          backgroundColor: profileController.isRouteFromAboutInfo.value ? cWhiteColor : cTransparentColor,
          body: Obx(
            () => profileController.isInterestListLoading.value
                ? CommonLoadingAnimation(
                    backgroundColor: cTransparentColor,
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
                            if (!profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                            if (!profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                            TopTitleAndSubtitle(
                              title: profileController.isRouteFromAboutInfo.value ? "" : ksChooseInterest.tr,
                              subTitle: profileController.isRouteFromAboutInfo.value ? ksEditInterestSubtitle : ksCHooseInterestSubtitle.tr,
                            ),
                            kH16sizedBox,
                            Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              spacing: 8.0,
                              children: [
                                for (int i = 0; i < globalController.interestList.length; i++)
                                  CustomChoiceChips(
                                    label: globalController.interestList[i],
                                    isSelected: (globalController.interestIndex.contains(i)),
                                    onSelected: (value) {
                                      registrationHelper.onSelectingInterest(i);
                                    },
                                  )
                              ],
                            ),
                            kH16sizedBox,
                            CustomElevatedButton(
                              label: profileController.isRouteFromAboutInfo.value ? ksSave : ksNext.tr,
                              onPressed: globalController.interestIndex.isNotEmpty
                                  ? () async {
                                      registrationHelper.onPressedSaveInterest();
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
