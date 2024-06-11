import 'package:bip_hip/utils/constants/imports.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

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
              title: ksDashboard.tr,
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
                Row(
                  children: [
                    CustomElevatedButton(
                      label: ksQuiz.tr,
                      onPressed: () {
                        Get.toNamed(krDashboardQuiz);
                      },
                      buttonColor: cWhiteColor,
                      borderColor: cLineColor,
                      buttonWidth: (width - 48) / 2,
                      buttonHeight: h60,
                      textStyle: semiBold16TextStyle(cBlackColor),
                    ),
                    kW8sizedBox,
                    CustomElevatedButton(
                      label: ksAwards.tr,
                      onPressed: () {
                        Get.toNamed(krDashboardAward);
                      },
                      buttonColor: cWhiteColor,
                      borderColor: cLineColor,
                      buttonWidth: (width - 48) / 2,
                      buttonHeight: h60,
                      textStyle: semiBold16TextStyle(cBlackColor),
                    ),
                  ],
                ),
                kH16sizedBox,
                Row(
                  children: [
                    CustomElevatedButton(
                      label: ksStar.tr,
                      onPressed: () {
                        Get.toNamed(krDashboardStar);
                      },
                      buttonColor: cWhiteColor,
                      borderColor: cLineColor,
                      buttonWidth: (width - 48) / 2,
                      buttonHeight: h60,
                      textStyle: semiBold16TextStyle(cBlackColor),
                    ),
                    kW8sizedBox,
                    CustomElevatedButton(
                      label: ksGift.tr,
                      onPressed: () {},
                      buttonColor: cWhiteColor,
                      borderColor: cLineColor,
                      buttonWidth: (width - 48) / 2,
                      buttonHeight: h60,
                      textStyle: semiBold16TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
