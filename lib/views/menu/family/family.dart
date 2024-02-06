import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/helpers/menu/family/family_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class Family extends StatelessWidget {
  Family({super.key});
  final GlobalController globalController = Get.find<GlobalController>();
  final FamilyController familyController = Get.find<FamilyController>();
  final FamilyHelper familyHelper = FamilyHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    title: ksFamily.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: k20Padding),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            unfocus(context);
                            familyController.isRouteFromAllFriend.value = false;
                            familyController.selectedAddFamilyFullName.value = '';
                            familyController.selectedAddFamilyProfilePicture.value = '';
                            familyHelper.routeToAddFamilyPage();
                          },
                          child: Text(
                            ksAdd.tr,
                            style: semiBold16TextStyle(cPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH4sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: TapAbleButtonContainer(
                          buttonText: globalController.tapAbleButtonText,
                          buttonState: globalController.tapAbleButtonState,
                          buttonPress: RxList([
                            () {
                              unfocus(context);
                              familyHelper.allFamilyTapableButtOnPressed();
                            },
                            () {
                              unfocus(context);
                              familyHelper.receivedFamilyTapableButtOnPressed();
                            },
                            () {
                              unfocus(context);
                              familyHelper.pendingFamilyTapableButtOnPressed();
                            },
                          ]),
                        ),
                      ),
                      kH12sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: Obx(() => globalController.tapAbleButtonState[0]
                            ? CustomModifiedTextField(
                                borderRadius: h8,
                                controller: globalController.searchController,
                                prefixIcon: BipHip.search,
                                suffixIcon: familyController.isFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                hint: ksSearch.tr,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: k12Padding,
                                ),
                                textInputStyle: regular16TextStyle(cBlackColor),
                                onSuffixPress: () {
                                  familyHelper.familySearchFieldReset();
                                },
                                onSubmit: (v) {
                                  unfocus(context);
                                  familyController.isFamilySuffixIconVisible.value = false;
                                },
                                onChanged: (v) {
                                  familyHelper.searchFamily();
                                })
                            : const SizedBox()),
                      ),
                      if (globalController.tapAbleButtonState[0] || globalController.tapAbleButtonState[1]) kH4sizedBox,
                      if (globalController.tapAbleButtonState[0] || globalController.tapAbleButtonState[1])
                        (familyController.isFamilyListLoading.value || familyController.isReceivedFamilyListLoading.value)
                            ? Padding(
                                padding: const EdgeInsets.only(left: kHorizontalPadding),
                                child: ShimmerCommon(
                                  widget: Container(
                                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                    height: 16,
                                    width: 160,
                                  ),
                                ),
                              )
                            : Padding(padding: const EdgeInsets.symmetric(horizontal: k20Padding), child: familyHelper.totalFamilyCountShow()),
                      if (globalController.tapAbleButtonState[0] || globalController.tapAbleButtonState[1]) kH12sizedBox,
                      if (globalController.tapAbleButtonState[2]) kH4sizedBox,
                      globalController.familyListView(),
                    ],
                  ),
                ),
              ),
            ),
            if (familyController.isFamilyRequestListLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (familyController.isFamilyRequestListLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
