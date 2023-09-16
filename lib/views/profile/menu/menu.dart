import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cGreyBoxColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cGreyBoxColor,
              title: ksMenu.tr,
              hasBackButton: false,
              isCenterTitle: false,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(padding: const EdgeInsets.only(right: 8.0), child: IconButton(onPressed: () {}, icon: const Icon(BipHip.search))),
              ],
            ),
          ),
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH20sizedBox,
                    CustomMenuContainer(
                      height: 64,
                      leading: ClipOval(
                        child: Container(
                          height: h40,
                          width: h40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/profilePic.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      text: 'Aminul Islam Rana',
                      textStyle: semiBold18TextStyle(cBlackColor),
                    ),
                    kH25sizedBox,
                    Text(
                      'All shortcuts',
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH16sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.friends,
                            color: cPrimaryColor,
                          ),
                          text: 'Friends',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        ),
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.removeFamily,
                            color: cPrimaryColor,
                          ),
                          text: 'Family',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        )
                      ],
                    ),
                    kH16sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.imageFile,
                            color: cPrimaryColor,
                          ),
                          text: 'Images',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        ),
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.playNew,
                            color: cPrimaryColor,
                          ),
                          text: 'Videos',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        )
                      ],
                    ),
                    kH16sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.giftNew,
                            color: cPrimaryColor,
                          ),
                          text: 'Stars',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        ),
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.friends,
                            color: cPrimaryColor,
                          ),
                          text: 'Family',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        )
                      ],
                    ),
                    kH16sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.friends,
                            color: cPrimaryColor,
                          ),
                          text: 'Friends',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        ),
                        CustomMenuContainer(
                          height: 64,
                          width: (width / 2) - (kHorizontalPadding + 9),
                          leading: const Icon(
                            BipHip.removeFamily,
                            color: cPrimaryColor,
                          ),
                          text: 'Family',
                          textStyle: semiBold16TextStyle(cBlackColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomMenuContainer extends StatelessWidget {
  const CustomMenuContainer({super.key, required this.leading, required this.text, required this.textStyle, this.height, this.width, this.onPressed});

  final Widget leading;
  final double? height, width;
  final VoidCallback? onPressed;
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k12CircularBorderRadius, border: Border.all(color: cLineColor)),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: k12Padding),
              child: leading,
            ),
            Text(
              text,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
