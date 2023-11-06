import 'package:bip_hip/utils/constants/imports.dart';

class FriendFamilyButtonAction extends StatelessWidget {
  const FriendFamilyButtonAction({
    super.key,
    required this.backgroundImage,
    required this.name,
    this.firstButtonText,
    this.secondButtonText,
    this.firstButtonOnPressed,
    this.secondButtonOnPressed,
    this.icon,
    this.subTitle,
    this.imageSize,
  });
  final String backgroundImage;
  final double? imageSize;
  final String name;
  final String? firstButtonText;
  final String? secondButtonText;
  final VoidCallback? firstButtonOnPressed;
  final VoidCallback? secondButtonOnPressed;
  final IconData? icon;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
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
        Padding(
          padding: const EdgeInsets.only(left: k12Padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: semiBold16TextStyle(cBlackColor),
              ),
              kH4sizedBox,
              Row(
                children: [
                  icon == null
                      ? const SizedBox()
                      : Icon(
                          icon,
                          size: kIconSize12,
                          color: cRedColor,
                        ),
                  if (icon != null) kW4sizedBox,
                  subTitle == null
                      ? const SizedBox()
                      : Text(
                          subTitle ?? '',
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                ],
              ),
              kH4sizedBox,
              Row(
                children: [
                  if (firstButtonText != null)
                    CustomElevatedButton(
                      buttonWidth: isDeviceScreenLarge() ? 108 : 112,
                      buttonHeight: 30,
                      label: firstButtonText!,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                      onPressed: firstButtonOnPressed,
                    ),
                  if (secondButtonText != null)
                    Padding(
                      padding: const EdgeInsets.only(left: k20Padding),
                      child: CustomElevatedButton(
                        buttonWidth: isDeviceScreenLarge() ? 112 : 120,
                        buttonHeight: 30,
                        label: secondButtonText!,
                        onPressed: secondButtonOnPressed,
                        buttonColor: cWhiteColor,
                        borderColor: cRedColor,
                        textStyle: semiBold16TextStyle(cRedColor),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
