import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class DashboardDonation extends StatelessWidget {
  DashboardDonation({super.key});
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
              title: ksDonation.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                TapAbleButtonContainer(
                  buttonText: dashboardController.donationTapButtonText,
                  buttonState: dashboardController.donationTapButtonState,
                  buttonPress: RxList([
                    () {
                      unFocus(context);
                      dashboardController.dashboardIDonatedTapableButtonOnPressed();
                    },
                    () {
                      unFocus(context);
                      dashboardController.dashboardMyDonationTapableButtonOnPressed();
                    },
                  ]),
                ),
                kH16sizedBox,
                Container(
                    width: width - 40,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: cLineColor2),
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                    ),
                    child: EmptyView(title: ksYouHaveNothingInDonation.tr)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
