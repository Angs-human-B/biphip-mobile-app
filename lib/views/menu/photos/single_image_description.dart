import 'package:bip_hip/utils/constants/imports.dart';

class SingleImageDescription extends StatelessWidget {
  const SingleImageDescription({super.key, this.image, this.description});
  final String? image;
  final String? description;
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
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksImage.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h16),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      ksSave.tr,
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: k4Padding),
                child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () {},
                  child: Container(
                    color: cWhiteColor,
                    height: 150,
                    width: width - 40,
                    child: Image.network(
                      image!,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.imageFile,
                        size: kIconSize100,
                        color: cIconColor,
                      ),
                      loadingBuilder: imageLoadingBuilder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
