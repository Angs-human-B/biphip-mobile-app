import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_star/dashboard_star.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPayouts extends StatelessWidget {
  DashboardPayouts({super.key});
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
                  children: [
                    kH16sizedBox,
                    TapAbleButtonContainer(
                      buttonText: dashboardController.payoutsTapButtonText,
                      buttonState: dashboardController.payoutsTapButtonState,
                      buttonPress: RxList([
                        () {
                          dashboardController.payoutsOverviewTapableButtonOnPressed();
                        },
                        () async {
                          dashboardController.payoutsTransectionsTapableButtonOnPressed();
                        },
                        () {
                          dashboardController.payoutsSettingsTapableButtonOnPressed();
                        },
                      ]),
                    ),
                    if (dashboardController.payoutsTapButtonState[0])
                      SizedBox(
                        height: height - (kAppBarSize + 30 + 16 + MediaQuery.of(context).padding.top),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              kH16sizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  DashboardCommonContainer(
                                    width: (width - 52) / 2,
                                    titleText: ksTotalEarning.tr,
                                    totalValue: "\$${dashboardController.dashboardPayoutEarningInsightData.value?.totalEarning.toString()}",
                                    percentTextColor: cGreenColor,
                                  ),
                                  kW8sizedBox,
                                  DashboardCommonContainer(
                                    width: (width - 52) / 2,
                                    titleText: ksTotalWithdraw.tr,
                                    totalValue: "\$${dashboardController.dashboardPayoutEarningInsightData.value?.totalWithdraw.toString()}",
                                  ),
                                ],
                              ),
                              kH20sizedBox,
                              dashboardController.isEarningReportAvailable.value
                                  ? Container(
                                      width: width - 40,
                                      decoration: BoxDecoration(
                                        color: cWhiteColor,
                                        border: Border.all(width: 1, color: cLineColor),
                                        borderRadius: BorderRadius.circular(k8BorderRadius),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: cLineColor,
                                            blurRadius: 4,
                                            spreadRadius: 1.5,
                                            offset: Offset(
                                              0,
                                              1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(k12Padding),
                                        child: StarGiftReport(
                                          title: ksEarningReport.tr,
                                          apiData: dashboardController.dashboardPayoutEarningInsightData.value!.earningReport!,
                                          containerRightText: "\$${dashboardController.dashboardPayoutEarningInsightData.value?.totalEarning.toString()}",
                                        ),
                                      ),
                                    )
                                  : const PayoutOverviewEmptyView(),
                              kH16sizedBox,
                              dashboardController.isWithdrawReportAvailable.value
                                  ? PayoutsEarningReport(
                                      titleText: ksWithdrawReport.tr,
                                      subTitleText: "From last 12 Months",
                                      amount: "\$170",
                                      barChartColor: cOrangeColor,
                                    )
                                  : EmptyViewContainer(
                                      titleText: ksNoWithdrawAvailable.tr,
                                      titleTextStyle: semiBold16TextStyle(cBlackColor),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    if (dashboardController.payoutsTapButtonState[1])
                      SizedBox(
                        height: height - (kAppBarSize + 30 + 16 + MediaQuery.of(context).padding.top),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              kH16sizedBox,
                              Obx(() => PayoutTransectionTopContainer(
                                    title: ksAvailableAmount.tr,
                                    amount: "\$370",
                                    buttonText: dashboardController.withdrawHistoryList.isEmpty ? ksVerify.tr : ksWithdraw.tr,
                                    buttonOnPressed: () {
                                      dashboardController.payoutWithdrawTextEditingController.clear();
                                      dashboardController.isdashboardPayoutWithdraw.value = false;
                                      Get.toNamed(krDshboardPayoutWithdraw);
                                    },
                                  )),
                              kH16sizedBox,
                              if (dashboardController.withdrawHistoryList.isEmpty)
                                EmptyViewContainer(
                                  titleText: ksNoWithdrawAvailable.tr,
                                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                                ),
                              if (dashboardController.withdrawHistoryList.isNotEmpty)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ksWithdrawHistory.tr,
                                          style: semiBold18TextStyle(cBlackColor),
                                        ),
                                        InkWell(
                                            child: Text(
                                          ksSeeAll.tr,
                                          style: regular16TextStyle(cPrimaryColor),
                                        )),
                                      ],
                                    ),
                                    kH16sizedBox,
                                    Table(
                                      border: TableBorder.all(width: 0, color: cTransparentColor),
                                      children: [
                                        TableRow(
                                          children: [
                                            Text(ksDate.tr, style: semiBold14TextStyle(cBlackColor)),
                                            Text(ksPayment.tr, style: semiBold14TextStyle(cBlackColor)),
                                            Text(ksWithdraeAmount.tr, style: semiBold14TextStyle(cBlackColor)),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(ksAvailable.tr, style: semiBold14TextStyle(cBlackColor)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    kH16sizedBox,
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: dashboardController.withdrawHistoryList.length,
                                        separatorBuilder: (context, index) => kH16sizedBox,
                                        itemBuilder: (context, index) {
                                          return Table(
                                            border: TableBorder.all(width: 0, color: cTransparentColor),
                                            children: [
                                              TableRow(
                                                children: [
                                                  Text(dashboardController.withdrawHistoryList[index]["date"], style: regular12TextStyle(cBlackColor)),
                                                  Text(dashboardController.withdrawHistoryList[index]["payment"], style: regular12TextStyle(cBlackColor)),
                                                  Text(
                                                    "\$${dashboardController.withdrawHistoryList[index]["withdrawAmount"]}",
                                                    style: regular12TextStyle(cBlackColor),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: k8Padding),
                                                        child: Text("\$${dashboardController.withdrawHistoryList[index]["availableAmount"]}",
                                                            style: regular12TextStyle(cBlackColor)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    if (dashboardController.payoutsTapButtonState[2])
                      SizedBox(
                        height: height - (kAppBarSize + 30 + 16 + MediaQuery.of(context).padding.top),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: k20Padding),
                            child: Column(
                              children: [
                                dashboardController.payoutBankAccountList.isEmpty
                                    ? DashboardPayoutSettingCommonContainer(
                                        prefixIcon: BipHip.add_1,
                                        titleText: "$ksNoBankAccountInformationAddedYet!",
                                        buttonOnPressed: () {
                                          Get.find<GlobalController>().commonBottomSheet(
                                              context: context,
                                              content: Column(
                                                children: [],
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () {
                                                Get.back();
                                              },
                                              rightText: "",
                                              rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                              title: ksAddPayoutMethod.tr,
                                              isRightButtonShow: false,
                                              isBottomSheetRightButtonActive: false.obs);
                                        },
                                      )
                                    : Container(
                                        width: width - 40,
                                        decoration: BoxDecoration(
                                          color: cPrimaryTint4Color,
                                          border: Border.all(color: cPrimaryTint1Color, width: 1),
                                          borderRadius: BorderRadius.circular(k8BorderRadius),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(k16Padding),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ksPayoutMethod,
                                                style: semiBold16TextStyle(cBlackColor),
                                              ),
                                              kH12sizedBox,
                                              ListView.separated(
                                                separatorBuilder: (context, index) => kH12sizedBox,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: dashboardController.payoutBankAccountList.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      dashboardController.payoutTypeView.value = "Bank Account";
                                                      Get.toNamed(krPayoutBankAccountTaxPassportInfoView);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: cWhiteColor,
                                                        borderRadius: BorderRadius.circular(k4BorderRadius),
                                                        border: Border.all(color: cLineColor2, width: 1),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(k4Padding),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                width: h44,
                                                                height: h44,
                                                                decoration: const BoxDecoration(
                                                                  color: cGreyBoxColor,
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: const Icon(
                                                                  BipHip.badgesOutline,
                                                                  size: kIconSize20,
                                                                  color: cIconColor,
                                                                )),
                                                            kW8sizedBox,
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  dashboardController.payoutBankAccountList[index]["accountName"],
                                                                  style: regular14TextStyle(cBlackColor),
                                                                ),
                                                                kH4sizedBox,
                                                                Text(
                                                                  dashboardController.payoutBankAccountList[index]["bankName"],
                                                                  style: regular14TextStyle(cBlackColor),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              kH16sizedBox,
                                              CustomElevatedButton(
                                                  buttonWidth: 68,
                                                  buttonHeight: h32,
                                                  prefixIconSize: kIconSize16,
                                                  label: ksAdd.tr,
                                                  prefixIcon: BipHip.add_1,
                                                  prefixIconColor: cWhiteColor,
                                                  textStyle: semiBold12TextStyle(cWhiteColor),
                                                  onPressed: () {
                                                    Get.find<GlobalController>().commonBottomSheet(
                                                        context: context,
                                                        bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                                                        content: const AddPayoutMethodBottomSheetContent(),
                                                        onPressCloseButton: () {
                                                          Get.back();
                                                        },
                                                        onPressRightButton: () {
                                                          Get.back();
                                                        },
                                                        rightText: "",
                                                        rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                                        title: ksAddPayoutMethod.tr,
                                                        isRightButtonShow: false,
                                                        isBottomSheetRightButtonActive: false.obs);
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                kH16sizedBox,
                                dashboardController.payoutTaxInformationStatus.value == ""
                                    ? DashboardPayoutSettingCommonContainer(
                                        prefixIcon: BipHip.add_1,
                                        titleText: "$ksNoTaxInformationAddedYet!",
                                        buttonOnPressed: () {
                                          Get.toNamed(krPayoutTaxInfo);
                                        },
                                      )
                                    : DashboardPayoutSettingContentContainer(
                                        icon: BipHip.badgesFill,
                                        statusText: dashboardController.payoutTaxInformationStatus.value,
                                        titleText: ksTaxInformation.tr,
                                        dateText: "Updated 8 Aug 2023",
                                        statusTextStyle: regular14TextStyle(cGreenColor),
                                        containerOnPressed: () {
                                          dashboardController.payoutTypeView.value = "Tax";
                                          Get.toNamed(krPayoutBankAccountTaxPassportInfoView);
                                        },
                                      ),
                                kH16sizedBox,
                                dashboardController.payoutPassportStatus.value == ""
                                    ? DashboardPayoutSettingCommonContainer(
                                        prefixIcon: BipHip.add_1,
                                        titleText: "$ksNoPassportOrNidOrStudentIdAddedYet!",
                                        buttonOnPressed: () {
                                          Get.find<GlobalController>().commonBottomSheet(
                                              context: context,
                                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.35 : height * 0.45,
                                              content: const AddPassportNidStudentIdBottomSheetContent(),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () {
                                                Get.back();
                                              },
                                              rightText: "",
                                              rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                                              title: ksAddPayoutMethod.tr,
                                              isRightButtonShow: false,
                                              isBottomSheetRightButtonActive: false.obs);
                                        },
                                      )
                                    : DashboardPayoutSettingContentContainer(
                                        icon: BipHip.badgesFill,
                                        statusText: dashboardController.payoutPassportStatus.value,
                                        titleText: ksPassportVerification.tr,
                                        dateText: "Submitted on 8 Aug 2024.",
                                        statusTextStyle: regular14TextStyle(cSecondaryColor),
                                        containerOnPressed: () {
                                          dashboardController.payoutTypeView.value = "Passport"; //*Passport,NID, Student Id
                                          Get.toNamed(krPayoutBankAccountTaxPassportInfoView);
                                        },
                                      ),
                                kH16sizedBox,
                                Container(
                                  width: width - 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    color: cPrimaryTint4Color,
                                    border: Border.all(width: 1, color: cPrimaryTint1Color),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(k16Padding),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ksPayoutAccountInfo.tr,
                                          style: semiBold16TextStyle(cBlackColor),
                                        ),
                                        kH12sizedBox,
                                        Text(
                                          ksCountry.tr,
                                          style: semiBold14TextStyle(cBlackColor),
                                        ),
                                        kH4sizedBox,
                                        Text(
                                          "Bangladesh",
                                          style: regular12TextStyle(cBlackColor),
                                        ),
                                        kH12sizedBox,
                                        Text(
                                          ksBusinessPhoneNumber.tr,
                                          style: semiBold14TextStyle(cBlackColor),
                                        ),
                                        kH4sizedBox,
                                        Row(
                                          children: [
                                            Text(
                                              "01642318836",
                                              style: regular12TextStyle(cBlackColor),
                                            ),
                                            kW4sizedBox,
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: const BoxDecoration(
                                                color: cIconColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            kW4sizedBox,
                                            Text(
                                              ksVerified.tr,
                                              style: regular14TextStyle(cGreenColor),
                                            ),
                                          ],
                                        ),
                                        kH12sizedBox,
                                        Text(
                                          ksEmailAddress.tr,
                                          style: semiBold14TextStyle(cBlackColor),
                                        ),
                                        kH4sizedBox,
                                        Text(
                                          "genieuiux@gmail.com",
                                          style: regular12TextStyle(cBlackColor),
                                        ),
                                        kH20sizedBox,
                                        CustomElevatedButton(
                                          buttonWidth: 80,
                                          buttonHeight: h32,
                                          label: ksUpdate.tr,
                                          onPressed: () {
                                            Get.toNamed(krPayoutBusinessInfo);
                                          },
                                          prefixIcon: BipHip.edit,
                                          prefixIconColor: cWhiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                kH20sizedBox,
                              ],
                            ),
                          ),
                        ),
                      ),
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

class PayoutTransectionTopContainer extends StatelessWidget {
  const PayoutTransectionTopContainer({super.key, this.title, this.amount, this.buttonText, this.buttonOnPressed});
  final String? title, amount, buttonText;
  final VoidCallback? buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 76,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: regular14TextStyle(cBlackColor),
                ),
                kH8sizedBox,
                Text(
                  amount ?? "",
                  style: semiBold18TextStyle(cBlackColor),
                ),
              ],
            ),
            CustomElevatedButton(
              label: buttonText ?? "",
              onPressed: buttonOnPressed,
              buttonColor: cPrimaryColor,
              textStyle: regular14TextStyle(cWhiteColor),
              buttonWidth: 80,
              buttonHeight: h32,
            ),
          ],
        ),
      ),
    );
  }
}

class PayoutOverviewEmptyView extends StatelessWidget {
  const PayoutOverviewEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 190,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${ksYouHavenotEarned.tr}.",
            style: semiBold16TextStyle(cBlackColor),
          ),
          Padding(
            padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k4Padding),
            child: Text(
              ksPleaseBeActiveInPostingAndEarnEveryday.tr,
              style: regular14TextStyle(cSmallBodyTextColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyViewContainer extends StatelessWidget {
  const EmptyViewContainer({super.key, required this.titleText, this.titleTextStyle});
  final String titleText;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 190,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: EmptyView(
        title: titleText,
        titleTextStyle: titleTextStyle ?? semiBold16TextStyle(cBlackColor),
      ),
    );
  }
}

class PayoutCommonContainer extends StatelessWidget {
  const PayoutCommonContainer({super.key, this.containerWidth, required this.titleText, required this.subtitleText, this.containerOnPressed});
  final double? containerWidth;
  final String titleText, subtitleText;
  final VoidCallback? containerOnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: containerOnPressed,
      child: Container(
        width: containerWidth ?? width - 40,
        decoration: BoxDecoration(
          color: cPrimaryTint4Color,
          border: Border.all(width: 1, color: cLineColor2),
          borderRadius: BorderRadius.circular(k4BorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(k8Padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: semiBold16TextStyle(cBlackColor),
              ),
              kH4sizedBox,
              Text(
                subtitleText,
                style: regular12TextStyle(cPlaceHolderColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPayoutMethodBottomSheetContent extends StatelessWidget {
  const AddPayoutMethodBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PayoutCommonContainer(
          titleText: ksManualLinkBankAccount.tr,
          subtitleText: ksEnterYourBankAccountInfo.tr,
          containerOnPressed: () {
            Get.back();
            Get.toNamed(krPayoutManualLinkBankAccount);
          },
        ),
        kH12sizedBox,
        PayoutCommonContainer(
          titleText: ksLinkYourPaypalAccount.tr,
          subtitleText: ksLinkYourPaypalAccountToReceiveMoney.tr,
          containerOnPressed: () {},
        ),
        kH12sizedBox,
        PayoutCommonContainer(
          titleText: ksAddMobileBanking.tr,
          subtitleText: ksAddYourAvailableMobileBanking.tr,
          containerOnPressed: () {},
        ),
        kH12sizedBox,
        PayoutCommonContainer(
          titleText: ksAddCrypto.tr,
          subtitleText: ksToReceiveMoneyDirectlyToYourCryptoWallet.tr,
          containerOnPressed: () {
            Get.back();
            Get.toNamed(krPayoutAddCrypto);
          },
        ),
        kH12sizedBox,
        PayoutCommonContainer(
          titleText: ksAddDebitOrCreditCard.tr,
          subtitleText: ksToReceiveMoneyDirectlyToYourDebitOrCreditCard.tr,
          containerOnPressed: () {
            Get.back();
            Get.toNamed(krPayoutAddDebitCard);
          },
        ),
      ],
    );
  }
}

class AddPassportNidStudentIdBottomSheetContent extends StatelessWidget {
  const AddPassportNidStudentIdBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PayoutCommonContainer(
          titleText: ksPassport.tr,
          subtitleText: "${ksAddYourPassportInformation.tr}.",
          containerOnPressed: () {
            Get.back();
            Get.toNamed(krPayoutPassportVerification);
          },
        ),
        kH12sizedBox,
        PayoutCommonContainer(
          titleText: ksNID.tr,
          subtitleText: "${ksAddYourNIDInformation.tr}.",
          containerOnPressed: () {
            Get.back();
            Get.toNamed(krPayoutNidVerification);
          },
        ),
        kH12sizedBox,
        PayoutCommonContainer(
          titleText: ksStudentId.tr,
          subtitleText: "${ksAddYourStudentIdInformation.tr}.",
          containerOnPressed: () {
            Get.back();
            Get.toNamed(krPayoutStudentIdVerification);
          },
        ),
      ],
    );
  }
}

class DashboardPayoutSettingContentContainer extends StatelessWidget {
  const DashboardPayoutSettingContentContainer(
      {super.key,
      required this.statusText,
      required this.icon,
      required this.titleText,
      required this.statusTextStyle,
      required this.dateText,
      this.containerOnPressed});
  final String statusText, titleText, dateText;
  final IconData icon;
  final TextStyle statusTextStyle;
  final VoidCallback? containerOnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: containerOnPressed,
      child: Container(
        width: width - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          color: cPrimaryTint4Color,
          border: Border.all(width: 1, color: cPrimaryTint1Color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(k16Padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: semiBold16TextStyle(cBlackColor),
              ),
              kH12sizedBox,
              Container(
                decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  border: Border.all(width: 1, color: cLineColor2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(k4Padding),
                  child: Row(
                    children: [
                      Container(
                        width: h44,
                        height: h44,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cGreyBoxColor,
                        ),
                        child: Icon(
                          icon,
                          color: cIconColor,
                          size: kIconSize20,
                        ),
                      ),
                      kW8sizedBox,
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              statusText,
                              style: statusTextStyle,
                              overflow: TextOverflow.clip,
                            ),
                            kW4sizedBox,
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(color: cIconColor, shape: BoxShape.circle),
                            ),
                            kW4sizedBox,
                            Expanded(
                              child: Text(
                                dateText,
                                style: regular14TextStyle(cBlackColor),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPayoutSettingCommonContainer extends StatelessWidget {
  const DashboardPayoutSettingCommonContainer({super.key, required this.prefixIcon, required this.titleText, this.buttonOnPressed});
  final IconData prefixIcon;
  final String titleText;
  final VoidCallback? buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        color: cPrimaryTint4Color,
        border: Border.all(width: 1, color: cPrimaryTint1Color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: k16Padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleText,
              style: semiBold16TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            CustomElevatedButton(
                buttonWidth: 68,
                buttonHeight: h32,
                prefixIconSize: kIconSize16,
                label: ksAdd.tr,
                prefixIcon: prefixIcon,
                prefixIconColor: cWhiteColor,
                textStyle: semiBold12TextStyle(cWhiteColor),
                onPressed: buttonOnPressed),
          ],
        ),
      ),
    );
  }
}

class DashboardCommonContainer extends StatelessWidget {
  const DashboardCommonContainer(
      {super.key, this.width, this.height, required this.titleText, required this.totalValue, this.percentValue, this.percentTextColor});
  final double? width, height;
  final String titleText, totalValue;
  final String? percentValue;
  final Color? percentTextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: regular14TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  totalValue,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kW4sizedBox,
                if (percentValue != null)
                  Text(
                    percentValue!,
                    style: regular14TextStyle(percentTextColor ?? cBlackColor),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PayoutsEarningReport extends StatelessWidget {
  const PayoutsEarningReport({super.key, required this.titleText, required this.amount, required this.subTitleText, this.barChartColor});
  final String titleText, amount, subTitleText;
  final Color? barChartColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 280,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleText,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Text(
                  amount,
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            Text(
              subTitleText,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH20sizedBox,
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 400,
                  barGroups: [
                    makeGroupData(0, 200),
                    makeGroupData(1, 100),
                    makeGroupData(2, 200),
                    makeGroupData(3, 300),
                    makeGroupData(4, 200),
                    makeGroupData(5, 100),
                    makeGroupData(6, 100),
                    makeGroupData(7, 200),
                    makeGroupData(8, 150),
                    makeGroupData(9, 200),
                    makeGroupData(10, 250),
                    makeGroupData(11, 100),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          );
                          Widget text;
                          switch (value.toInt()) {
                            case 0:
                              text = const Text('Jan', style: style);
                              break;
                            case 1:
                              text = const Text('Feb', style: style);
                              break;
                            case 2:
                              text = const Text('Mar', style: style);
                              break;
                            case 3:
                              text = const Text('Apr', style: style);
                              break;
                            case 4:
                              text = const Text('May', style: style);
                              break;
                            case 5:
                              text = const Text('Jun', style: style);
                              break;
                            case 6:
                              text = const Text('Jul', style: style);
                              break;
                            case 7:
                              text = const Text('Aug', style: style);
                              break;
                            case 8:
                              text = const Text('Sep', style: style);
                              break;
                            case 9:
                              text = const Text('Oct', style: style);
                              break;
                            case 10:
                              text = const Text('Nov', style: style);
                              break;
                            case 11:
                              text = const Text('Dec', style: style);
                              break;
                            default:
                              text = const Text('', style: style);
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 16.0,
                            child: text,
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = '0k';
                              break;
                            case 100:
                              text = '100k';
                              break;
                            case 200:
                              text = '200k';
                              break;
                            case 300:
                              text = '300k';
                              break;
                            case 400:
                              text = '400k';
                              break;
                            default:
                              return Container();
                          }
                          return Text(text, style: style);
                        },
                        reservedSize: 40,
                        interval: 100,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: const FlGridData(
                    show: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barChartColor ?? cPrimaryTint1Color,
          width: 16,
          borderRadius: BorderRadius.circular(k20BorderRadius),
        ),
      ],
    );
  }
}
