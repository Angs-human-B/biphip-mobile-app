import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SelectProfessionScreen extends StatelessWidget {
  SelectProfessionScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: profileController.isRouteFromAboutInfo.value ? cWhiteColor : null,
      decoration: !profileController.isRouteFromAboutInfo.value
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
              isCenterTitle: profileController.isRouteFromAboutInfo.value,
              appBarColor: profileController.isRouteFromAboutInfo.value ? cWhiteColor : cTransparentColor,
              hasBackButton: profileController.isRouteFromAboutInfo.value,
              title: globalController.selectedProfession.value != '' && profileController.isRouteFromAboutInfo.value ? ksEditProfession.tr : profileController.isRouteFromAboutInfo.value ? ksAddProfession.tr:  '',
              onBack: () {
                Get.back();
              },
              action: [
                if (!profileController.isRouteFromAboutInfo.value)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CustomTextButton(
                        onPressed: () async {
                          globalController.interestIndex.clear();
                          Get.toNamed(krSelectInterest);
                          await profileController.getInterestList();
                        },
                        text: ksSkip.tr,
                        textStyle: regular14TextStyle(cPrimaryColor)),
                  )
              ],
            ),
          ),
          backgroundColor: profileController.isRouteFromAboutInfo.value ? cWhiteColor : cTransparentColor,
          body: Obx(
            () => profileController.isProfessionListLoading.value
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
                            if (!profileController.isRouteFromAboutInfo.value) kH48sizedBox,
                            TopTitleAndSubtitle(
                              title: !profileController.isRouteFromAboutInfo.value ? ksChooseProfession.tr : '',
                              subTitle: profileController.isRouteFromAboutInfo.value ? ksEditInterestSubtitle : ksChooseProfessionSubtitle.tr,
                            ),
                            kH16sizedBox,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                spacing: 8.0,
                                children: [
                                  for (int i = 0; i < globalController.professionList.length; i++)
                                    CustomChoiceChips(
                                      label: globalController.professionList[i],
                                      isSelected: (globalController.professionIndex.value == i),
                                      onSelected: (value) {
                                        globalController.professionIndex.value = i;
                                      },
                                    )
                                ],
                              ),
                            ),
                            kH16sizedBox,
                            CustomElevatedButton(
                              label: profileController.isRouteFromAboutInfo.value ? ksSave.tr : ksNext.tr,
                              onPressed: globalController.professionIndex.value != -1
                                  ? () async {
                                      registrationHelper.saveProfession();
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
