import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class PayoutManualLinkBankAccount extends StatelessWidget {
  PayoutManualLinkBankAccount({super.key});
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH16sizedBox,
                    Text(
                      ksManualLinkBankAccount.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      "${ksEnterYourBankAccountInfo.tr}.",
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
                    CustomModifiedTextField(
                      hint: ksAccountHolderName.tr,
                      fillColor: cWhiteColor,
                      controller: dashboardController.accountHolderNameTextEditingController,
                      contentPadding: const EdgeInsets.all(k12Padding),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                      ),
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      hint: ksSWIFTCode.tr,
                      fillColor: cWhiteColor,
                      controller: dashboardController.swiftCodeTextEditingController,
                      inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      contentPadding: const EdgeInsets.all(k12Padding),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                      ),
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      hint: ksAccountNumber.tr,
                      fillColor: cWhiteColor,
                      controller: dashboardController.accountNumberTextEditingController,
                      inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      contentPadding: const EdgeInsets.all(k12Padding),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                      ),
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      hint: ksRoutingNumber.tr,
                      fillColor: cWhiteColor,
                      controller: dashboardController.routingNumberTextEditingController,
                      inputType: TextInputType.number,
                      contentPadding: const EdgeInsets.all(k12Padding),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                      ),
                    ),
                    // const Spacer(),
                    kH60sizedBox,
                    CustomElevatedButton(
                        buttonWidth: width - 40,
                        buttonHeight: h32,
                        buttonColor: cPrimaryColor,
                        textStyle: semiBold16TextStyle(cWhiteColor),
                        label: ksAdd,
                        onPressed: () {}),
                    kH20sizedBox,
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

class CountryBottomSheetContent extends StatelessWidget {
  CountryBottomSheetContent({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => kH8sizedBox,
          itemCount: dashboardController.countryList.length,
          itemBuilder: (context, index) {
            return Obx(() => CustomListTile(
                  onPressed: () {
                    dashboardController.temporarySelectedCountry.value = dashboardController.countryList[index];
                    if (dashboardController.temporarySelectedCountry.value == "") {
                      dashboardController.dashboardPayoutCountryRightButtonState.value = false;
                    } else {
                      dashboardController.dashboardPayoutCountryRightButtonState.value = true;
                    }
                  },
                  itemColor: dashboardController.temporarySelectedCountry.value == dashboardController.countryList[index] ? cPrimaryTint3Color : cWhiteColor,
                  borderColor: dashboardController.temporarySelectedCountry.value == dashboardController.countryList[index] ? cPrimaryColor : cLineColor,
                  title: dashboardController.countryList[index],
                ));
          },
        ),
      ],
    );
  }
}
