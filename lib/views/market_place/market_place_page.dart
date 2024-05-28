import 'package:bip_hip/utils/constants/imports.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

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
    );
  }
}
