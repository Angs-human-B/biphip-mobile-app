import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/helpers/family_helpers/family_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class Family extends StatelessWidget {
  Family({super.key});
  final GlobalController _globalController = Get.find<GlobalController>();
  final FamilyController _familyController = Get.find<FamilyController>();
  final FamilyHelper _familyHelper = FamilyHelper();

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
                            _familyHelper.familyAddButtonOnPressed();
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
                          buttonText: _globalController.tapAbleButtonText,
                          buttonState: _globalController.tapAbleButtonState,
                          buttonPress: RxList([
                            () {
                              unfocus(context);
                              _familyHelper.allFamilyTapableButtOnPressed();
                            },
                            () {
                              unfocus(context);
                              _familyHelper.receivedFamilyTapableButtOnPressed();
                            },
                            () {
                              unfocus(context);
                              _familyHelper.pendingFamilyTapableButtOnPressed();
                            },
                          ]),
                        ),
                      ),
                      kH12sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: Obx(() => _globalController.tapAbleButtonState[0]
                            ? CustomModifiedTextField(
                                borderRadius: h8,
                                controller: _globalController.searchController,
                                prefixIcon: BipHip.search,
                                suffixIcon: _familyController.isFamilySuffixIconVisible.value ? BipHip.circleCrossNew : null,
                                hint: ksSearch.tr,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: k12Padding,
                                ),
                                textInputStyle: regular16TextStyle(cBlackColor),
                                onSuffixPress: () {
                                  _familyHelper.familySearchFieldReset();
                                },
                                onSubmit: (v) {
                                  unfocus(context);
                                  _familyController.isFamilySuffixIconVisible.value = false;
                                },
                                onChanged: (v) {
                                  _familyHelper.familyOnChanged();
                                })
                            : const SizedBox()),
                      ),
                      if (_globalController.tapAbleButtonState[0] || _globalController.tapAbleButtonState[1]) kH4sizedBox,
                      if (_globalController.tapAbleButtonState[0] || _globalController.tapAbleButtonState[1])
                        (_familyController.isFamilyListLoading.value || _familyController.isReceivedFamilyListLoading.value)
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
                            : Padding(padding: const EdgeInsets.symmetric(horizontal: k20Padding), child: _familyHelper.totalFamilyCountShow()),
                      if (_globalController.tapAbleButtonState[0] || _globalController.tapAbleButtonState[1]) kH12sizedBox,
                      if (_globalController.tapAbleButtonState[2]) kH4sizedBox,
                      _globalController.allReceivedPendingFamilyView(),
                    ],
                  ),
                ),
              ),
            ),
            if (_familyController.isCancelFamilyRequestLoading.value == true ||
                _familyController.isAcceptFamilyRequestLoading.value == true ||
                _familyController.isRejectFamilyRequestLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_familyController.isCancelFamilyRequestLoading.value ||
                        _familyController.isAcceptFamilyRequestLoading.value ||
                        _familyController.isRejectFamilyRequestLoading.value) {
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
