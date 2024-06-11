import 'package:bip_hip/utils/constants/imports.dart';

class MarketPlaceNotification extends StatelessWidget {
  const MarketPlaceNotification({super.key});

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
              title: ksNotification.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            children: [
              Center(child: EmptyNotificationView()),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyNotificationView extends StatelessWidget {
  const EmptyNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: k140Padding),
      child: Column(
        children: [
          const Icon(
            BipHip.report,
            color: cIconColor,
            size: 130,
          ),
          kH16sizedBox,
          Text(
            ksNoNotificationAvailable.tr,
            style: semiBold18TextStyle(cSmallBodyTextColor),
          ),
          kH4sizedBox,
          Text(
            "${ksYouDontHaveAnyNotification.tr}.",
            style: regular12TextStyle(cSmallBodyTextColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          )
        ],
      ),
    );
  }
}
