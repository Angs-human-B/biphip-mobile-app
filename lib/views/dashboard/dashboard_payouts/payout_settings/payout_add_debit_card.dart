import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class PayoutAddDebitCard extends StatelessWidget {
  PayoutAddDebitCard({super.key});
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
            child: SizedBox(
              height: height - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    kH16sizedBox,
                    Text(
                      ksAddDebitOrCreditCard.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksToReceiveMoneyDirectlyToYourDebitOrCreditCard.tr,
                      style: regular14TextStyle(cSmallBodyTextColor),
                    ),
                    kH16sizedBox,
                    const CustomDivider(),
                    kH16sizedBox,
                    CustomModifiedTextField(
                      hint: ksCardNumber.tr,
                      fillColor: cWhiteColor,
                      controller: dashboardController.cardNumberTextEditingController,
                      inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      contentPadding: const EdgeInsets.all(k12Padding),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                      ),
                    ),
                    kH8sizedBox,
                    Row(
                      children: [
                        Expanded(
                          child: CustomModifiedTextField(
                            hint: ksExpirationDate.tr,
                            fillColor: cWhiteColor,
                            controller: dashboardController.cardExpirationDateTextEditingController,
                            inputType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            contentPadding: const EdgeInsets.all(k12Padding),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                            ),
                          ),
                        ),
                        kW16sizedBox,
                        Expanded(
                          child: CustomModifiedTextField(
                            hint: ksCVV.tr,
                            fillColor: cWhiteColor,
                            controller: dashboardController.cardCVVTextEditingController,
                            inputType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 3,
                            contentPadding: const EdgeInsets.all(k12Padding),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    kH8sizedBox,
                    CustomModifiedTextField(
                      hint: ksBillingAddress.tr,
                      fillColor: cWhiteColor,
                      controller: dashboardController.billingAddressTextEditingController,
                      inputType: TextInputType.number,
                      contentPadding: const EdgeInsets.all(k12Padding),
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
