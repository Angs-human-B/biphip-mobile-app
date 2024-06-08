import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_donation/dashboard_donation.dart';

class DashboardDonatedPost extends StatelessWidget {
  DashboardDonatedPost({super.key});
  final DashboardController dashboardController = DashboardController();

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
              title: ksDonatedPost.tr,
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
              child: Column(
                children: [
                  kH16sizedBox,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardController.dashboardDonationPost.length,
                    separatorBuilder: (context, index) => kH16sizedBox,
                    itemBuilder: (context, index) {
                      return DashboardDonationContent(
                        width: width - 40,
                        height: 146,
                        productImage: dashboardController.dashboardDonationPost[index]["productImage"],
                        productTitle: dashboardController.dashboardDonationPost[index]["productTitle"],
                        postDate: dashboardController.dashboardDonationPost[index]["postDate"],
                        postCount: dashboardController.dashboardDonationPost[index]["postCount"],
                        engagementCount: dashboardController.dashboardDonationPost[index]["engagementCount"],
                        giftCount: dashboardController.dashboardDonationPost[index]["giftCount"],
                        donateAmount: dashboardController.dashboardDonationPost[index]["amount"],
                        donateText: ksDonate.tr,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
