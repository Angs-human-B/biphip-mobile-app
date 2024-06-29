import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class PayoutAddCrypto extends StatelessWidget {
  PayoutAddCrypto({super.key});
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
                      ksAddCrypto.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksToReceiveMoneyDirectlyToYourCryptoWallet.tr,
                      style: regular14TextStyle(cSmallBodyTextColor),
                    ),
                    kH16sizedBox,
                    const CustomDivider(),
                    kH16sizedBox,
                    CustomModifiedTextField(
                      hint: "USDT (BEP20)", //!Change it
                      fillColor: cWhiteColor,
                      controller: dashboardController.cryptoAmountTextEditingController,
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
                      hint: ksWriteCryptoAccountInfo.tr, //!Change it
                      fillColor: cWhiteColor,
                      controller: dashboardController.cryptoAccountNumberTextEditingController,
                      inputType: TextInputType.text,
                      contentPadding: const EdgeInsets.all(k12Padding),
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
