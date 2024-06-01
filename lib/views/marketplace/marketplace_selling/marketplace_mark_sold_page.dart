import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class MarketPlaceMarkSoldPage extends StatelessWidget {
  MarketPlaceMarkSoldPage({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();

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
              title: ksYourListing.tr,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH16sizedBox,
                Text(
                  "${ksDidYouSellThisItem.tr}?",
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  ksYourResponseWontBeSharedWithAnyoneOnBipHip.tr,
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
                kH20sizedBox,
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
                      child: Image.network(
                        "https://imgd.aeplcdn.com/1280x720/n/cw/ec/108385/ninja-zx-10r-2022-right-side-view.jpeg?isig=0",
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                        loadingBuilder: imageLoadingBuilder,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            BipHip.imageFile,
                            size: kIconSize100,
                            color: cIconColor,
                          );
                        },
                      ),
                    ),
                    kW12sizedBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH4sizedBox,
                          Text(
                            "Kawasaki Ninja® ZX™-10R | Supersport Motorcycle",
                            style: regular12TextStyle(cBlackColor),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            "\$17399",
                            style: regular12TextStyle(cSmallBodyTextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                kH60sizedBox,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: marketPlaceController.soldPlaceList.length,
                  separatorBuilder: (context, index) {
                    return CustomDivider();
                  },
                  itemBuilder: (context, index) {
                    return CustomListTile(
                      leading: Text(
                        marketPlaceController.soldPlaceList[index],
                        style: regular14TextStyle(cBlackColor),
                      ),
                      onPressed: () {
                        marketPlaceController.selectedSoldPlaceValue.value = marketPlaceController.soldPlaceList[index];
                        marketPlaceController.selectedSoldPlaceIndex.value = index;
                      },
                      trailing: Obx(() => CustomRadioButton(
                            onChanged: () {
                              marketPlaceController.selectedSoldPlaceValue.value = marketPlaceController.soldPlaceList[index];
                              marketPlaceController.selectedSoldPlaceIndex.value = index;
                            },
                            isSelected: marketPlaceController.selectedSoldPlaceIndex.value == index,
                          )),
                    );
                  },
                ),
                const Spacer(),
                Obx(() => CustomElevatedButton(
                      label: ksSubmit.tr,
                      onPressed: marketPlaceController.selectedSoldPlaceIndex.value == -1 ? null : () {},
                      buttonWidth: width - 40,
                      buttonHeight: h32,
                    )),
                kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
