import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/helpers/menu/store/store_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/store/widgets/store_listview.dart';

class StorePage extends StatelessWidget {
  StorePage({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final StoreHelper storeHelper = StoreHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    title: ksStore.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: k20Padding),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            storeController.resetStoreData();
                            Get.toNamed(krAddStoreBasicInfo);
                          },
                          child: Text(
                            ksAddStore.tr,
                            style: semiBold16TextStyle(cPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: storeController.isStoreListLoading.value
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: k12Padding),
                              child: ShimmerCommon(
                                widget: Container(
                                  decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                                  height: 16,
                                  width: 120,
                                ),
                              ),
                            )
                          : storeHelper.totalStoreShow(),
                    ),
                    StoreListView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
