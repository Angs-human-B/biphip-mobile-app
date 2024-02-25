import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/pendent/pendent_page.dart';

class AllPendent extends StatelessWidget {
  AllPendent({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

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
              title: ksPendent.tr,
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
                  ksAllPendent.tr,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pendentBadgesController.allPendentList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                            crossAxisCount: 3,
                            crossAxisSpacing: k16Padding,
                            mainAxisSpacing: k16Padding,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                pendentBadgesController.pendentCheckBox.value = false;
                                pendentBadgesController.paymentCheckBox.value = false;
                                pendentBadgesController.selectedPendentIndex.value = index;
                                Get.find<GlobalController>().commonBottomSheet(
                                  context: context,
                                  bottomSheetHeight: height * 0.6,
                                  content: PurchasePendentBottomSheetContent(
                                    index: index,
                                    recommendedOrAllPendentList: pendentBadgesController.allPendentList,
                                  ),
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: () {
                                    Get.back();
                                  },
                                  rightText: "",
                                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                                  title: ksPurchasePendent.tr,
                                  isRightButtonShow: false,
                                  isScrollControlled: true,
                                );
                              },
                              child: PendentGridViewContainer(
                                index: index,
                                recommendedOrAllPendentList: pendentBadgesController.allPendentList,
                                pendentIcon: pendentBadgesController.allPendentList[index].icon,
                                pendentName: pendentBadgesController.allPendentList[index].name,
                                pendentPrice: pendentBadgesController.allPendentList[index].price.toString(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
