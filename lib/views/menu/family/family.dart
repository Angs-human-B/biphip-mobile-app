import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/helpers/family_helpers/family_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class Family extends StatelessWidget {
  Family({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
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
                          onPressed: () async {
                            _familyHelper.familySearchFieldReset();
                            unfocus(context);
                            _familyController.clearAddFamilyData();
                            Get.toNamed(krAddFamily);
                            Get.find<FriendController>().getFriendListForAddFamily();
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
                          buttonText: _profileController.tapAbleButtonText,
                          buttonState: _profileController.tapAbleButtonState,
                          buttonPress: RxList([
                            () async {
                              FocusScope.of(context).unfocus();
                              _profileController.toggleType(0);
                              _familyHelper.familySearchFieldReset();
                              await _familyController.getFamilyList();
                            },
                            () async {
                              FocusScope.of(context).unfocus();
                              _profileController.toggleType(1);
                              _familyHelper.familySearchFieldReset();
                              await _familyController.getReceivedFamilyList();
                            },
                            () async {
                              FocusScope.of(context).unfocus();
                              _profileController.toggleType(2);
                              _familyHelper.familySearchFieldReset();
                              await _familyController.getSendFamilyRequestList();
                            },
                          ]),
                        ),
                      ),
                      kH12sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: Obx(() => _profileController.tapAbleButtonState[0]
                            ? CustomModifiedTextField(
                                borderRadius: h8,
                                controller: Get.find<ProfileController>().searchController,
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
                                onChanged: (v) async {
                                  if (Get.find<ProfileController>().searchController.text.trim() != '') {
                                    _familyController.isFamilySuffixIconVisible.value = true;
                                  } else {
                                    _familyController.isFamilySuffixIconVisible.value = false;
                                  }
                                })
                            : const SizedBox()),
                      ),
                      if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH4sizedBox,
                      if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1])
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
                      if (_profileController.tapAbleButtonState[0] || _profileController.tapAbleButtonState[1]) kH12sizedBox,
                      if (_profileController.tapAbleButtonState[2]) kH4sizedBox,
                      _profileController.allReceivedPendingFamilyView(),
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
