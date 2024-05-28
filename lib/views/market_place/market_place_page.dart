import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class MarketplacePage extends StatelessWidget {
  MarketplacePage({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksMarketPlace.tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
          },
          action: const [
            Icon(
              BipHip.user,
              color: cBlackColor,
              size: kIconSize20,
            ),
            Padding(
              padding: EdgeInsets.only(left: k8Padding, right: k12Padding),
              child: Icon(
                BipHip.search,
                color: cBlackColor,
                size: kIconSize20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            kH16sizedBox,
            Row(
              children: [
                TopWidgetButton(
                  width: (width - 60) / 3,
                  height: h36,
                  icon: BipHip.add,
                  text: ksBuying,
                ),
                kW8sizedBox,
                TopWidgetButton(
                  width: (width - 60) / 3,
                  height: h36,
                  icon: BipHip.add,
                  text: ksBuying,
                ),
                kW8sizedBox,
                TopWidgetButton(
                  width: (width - 60) / 3,
                  height: h36,
                  icon: BipHip.add,
                  text: ksBuying,
                ),
              ],
            ),
            kH16sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksTodayPicks.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                InkWell(
                  onTap: () {
                    Get.find<GlobalController>().commonBottomSheet(
                        context: context,
                        content: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: k8Padding, top: k16Padding),
                              child: Row(
                                children: [
                                  Container(
                                    width: h24,
                                    height: h24,
                                    decoration: const BoxDecoration(
                                      color: cNeutralColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      BipHip.location,
                                      size: kIconSize12,
                                      color: cBlackColor,
                                    ),
                                  ),
                                  kW8sizedBox,
                                  Text(
                                    "Dhaka, Bangladesh",
                                    style: semiBold14TextStyle(cPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                            kH8sizedBox,
                            CustomListTile(
                              leading: Container(
                                width: h24,
                                height: h24,
                                decoration: const BoxDecoration(
                                  color: cNeutralColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  BipHip.calendarFill,
                                  size: kIconSize12,
                                  color: cBlackColor,
                                ),
                              ),
                              title: Text(
                                ksDateListed.tr,
                                style: semiBold14TextStyle(cBlackColor),
                              ),
                              subtitle: Text(
                                ksAnyDate.tr,
                                style: regular12TextStyle(cSmallBodyTextColor),
                              ),
                            ),
                            CustomListTile(
                              leading: Container(
                                width: h24,
                                height: h24,
                                decoration: const BoxDecoration(
                                  color: cNeutralColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  BipHip.gift,
                                  size: kIconSize12,
                                  color: cBlackColor,
                                ),
                              ),
                              title: Text(
                                ksCondition.tr,
                                style: semiBold14TextStyle(cBlackColor),
                              ),
                              subtitle: Text(
                                ksAny.tr,
                                style: regular12TextStyle(cSmallBodyTextColor),
                              ),
                            ),
                          ],
                        ),
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () {},
                        rightText: ksReset.tr,
                        rightTextStyle: semiBold14TextStyle(cSmallBodyTextColor),
                        title: ksShortBy.tr,
                        isBottomSheetRightButtonActive: marketPlaceController.shortByBottomSheetState,
                        isRightButtonShow: true);
                  },
                  child: Text(
                    ksFilters.tr,
                    style: semiBold16TextStyle(cPrimaryColor),
                  ),
                ),
              ],
            ),
            kH16sizedBox,
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                      crossAxisCount: 2,
                      crossAxisSpacing: k16Padding,
                      mainAxisSpacing: k16Padding,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return MarketplaceItemContainer();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopWidgetButton extends StatelessWidget {
  const TopWidgetButton({super.key, required this.width, required this.icon, required this.text, required this.height});
  final double width, height;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        color: cNeutralColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: kIconSize12,
            color: cBlackColor,
          ),
          kW4sizedBox,
          Text(
            text,
            style: regular12TextStyle(cBlackColor),
          ),
        ],
      ),
    );
  }
}

class MarketplaceItemContainer extends StatelessWidget {
  const MarketplaceItemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
            child: Image.network(
              "https://i.ytimg.com/vi/8PCwX2wRJqQ/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDc9DBN6OTcf4xhlMroyD0IHfo1tA",
              width: 160,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          kH8sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: k8Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$129",
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Row(
                  children: [
                    const Icon(
                      BipHip.location,
                      color: cIconColor,
                      size: kIconSize12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: k2Padding),
                      child: Text(
                        "Dhaka",
                        style: regular12TextStyle(cSmallBodyTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          kH4sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: k8Padding),
            child: Text(
              "iphone x 256GB Physical Dual sim",
              style: regular12TextStyle(cBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}
