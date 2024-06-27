import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_manual_link_bank_account.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class PayoutBusinessInfo extends StatelessWidget {
  PayoutBusinessInfo({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksPayouts.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(
              () => Column(
                children: [
                  kH16sizedBox,
                  Text(
                    ksEnterBusinessInfo.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  Text(
                    ksUpdateYourBusinessInformationToVerify.tr,
                    style: regular14TextStyle(cSmallBodyTextColor),
                  ),
                  kH16sizedBox,
                  const CustomDivider(),
                  kH16sizedBox,
                  InkWell(
                    onTap: () {
                      dashboardController.temporarySelectedCountry.value = dashboardController.selectedCountry.value;
                      if (dashboardController.temporarySelectedCountry.value == "") {
                        dashboardController.dashboardPayoutCountryRightButtonState.value = false;
                      } else {
                        dashboardController.dashboardPayoutCountryRightButtonState.value = true;
                      }
                      Get.find<GlobalController>().commonBottomSheet(
                          context: context,
                          content: CountryBottomSheetContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {
                            dashboardController.selectedCountry.value = dashboardController.temporarySelectedCountry.value;
                            Get.back();
                          },
                          rightText: ksDone.tr,
                          rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                          title: ksCountry.tr,
                          isRightButtonShow: true,
                          isBottomSheetRightButtonActive: dashboardController.dashboardPayoutCountryRightButtonState);
                    },
                    child: Container(
                      width: width - 40,
                      height: h50,
                      decoration: BoxDecoration(
                        color: cWhiteColor,
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        border: Border.all(color: cLineColor2, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dashboardController.selectedCountry.value == "" ? ksCountry.tr : dashboardController.selectedCountry.value,
                              style: regular14TextStyle(cBlackColor),
                            ),
                            const Icon(
                              BipHip.downArrow,
                              color: cIconColor,
                              size: kIconSize20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kH16sizedBox,
                  InkWell(
                    onTap: () {
                      dashboardController.temporarySelectedBusinessType.value = dashboardController.selectedBusinessType.value;
                      if (dashboardController.temporarySelectedBusinessType.value == "") {
                        dashboardController.payoutBusinessTypeRightButtonState.value = false;
                      } else {
                        dashboardController.payoutBusinessTypeRightButtonState.value = true;
                      }
                      Get.find<GlobalController>().commonBottomSheet(
                          context: context,
                          content: BusinessTypeBottomSheetContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {
                            dashboardController.selectedBusinessType.value = dashboardController.temporarySelectedBusinessType.value;
                            Get.back();
                          },
                          rightText: ksDone.tr,
                          rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                          title: ksCountry.tr,
                          isRightButtonShow: true,
                          isBottomSheetRightButtonActive: dashboardController.payoutBusinessTypeRightButtonState);
                    },
                    child: Container(
                      width: width - 40,
                      height: h50,
                      decoration: BoxDecoration(
                        color: cWhiteColor,
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        border: Border.all(color: cLineColor2, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dashboardController.selectedBusinessType.value == "" ? ksSelectBusinessType.tr : dashboardController.selectedBusinessType.value,
                              style: regular14TextStyle(cBlackColor),
                            ),
                            const Icon(
                              BipHip.downArrow,
                              color: cIconColor,
                              size: kIconSize20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kH16sizedBox,
                  CustomModifiedTextField(
                    hint: ksPhoneNumber.tr,
                    fillColor: cWhiteColor,
                    controller: dashboardController.payoutBusinessPhoneNumberTextEditingController,
                    contentPadding: const EdgeInsets.all(k12Padding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(k4BorderRadius),
                      borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                    ),
                  ),
                  kH8sizedBox,
                  CustomModifiedTextField(
                    hint: ksEmail.tr,
                    fillColor: cWhiteColor,
                    controller: dashboardController.payoutBusinessEmailTextEditingController,
                    contentPadding: const EdgeInsets.all(k12Padding),
                    inputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(k4BorderRadius),
                      borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                    ),
                  ),
                  kH8sizedBox,
                  CustomModifiedTextField(
                    hint: ksVatOrGstRegistrationNumber.tr,
                    fillColor: cWhiteColor,
                    controller: dashboardController.payoutBusinessVatGstTextEditingController,
                    contentPadding: const EdgeInsets.all(k12Padding),
                    inputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(k4BorderRadius),
                      borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomElevatedButton(
                    buttonWidth: width - 40,
                    buttonHeight: h32,
                    label: ksSave.tr,
                    onPressed: () {
                      unFocus(context);
                      Get.back();
                    },
                    textStyle: semiBold16TextStyle(cWhiteColor),
                  ),
                  kH20sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BusinessTypeBottomSheetContent extends StatelessWidget {
  BusinessTypeBottomSheetContent({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => kH8sizedBox,
          itemCount: dashboardController.businessTypeList.length,
          itemBuilder: (context, index) {
            return Obx(() => CustomListTile(
                  onPressed: () {
                    dashboardController.temporarySelectedBusinessType.value = dashboardController.businessTypeList[index];
                    if (dashboardController.temporarySelectedBusinessType.value == "") {
                      dashboardController.payoutBusinessTypeRightButtonState.value = false;
                    } else {
                      dashboardController.payoutBusinessTypeRightButtonState.value = true;
                    }
                  },
                  itemColor:
                      dashboardController.temporarySelectedBusinessType.value == dashboardController.businessTypeList[index] ? cPrimaryTint3Color : cWhiteColor,
                  borderColor:
                      dashboardController.temporarySelectedBusinessType.value == dashboardController.businessTypeList[index] ? cPrimaryColor : cLineColor,
                  title: dashboardController.businessTypeList[index],
                ));
          },
        ),
      ],
    );
  }
}
