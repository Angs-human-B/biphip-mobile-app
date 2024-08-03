import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class DashboardPayoutWithdraw extends StatelessWidget {
  DashboardPayoutWithdraw({super.key});
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
              title: ksWriteWithdrawlAmount.tr,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH20sizedBox,
                  Container(
                    width: width - 40,
                    height: 84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      color: cPrimaryTint4Color,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ksAvailableAmount.tr,
                          style: regular14TextStyle(cPlaceHolderColor),
                        ),
                        kH8sizedBox,
                        Text(
                          "\$12,000",
                          style: semiBold24TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                  ),
                  kH16sizedBox,
                  Text(
                    ksWriteAmount.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  Text(
                    "You can't withdraw over XXXX amount of money in XX times in a day.",
                    style: regular12TextStyle(cPlaceHolderColor),
                  ),
                  kH8sizedBox,
                  CustomModifiedTextField(
                    prefixIcon: BipHip.donatedFill, //!Change this icon, here dollar icon
                    suffixIconColor: cAmberAccentColor,
                    controller: dashboardController.payoutWithdrawTextEditingController,
                    inputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (dashboardController.payoutWithdrawTextEditingController.text.toString().trim() == "") {
                        dashboardController.isdashboardPayoutWithdraw.value = false;
                      } else {
                        dashboardController.isdashboardPayoutWithdraw.value = true;
                      }
                    },
                    inputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                      buttonWidth: width - 40,
                      buttonHeight: h32,
                      label: ksContinue.tr,
                      onPressed: dashboardController.isdashboardPayoutWithdraw.value
                          ? () {
                              dashboardController.dashboardOtpTextEditingController.clear();
                              Get.toNamed(krDashboardFundTransferOtp);
                            }
                          : null),
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
