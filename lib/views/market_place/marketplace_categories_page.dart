import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class MarketPlaceCategoriesPage extends StatelessWidget {
  MarketPlaceCategoriesPage({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksCategories.tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
          },
          action: const [
            Padding(
              padding: EdgeInsets.only(right: k20Padding),
              child: Icon(
                BipHip.search,
                color: cBlackColor,
                size: kIconSize20,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k16Padding),
            child: Text(
              ksTopCategories.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: marketPlaceController.topCategoriesList.length,
                        separatorBuilder: (context, index) => kH16sizedBox,
                        itemBuilder: (context, index) {
                          return CategoriesListItemContent(
                            width: 30,
                            height: 30,
                            image: marketPlaceController.topCategoriesList[index]["image"],
                            title: marketPlaceController.topCategoriesList[index]["title"],
                          );
                        }),
                  ),
                  kH16sizedBox,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: CustomDivider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: k20Padding, right: k20Padding, top: k16Padding),
                    child: Text(
                      ksAllCategories.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: k16Padding, left: k20Padding, right: k20Padding),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: marketPlaceController.allCategoriesList.length,
                        separatorBuilder: (context, index) => kH16sizedBox,
                        itemBuilder: (context, index) {
                          return CategoriesListItemContent(
                            width: 30,
                            height: 30,
                            image: marketPlaceController.allCategoriesList[index]["image"],
                            title: marketPlaceController.allCategoriesList[index]["title"],
                          );
                        }),
                  ),
                  kH16sizedBox,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesListItemContent extends StatelessWidget {
  const CategoriesListItemContent({super.key, this.width, this.height, this.image, this.title});
  final double? width, height;
  final String? image, title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: cNeutralColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.network(
              image ?? "",
              width: h20,
              height: h20,
              loadingBuilder: smallImageLoadingBuilder,
              errorBuilder: (context, error, stackTrace) => const Icon(
                BipHip.imageFile,
                size: kIconSize20,
                color: cIconColor,
              ),
            ),
          ),
        ),
        kW12sizedBox,
        Text(
          title ?? ksNA,
          style: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}
