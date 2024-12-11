import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PayoutBankAccountTaxPassportInfoView extends StatelessWidget {
  PayoutBankAccountTaxPassportInfoView({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
            () => Stack(
          children: [SafeArea(
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
                  Container(
                    width: width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      color: cPrimaryTint4Color,
                      border: Border.all(color: cPrimaryTint1Color, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(k16Padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (dashboardController.payoutTypeView.value == "Tax")
                            Text(
                              ksTaxInfo.tr,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                          if (dashboardController.payoutTypeView.value == "Bank Account")
                            Text(
                              ksBankAccount.tr,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                          if (dashboardController.payoutTypeView.value == "Passport")
                            Text(
                              ksPassportVerification.tr,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                          if (dashboardController.payoutTypeView.value == "NID")
                            Text(
                              ksNidVerification.tr,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                          if (dashboardController.payoutTypeView.value == "Student Id")
                            Text(
                              ksStudentIdVerification.tr,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                          kH16sizedBox,
                          const PayoutText(
                            titleText: ksCountry,
                            subtitleText: "Bangladesh",
                          ),
                          kH12sizedBox,
                          if (dashboardController.payoutTypeView.value == "Tax")
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PayoutText(
                                  titleText: ksName,
                                  subtitleText: "Wahid Murad",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksTaxId,
                                  subtitleText: "fer44545fg4",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksStatus,
                                  subtitleText: "Verified",
                                  subtitleTextColor: cGreenColor,
                                ),
                              ],
                            ),
                          if (dashboardController.payoutTypeView.value == "Bank Account")
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PayoutText(
                                  titleText: ksAccountHolderName,
                                  subtitleText: "Wahid Murad",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksSWIFTCode,
                                  subtitleText: "fer44545fg4",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksAccountNumber,
                                  subtitleText: "23498756309876",
                                  subtitleTextColor: cBlackColor,
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksRoutingNumber,
                                  subtitleText: "fjdhfg8e9859juifnfgdjfgkdjfg8e4ur9",
                                  subtitleTextColor: cBlackColor,
                                ),
                              ],
                            ),
                          if (dashboardController.payoutTypeView.value == "Passport")
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PayoutText(
                                  titleText: ksName,
                                  subtitleText: "${dashboardController.dashboardPassportIdentificationData.value?.firstName} ${dashboardController.dashboardPassportIdentificationData.value?.lastName}",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksPassportNumber,
                                  subtitleText: "${dashboardController.dashboardPassportIdentificationData.value?.idNumber}",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksIssueDate,
                                  subtitleText: "${dashboardController.dashboardPassportIdentificationData.value?.issueDate}",
                                  subtitleTextColor: cBlackColor,
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksEndDate,
                                  subtitleText: "${dashboardController.dashboardPassportIdentificationData.value?.endDate}",
                                  subtitleTextColor: cBlackColor,
                                ),
                                PayoutText(
                                  titleText: ksStatus,
                                  subtitleText: "${dashboardController.dashboardPassportIdentificationData.value?.status}",
                                  subtitleTextColor: dashboardController.dashboardPassportIdentificationData.value?.status=='verified'?cGreenColor:cOrangeColor,
                                ),
                              ],
                            ),
                          if (dashboardController.payoutTypeView.value == "NID")
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PayoutText(
                                  titleText: ksName,
                                  subtitleText: "${dashboardController.dashboardNidIdentificationData.value?.firstName} ${dashboardController.dashboardNidIdentificationData.value?.lastName}",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksNidNumber,
                                  subtitleText: "${dashboardController.dashboardNidIdentificationData.value?.idNumber}",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksStatus,
                                  subtitleText: "${dashboardController.dashboardNidIdentificationData.value?.status}",
                                  subtitleTextColor: dashboardController.dashboardNidIdentificationData.value?.status=='verified'?cGreenColor:cOrangeColor,
                                ),
                              ],
                            ),
                          if (dashboardController.payoutTypeView.value == "Student Id")
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PayoutText(
                                  titleText: ksSchool,
                                  subtitleText: "${dashboardController.dashboardStudentIdIdentificationData.value?.schoolCollege}",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksName,
                                  subtitleText: "${dashboardController.dashboardStudentIdIdentificationData.value?.firstName} ${dashboardController.dashboardStudentIdIdentificationData.value?.lastName}",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksStudentId,
                                  subtitleText: "${dashboardController.dashboardStudentIdIdentificationData.value?.idNumber}",
                                ),
                                kH12sizedBox,
                                PayoutText(
                                  titleText: ksStatus,
                                  subtitleText: "${dashboardController.dashboardStudentIdIdentificationData.value?.status}",
                                  subtitleTextColor: dashboardController.dashboardStudentIdIdentificationData.value?.status=='verified'?cGreenColor:cOrangeColor,
                                ),
                              ],
                            ),
                          kH20sizedBox,
                          CustomElevatedButton(
                            buttonWidth: 76,
                            buttonColor: cRedColor,
                            prefixIcon: BipHip.deleteNew,
                            prefixIconColor: cWhiteColor,
                            textStyle: semiBold12TextStyle(cWhiteColor),
                            buttonHeight: h32,
                            label: ksDelete,
                            onPressed: () {
                              dashboardController.deleteDashboardPayoutIdentification();
                              dashboardController.payoutPassportStatus.value = "";
                              dashboardController.payoutNidStatus.value = "";
                              dashboardController.payoutStudentIdStatus.value = "";
                              dashboardController.getDashboardPayoutIdentification();
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        if (dashboardController
        .isDashboardPayoutVerificationLoading.value ==
        true)
    Positioned(
      child: CommonLoadingAnimation(
        onWillPop: () async {
          if (dashboardController
              .isDashboardPayoutVerificationLoading.value) {
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
class PayoutText extends StatelessWidget {
  const PayoutText({super.key, required this.titleText, required this.subtitleText, this.subtitleTextColor});
  final String titleText, subtitleText;
  final Color? subtitleTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText.tr,
          style: semiBold14TextStyle(cBlackColor),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          subtitleText.tr,
          style: regular12TextStyle(subtitleTextColor ?? cBlackColor),
        ),
      ],
    );
  }
}
