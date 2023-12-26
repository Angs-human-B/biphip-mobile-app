import 'package:bip_hip/utils/constants/imports.dart';

class FriendFamilySingleButtonAction extends StatelessWidget {
  const FriendFamilySingleButtonAction({
    super.key,
    required this.backgroundImage,
    required this.name,
    required this.buttonText,
    required this.buttonOnPressed,
    this.buttonColor,
    this.textStyle,
    this.buttonWidth,
    this.borderColor,
    this.buttonHeight,
    this.subTitle,
    this.imageSize,
  });
  final String backgroundImage;
  final String name;
  final String buttonText;
  final VoidCallback buttonOnPressed;
  final Color? buttonColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? subTitle;
  final double? imageSize;
  // final BoxDecoration boxDecoration;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: imageSize ?? h40,
              width: imageSize ?? h40,
              decoration: const BoxDecoration(
                color: cWhiteColor,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(kiProfileDefaultImageUrl);
                  },
                  loadingBuilder: imageLoadingBuilder,
                ),
              ),
            ),
            kW12sizedBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  subTitle == null
                      ? const SizedBox()
                      : Text(
                          subTitle ?? '',
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                ],
              ),
            ),
            kW20sizedBox,
            CustomElevatedButton(
              label: buttonText,
              onPressed: buttonOnPressed,
              buttonColor: buttonColor,
              textStyle: textStyle,
              buttonHeight: buttonHeight ?? 32,
              buttonWidth: buttonWidth ?? (isDeviceScreenLarge() ? 108 : 112),
              borderColor: borderColor,
            ),
          ],
        ),
      ],
    );
  }
}
